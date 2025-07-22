unit DataModule.Global;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, System.JSON,
  DataSet.Serialize, FireDAC.DApt, DataSet.Serialize.Config, System.IOUtils,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  RESTRequest4D;

type
  TDmGlobal = class(TDataModule)
    Conn: TFDConnection;
    qryConversa: TFDQuery;
    qryMensagem: TFDQuery;
    TabMensagem: TFDMemTable;
    TabEnvio: TFDMemTable;
    TabGrupo: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure ConnBeforeConnect(Sender: TObject);
    procedure ConnAfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    procedure InserirMensagemMobile(cod_mensagem, cod_usuario_de, cod_usuario_para: integer;
                                   dt_geracao, texto, nome_de, nome_para: string;
                                   ind_proprio: boolean);
    procedure ListarConversasMobile;
    procedure ListarMensagensMobile(cod_usuario_amigo, cod_mensagem: integer);
    procedure ListarHistoricoMensagens(cod_usuario_logado: integer);
    procedure ListarNovasMensagens(cod_usuario_logado, cod_usuario_amigo,
                                    cod_ult_msg_recebida: integer);
    function EnviarMensagem(cod_usuario_logado, cod_usuario_amigo, cod_grupo: integer;
                                   texto: string): integer;
    procedure InserirMensagemGrupoMobile(cod_mensagem, cod_usuario_de,
                                         cod_grupo: integer; nome_grupo, dt_geracao, texto, nome_de: string;
                                         ind_proprio: boolean);
    procedure ListarMensagensGrupoMobile(cod_grupo, cod_mensagem: integer);
    function InserirGrupo(cod_usuario_logado: integer; nome: string;
                          membros: TJsonArray): integer;
  end;

var
  DmGlobal: TDmGlobal;

Const
  BASE_URL = 'http://localhost:9000';

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDmGlobal.ConnAfterConnect(Sender: TObject);
begin
    Conn.ExecSQL('CREATE TABLE IF NOT EXISTS TAB_CONVERSA ( ' +
                            'COD_CONVERSA      VARCHAR(50) NOT NULL PRIMARY KEY, ' +
                            'COD_USUARIO       INTEGER,' +   // Sempre o cod. do meu amigo...
                            'NOME              VARCHAR(100),' +  // Sempre o nome do meu amigo...
                            'COD_GRUPO         INTEGER,' +
                            'NOME_GRUPO        VARCHAR(50),' +
                            'DT_ULT_MENSAGEM   DATETIME,' +
                            'TEXTO_ULT_MENSAGEM VARCHAR(1000));');

    Conn.ExecSQL('CREATE TABLE IF NOT EXISTS TAB_MENSAGEM ( ' +
                            'COD_MENSAGEM      INTEGER NOT NULL PRIMARY KEY, ' +
                            'COD_USUARIO_DE    INTEGER, ' +
                            'COD_USUARIO_PARA  INTEGER, ' +
                            'COD_GRUPO         INTEGER, ' +
                            'DT_GERACAO        DATETIME, ' +
                            'TEXTO             VARCHAR (1000));'
                );
end;

procedure TDmGlobal.ConnBeforeConnect(Sender: TObject);
begin
    Conn.DriverName := 'SQLite';

    {$IFDEF MSWINDOWS}
    Conn.Params.Values['Database'] := System.SysUtils.GetCurrentDir + '\banco.db';
    {$ELSE}
    Conn.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'banco.db');
    {$ENDIF}
end;

procedure TDmGlobal.DataModuleCreate(Sender: TObject);
begin
    TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
    TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';
    Conn.Connected := true;
end;

procedure TDmGlobal.ListarConversasMobile;
begin
    with qryConversa do
    begin
        Active := false;
        SQL.Clear;
        SQL.Add('SELECT * FROM TAB_CONVERSA');
        SQL.Add('ORDER BY DT_ULT_MENSAGEM DESC');
        Active := true;
    end;
end;

procedure TDmGlobal.ListarMensagensMobile(cod_usuario_amigo, cod_mensagem: integer);
begin
    with qryMensagem do
    begin
        Active := false;
        SQL.Clear;
        SQL.Add('SELECT * FROM TAB_MENSAGEM');
        SQL.Add('WHERE (COD_USUARIO_DE = :COD_USUARIO_DE');
        SQL.Add('OR COD_USUARIO_PARA = :COD_USUARIO_PARA)');
        SQL.Add('AND COD_GRUPO = 0');

        if cod_mensagem > 0 then
        begin
            SQL.Add('AND COD_MENSAGEM > :COD_MENSAGEM');
            ParamByName('COD_MENSAGEM').Value := cod_mensagem;
        end;

        SQL.Add('ORDER BY COD_MENSAGEM');

        ParamByName('COD_USUARIO_DE').Value := cod_usuario_amigo;
        ParamByName('COD_USUARIO_PARA').Value := cod_usuario_amigo;

        Active := true;
    end;
