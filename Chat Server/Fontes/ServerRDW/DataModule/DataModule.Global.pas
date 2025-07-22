unit DataModule.Global;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, System.JSON, DataSet.Serialize, FireDAC.DApt,
  DataSet.Serialize.Config;

type
  TDmGlobal = class(TDataModule)
    Conn: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure ConnBeforeConnect(Sender: TObject);
    procedure ConnAfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function ListarMensagens(cod_usuario, cod_mensagem: integer): TJsonArray;
    function InserirMensagem(cod_usuario_de, cod_usuario_para: integer;
                             texto: string): TJsonObject;
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
                            'DT_GERACAO        DATETIME, ' +
                            'TEXTO             VARCHAR (1000));'
                );

    // Cadastra os usuarios...
    Conn.ExecSQL('insert or replace into tab_usuario(cod_usuario, nome) values(1, ''Heber Stein Mazutti'');');
    Conn.ExecSQL('insert or replace into tab_usuario(cod_usuario, nome) values(2, ''Tony Stark'');');

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

function TDmGlobal.ListarMensagens(cod_usuario, cod_mensagem: integer): TJsonArray;
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
            SQL.Add('SELECT * FROM TAB_MENSAGEM');
            SQL.Add('WHERE (COD_USUARIO_DE=:COD_USUARIO_DE OR COD_USUARIO_PARA=:COD_USUARIO_PARA)');

            // cod_mensagem  -->   codMensagem

            if cod_mensagem > 0 then
            begin
                SQL.Add('AND COD_MENSAGEM > :COD_MENSAGEM');
                ParamByName('COD_MENSAGEM').Value := cod_mensagem;
            end;

            SQL.Add('ORDER BY DT_GERACAO');
            ParamByName('COD_USUARIO_DE').Value := cod_usuario;
            ParamByName('COD_USUARIO_PARA').Value := cod_usuario;
            Active := true;
        end;

        Result := qry.ToJSONArray;

    finally
        FreeAndNil(qry);
    end;
end;

function TDmGlobal.InserirMensagem(cod_usuario_de, cod_usuario_para: integer;
                                   texto: string): TJsonObject;
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
            SQL.Add('insert into tab_mensagem(cod_usuario_de, cod_usuario_para, dt_geracao, texto)');
            SQL.Add('VALUES(:cod_usuario_de, :cod_usuario_para, datetime(''now'', ''localtime''), :texto);');
            SQL.Add('select last_insert_rowid() as cod_mensagem');
            ParamByName('cod_usuario_de').Value := cod_usuario_de;
            ParamByName('cod_usuario_para').Value := cod_usuario_para;
            ParamByName('texto').Value := texto;
            Active := true;
        end;

        Result := qry.ToJSONObject;

    finally
        FreeAndNil(qry);
    end;
end;

end.
