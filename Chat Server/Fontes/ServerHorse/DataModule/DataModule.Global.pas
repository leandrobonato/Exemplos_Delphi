unit DataModule.Global;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, System.JSON,
  DataSet.Serialize, FireDAC.DApt, DataSet.Serialize.Config;

type
  TDmGlobal = class(TDataModule)
    Conn: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure ConnBeforeConnect(Sender: TObject);
    procedure ConnAfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    function InserirMensagem(cod_usuario_de, cod_usuario_para, cod_grupo: integer;
                                   texto: string): TJSONObject;
    function ListarNovasMensagens(cod_usuario_de, cod_usuario_para, cod_mensagem: integer): TJSONArray;
    function ListarHistoricoMensagem(cod_usuario_logado: integer): TJSONArray;
    function InserirGrupo(cod_usuario: integer; nome: string;
                          membros: TJsonArray): TJSONObject;
  end;

var
  DmGlobal: TDmGlobal;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDmGlobal.ConnAfterConnect(Sender: TObject);
begin
    Conn.ExecSQL('CREATE TABLE IF NOT EXISTS TAB_USUARIO ( ' +
                            'COD_USUARIO       INTEGER NOT NULL PRIMARY KEY, ' +
                            'NOME              VARCHAR(100));'
                );

    Conn.ExecSQL('CREATE TABLE IF NOT EXISTS TAB_MENSAGEM ( ' +
                            'COD_MENSAGEM      INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ' +
                            'COD_USUARIO_DE    INTEGER, ' +
                            'COD_USUARIO_PARA  INTEGER, ' +
                            'COD_GRUPO         INTEGER, ' +
                            'DT_GERACAO        DATETIME, ' +
                            'TEXTO             VARCHAR (1000));'
                );

    Conn.ExecSQL('CREATE TABLE IF NOT EXISTS TAB_GRUPO ( ' +
                            'COD_GRUPO         INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ' +
                            'NOME              VARCHAR(50), ' +
                            'COD_USUARIO_CRIACAO INTEGER, ' +
                            'DT_GERACAO        DATETIME);'
                );

    Conn.ExecSQL('CREATE TABLE IF NOT EXISTS TAB_GRUPO_USUARIO ( ' +
                            'COD_MEMBRO        INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ' +
                            'COD_GRUPO         INTEGER, ' +
                            'COD_USUARIO       INTEGER);'
                );

    // Cadastra os usuarios...
    Conn.ExecSQL('insert or replace into tab_usuario(cod_usuario, nome) values(1, ''Heber Stein Mazutti'');');
    Conn.ExecSQL('insert or replace into tab_usuario(cod_usuario, nome) values(2, ''Tony Stark'');');
    Conn.ExecSQL('insert or replace into tab_usuario(cod_usuario, nome) values(3, ''João Alves'');');
    Conn.ExecSQL('insert or replace into tab_usuario(cod_usuario, nome) values(4, ''Ana Maria'');');

    //Conn.ExecSQL('ALTER TABLE TAB_MENSAGEM ADD COD_GRUPO INTEGER;');

    {
    INSERT INTO TAB_MENSAGEM(COD_USUARIO_DE, COD_USUARIO_PARA, DT_GERACAO, TEXTO)
    VALUES(1, 2, datetime('now', 'localtime'), 'Olá! Tudo bem?');
    }
end;

procedure TDmGlobal.ConnBeforeConnect(Sender: TObject);
begin
    Conn.DriverName := 'SQLite';
    Conn.Params.Values['Database'] := System.SysUtils.GetCurrentDir + '\banco.db';
end;

procedure TDmGlobal.DataModuleCreate(Sender: TObject);
begin
    TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
    TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';
    Conn.Connected := true;
end;