end;

procedure TDmGlobal.ListarMensagensGrupoMobile(cod_grupo, cod_mensagem: integer);
begin
    with qryMensagem do
    begin
        Active := false;
        SQL.Clear;
        SQL.Add('SELECT * FROM TAB_MENSAGEM');
        SQL.Add('WHERE COD_GRUPO = :COD_GRUPO');

        if cod_mensagem > 0 then
        begin
            SQL.Add('AND COD_MENSAGEM > :COD_MENSAGEM');
            ParamByName('COD_MENSAGEM').Value := cod_mensagem;
        end;

        SQL.Add('ORDER BY COD_MENSAGEM');

        ParamByName('COD_GRUPO').Value := cod_grupo;

        Active := true;
    end;
end;

procedure TDmGlobal.ListarHistoricoMensagens(cod_usuario_logado: integer);
var
    resp: IResponse;
begin
    TabMensagem.FieldDefs.Clear;

    resp := TRequest.New.BaseURL(BASE_URL)
            .Resource('messages/historico')
            .BasicAuthentication('testserver', 'testserver')
            .AddParam('cod_usuario_logado', cod_usuario_logado.ToString)
            .Accept('application/json')
            .DataSetAdapter(TabMensagem)
            .Get;

    if resp.StatusCode <> 200 then
        raise Exception.Create('Erro ao buscar mensagens');
end;

procedure TDmGlobal.ListarNovasMensagens(cod_usuario_logado, cod_usuario_amigo,
                                         cod_ult_msg_recebida: integer);
var
    resp: IResponse;
begin
    TabMensagem.FieldDefs.Clear;

    resp := TRequest.New.BaseURL(BASE_URL)
            .Resource('messages')
            .BasicAuthentication('testserver', 'testserver')
            .AddParam('cod_usuario_de', cod_usuario_amigo.ToString)
            .AddParam('cod_usuario_para', cod_usuario_logado.ToString)
            .AddParam('cod_mensagem', cod_ult_msg_recebida.ToString)
            .Accept('application/json')
            .DataSetAdapter(TabMensagem)
            .Get;

    if resp.StatusCode <> 200 then
        raise Exception.Create('Erro ao buscar mensagens');
end;

function TDmGlobal.EnviarMensagem(cod_usuario_logado, cod_usuario_amigo, cod_grupo: integer;
                                   texto: string): integer;
var
    resp: IResponse;
    json: TJsonObject;
begin
    try
        json := TJSONObject.Create;
        json.AddPair('cod_usuario_de', cod_usuario_logado.ToString);
        json.AddPair('cod_usuario_para', cod_usuario_amigo.ToString);
        json.AddPair('cod_grupo', cod_grupo.ToString);
        json.AddPair('texto', texto);

        resp := TRequest.New.BaseURL(BASE_URL)
                .Resource('messages')
                .BasicAuthentication('testserver', 'testserver')
                .AddBody(json.ToJSON)
                .Accept('application/json')
                .DataSetAdapter(TabEnvio)
                .Post;

        if resp.StatusCode <> 201 then
            raise Exception.Create('Erro ao enviar mensagem')
        else
            Result := TabEnvio.FieldByName('cod_mensagem').AsInteger;

    finally
        json.DisposeOf;
    end;
end;

procedure TDmGlobal.InserirMensagemMobile(cod_mensagem, cod_usuario_de, cod_usuario_para: integer;
                                           dt_geracao, texto, nome_de, nome_para: string;
                                           ind_proprio: boolean);