function TDmGlobal.ListarHistoricoMensagem(cod_usuario_logado: integer): TJSONArray;
var
    qry: TFDQuery;
    dt_geracao: string;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Conn;

        with qry do
        begin
            dt_geracao := FormatDateTime('yyyy-mm-dd hh:nn:ss', now);

            // Mensagens enviadas para mim...
            Active := false;
            SQL.Clear;
            SQL.Add('SELECT M.*, U.NOME, IFNULL(G.NOME, '''') AS NOME_GRUPO');
            SQL.Add('FROM TAB_MENSAGEM M');
            SQL.Add('JOIN TAB_USUARIO U ON (U.COD_USUARIO = M.COD_USUARIO_DE)');
            SQL.Add('LEFT JOIN TAB_GRUPO G ON (G.COD_GRUPO = M.COD_GRUPO)');
            SQL.Add('WHERE M.COD_USUARIO_PARA = :COD_USUARIO_LOGADO');
            SQL.Add('AND M.DT_GERACAO <= :DT_GERACAO');
            SQL.Add('ORDER BY M.COD_MENSAGEM');

            ParamByName('COD_USUARIO_LOGADO').Value := cod_usuario_logado;
            ParamByName('DT_GERACAO').Value := dt_geracao;
            Active := true;

            Result := qry.ToJSONArray;

            // Excluir as mensagens do servidor...
            Active := false;
            SQL.Clear;
            SQL.Add('DELETE FROM TAB_MENSAGEM');
            SQL.Add('WHERE COD_USUARIO_PARA = :COD_USUARIO_LOGADO');
            SQL.Add('AND DT_GERACAO <= :DT_GERACAO');
            ParamByName('COD_USUARIO_LOGADO').Value := cod_usuario_logado;
            ParamByName('DT_GERACAO').Value := dt_geracao;
            ExecSQL;
        end;
    finally
        qry.Free;
    end;
end;

function TDmGlobal.ListarNovasMensagens(cod_usuario_de, cod_usuario_para, cod_mensagem: integer): TJSONArray;
var
    qry: TFDQuery;
    dt_geracao: string;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Conn;

        with qry do
        begin
            dt_geracao := FormatDateTime('yyyy-mm-dd hh:nn:ss', now);

            // listar novas mensagens do usuario...
            Active := false;
            SQL.Clear;
            SQL.Add('SELECT M.*, U.NOME, IFNULL(G.NOME, '''') AS NOME_GRUPO');
            SQL.Add('FROM TAB_MENSAGEM M');
            SQL.Add('JOIN TAB_USUARIO U ON (U.COD_USUARIO = M.COD_USUARIO_DE)');
            SQL.Add('LEFT JOIN TAB_GRUPO G ON (G.COD_GRUPO = M.COD_GRUPO)');
            SQL.Add('WHERE M.DT_GERACAO <= :DT_GERACAO');

            ParamByName('DT_GERACAO').Value := dt_geracao;

            if cod_usuario_de > 0 then
            begin
                SQL.Add('AND M.COD_USUARIO_DE = :COD_USUARIO_DE');
                ParamByName('COD_USUARIO_DE').Value := cod_usuario_de;
            end;

            if cod_usuario_para > 0 then
            begin
                SQL.Add('AND M.COD_USUARIO_PARA = :COD_USUARIO_PARA');
                ParamByName('COD_USUARIO_PARA').Value := cod_usuario_para;
            end;

            if cod_mensagem > 0 then
            begin
                SQL.Add('AND M.COD_MENSAGEM > :COD_MENSAGEM');
                ParamByName('COD_MENSAGEM').Value := cod_mensagem;
            end;

            SQL.Add('ORDER BY M.COD_MENSAGEM');
            Active := true;

            Result := qry.ToJSONArray;


            // Excluir as mensagens do servidor...
            Active := false;
            SQL.Clear;
            SQL.Add('DELETE FROM TAB_MENSAGEM');
            SQL.Add('WHERE DT_GERACAO <= :DT_GERACAO');

            ParamByName('DT_GERACAO').Value := dt_geracao;

            if cod_usuario_de > 0 then
            begin
                SQL.Add('AND COD_USUARIO_DE = :COD_USUARIO_DE');
                ParamByName('COD_USUARIO_DE').Value := cod_usuario_de;
            end;

            if cod_usuario_para > 0 then
            begin
                SQL.Add('AND COD_USUARIO_PARA = :COD_USUARIO_PARA');
                ParamByName('COD_USUARIO_PARA').Value := cod_usuario_para;
            end;

            if cod_mensagem > 0 then
            begin
                SQL.Add('AND COD_MENSAGEM > :COD_MENSAGEM');
                ParamByName('COD_MENSAGEM').Value := cod_mensagem;
            end;

            ExecSQL;
        end;



    finally
        qry.Free;
    end;
end;

function TDmGlobal.InserirMensagem(cod_usuario_de, cod_usuario_para, cod_grupo: integer;
                                   texto: string): TJSONObject;