var
    qry: TFDQuery;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Conn;

        with qry do
        begin
            Active := false;
            SQL.Clear;
            SQL.Add('insert or replace into tab_mensagem(cod_mensagem, cod_usuario_de, ');
            SQL.Add('cod_usuario_para, dt_geracao, texto, cod_grupo)');
            SQL.Add('VALUES(:cod_mensagem, :cod_usuario_de, ');
            SQL.Add(':cod_usuario_para, :dt_geracao, :texto, :cod_grupo);');

            ParamByName('cod_mensagem').Value := cod_mensagem;
            ParamByName('cod_usuario_de').Value := cod_usuario_de;
            ParamByName('cod_usuario_para').Value := cod_usuario_para;
            ParamByName('dt_geracao').Value := dt_geracao; // yyyy-mm-dd hh:nn:ss
            ParamByName('texto').Value := texto;
            ParamByName('cod_grupo').Value := 0;
            ExecSQL;

            // Atualizar as conversas...
            Active := false;
            SQL.Clear;
            SQL.Add('insert or replace into tab_conversa(cod_conversa, cod_usuario, nome, ');
            SQL.Add('dt_ult_mensagem, texto_ult_mensagem, cod_grupo, nome_grupo)');
            SQL.Add('VALUES(:cod_conversa, :cod_usuario, :nome, :dt_ult_mensagem, ');
            SQl.Add(':texto_ult_mensagem, :cod_grupo, :nome_grupo);');

            if ind_proprio then
            begin
                ParamByName('cod_usuario').Value := cod_usuario_para;
                ParamByName('nome').Value := nome_para;
                ParamByName('cod_conversa').Value := 'C-' + cod_usuario_para.ToString;
            end
            else
            begin
                ParamByName('cod_usuario').Value := cod_usuario_de;
                ParamByName('nome').Value := nome_de;
                ParamByName('cod_conversa').Value := 'C-' + cod_usuario_de.ToString;
            end;

            ParamByName('dt_ult_mensagem').Value := dt_geracao;
            ParamByName('texto_ult_mensagem').Value := texto;
            ParamByName('cod_grupo').Value := 0;
            ParamByName('nome_grupo').Value := '';
            ExecSQL;
        end;

    finally
        qry.Free;
    end;
end;

procedure TDmGlobal.InserirMensagemGrupoMobile(cod_mensagem, cod_usuario_de, cod_grupo: integer;
                                               nome_grupo, dt_geracao, texto, nome_de: string;
                                               ind_proprio: boolean);
var
    qry: TFDQuery;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Conn;

        with qry do
        begin
            if cod_mensagem > 0 then
            begin
                Active := false;
                SQL.Clear;
                SQL.Add('insert or replace into tab_mensagem(cod_mensagem, cod_usuario_de, ');
                SQL.Add('cod_usuario_para, dt_geracao, texto, cod_grupo)');
                SQL.Add('VALUES(:cod_mensagem, :cod_usuario_de, ');
                SQL.Add(':cod_usuario_para, :dt_geracao, :texto, :cod_grupo);');

                ParamByName('cod_mensagem').Value := cod_mensagem;
                ParamByName('cod_usuario_de').Value := cod_usuario_de;
                ParamByName('cod_usuario_para').Value := 0;
                ParamByName('dt_geracao').Value := dt_geracao; // yyyy-mm-dd hh:nn:ss
                ParamByName('texto').Value := texto;
                ParamByName('cod_grupo').Value := cod_grupo;
                ExecSQL;
            end;

            // Atualizar as conversas...
            Active := false;
            SQL.Clear;
            SQL.Add('insert or replace into tab_conversa(cod_conversa, cod_usuario, nome, ');
            SQL.Add('dt_ult_mensagem, texto_ult_mensagem, cod_grupo, nome_grupo)');
            SQL.Add('VALUES(:cod_conversa, :cod_usuario, :nome, :dt_ult_mensagem, ');
            SQl.Add(':texto_ult_mensagem, :cod_grupo, :nome_grupo);');

            if ind_proprio then
            begin
                ParamByName('cod_usuario').Value := 0;
                ParamByName('nome').Value := '';
            end
            else
            begin
                ParamByName('cod_usuario').Value := cod_usuario_de;
                ParamByName('nome').Value := nome_de;
            end;

            ParamByName('cod_conversa').Value := 'G-' + cod_grupo.ToString;
            ParamByName('dt_ult_mensagem').Value := dt_geracao;
            ParamByName('texto_ult_mensagem').Value := texto;
            ParamByName('cod_grupo').Value := cod_grupo;
            ParamByName('nome_grupo').Value := nome_grupo;
            ExecSQL;
        end;

    finally
        qry.Free;
    end;
end;

function TDmGlobal.InserirGrupo(cod_usuario_logado: integer;
                                nome: string;
                                membros: TJsonArray): integer;
var
    resp: IResponse;
    json: TJsonObject;
begin
    try
        json := TJSONObject.Create;
        json.AddPair('cod_usuario', cod_usuario_logado.ToString);
        json.AddPair('nome', nome);
        json.AddPair('membros', membros);

        resp := TRequest.New.BaseURL(BASE_URL)
                .Resource('groups')
                .BasicAuthentication('testserver', 'testserver')
                .AddBody(json.ToJSON)
                .Accept('application/json')
                .DataSetAdapter(TabGrupo)
                .Post;

        if resp.StatusCode <> 201 then
            raise Exception.Create('Erro ao criar grupo')
        else
            Result := TabGrupo.FieldByName('cod_grupo').AsInteger;

    finally
        json.DisposeOf;
    end;
end;

end.