var
    qry: TFDQuery;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Conn;

        with qry do
        begin
            if cod_grupo = 0 then // Mensagem para um usuario especifico....
            begin
                Active := false;
                SQL.Clear;
                SQL.Add('insert into tab_mensagem(cod_usuario_de, cod_usuario_para, dt_geracao, texto, cod_grupo)');
                SQL.Add('VALUES(:cod_usuario_de, :cod_usuario_para, datetime(''now'', ''localtime''), :texto, :cod_grupo);');
                SQL.Add('select last_insert_rowid() as cod_mensagem');
                ParamByName('cod_usuario_de').Value := cod_usuario_de;
                ParamByName('cod_usuario_para').Value := cod_usuario_para;
                ParamByName('texto').Value := texto;
                ParamByName('cod_grupo').Value := cod_grupo;
                Active := true;
            end
            else
            begin
                Active := false;  // Mensagem para um grupo....
                SQL.Clear;
                SQL.Add('insert into tab_mensagem(cod_usuario_de, cod_usuario_para, dt_geracao, texto, cod_grupo)');
                SQL.Add('select :cod_usuario_de, cod_usuario, datetime(''now'', ''localtime''), :texto, cod_grupo');
                SQL.Add('from tab_grupo_usuario');
                SQL.Add('where cod_grupo = :cod_grupo');
                SQL.Add('and cod_usuario <> :cod_usuario_de;');
                SQL.Add('select last_insert_rowid() as cod_mensagem');

                ParamByName('cod_usuario_de').Value := cod_usuario_de;
                ParamByName('texto').Value := texto;
                ParamByName('cod_grupo').Value := cod_grupo;
                Active := true;
            end;
        end;

        Result := qry.ToJSONObject;

    finally
        qry.Free;
    end;
end;

function TDmGlobal.InserirGrupo(cod_usuario: integer; nome: string; membros: TJsonArray): TJSONObject;
var
    qry: TFDQuery;
    cod_grupo: integer;
    i: integer;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Conn;

        try
            //Conn.StartTransaction;

            with qry do
            begin
                Active := false;
                SQL.Clear;
                SQL.Add('insert into tab_grupo(nome, cod_usuario_criacao, dt_geracao)');
                SQL.Add('VALUES(:nome, :cod_usuario_criacao, datetime(''now'', ''localtime''));');
                SQL.Add('select last_insert_rowid() as cod_grupo');
                ParamByName('nome').Value := nome;
                ParamByName('cod_usuario_criacao').Value := cod_usuario;
                Active := true;

                Result := qry.ToJSONObject;
                cod_grupo := qry.FieldByName('cod_grupo').AsInteger;

                // Insere os membros do grupo...
                for i := 0 to membros.Size - 1 do
                begin
                    Active := false;
                    SQL.Clear;
                    SQL.Add('insert into tab_grupo_usuario(cod_grupo, cod_usuario)');
                    SQL.Add('VALUES(:cod_grupo, :cod_usuario);');
                    ParamByName('cod_grupo').Value := cod_grupo;
                    ParamByName('cod_usuario').Value := membros[i].GetValue<integer>('cod_usuario', 0);
                    ExecSQL;

                    // Manda aviso para os demais usuarios do grupo...
                    if membros[i].GetValue<integer>('cod_usuario', 0) <> cod_usuario then
                    begin
                        Active := false;
                        SQL.Clear;
                        SQL.Add('insert into tab_mensagem(cod_usuario_de, cod_usuario_para, dt_geracao, texto, cod_grupo)');
                        SQL.Add('values(:cod_usuario_de, :cod_usuario_para, datetime(''now'', ''localtime''), :texto, :cod_grupo)');

                        ParamByName('cod_usuario_de').Value := cod_usuario;
                        ParamByName('cod_usuario_para').Value := membros[i].GetValue<integer>('cod_usuario', 0);
                        ParamByName('texto').Value := 'Você foi adicionado ao grupo';
                        ParamByName('cod_grupo').Value := cod_grupo;
                        ExecSQL;
                    end;
                end;
            end;

            //Conn.Commit;
        except on ex:exception do
            begin
                //Conn.Rollback;
                raise Exception.Create(ex.Message);
            end;
        end;

    finally
        qry.Free;
    end;
end;

end.
