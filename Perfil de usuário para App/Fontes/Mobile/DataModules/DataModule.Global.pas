unit DataModule.Global;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, System.IOUtils, FMX.Graphics, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  System.Variants, System.JSON, RESTRequest4D;

type
  TDm = class(TDataModule)
    Conn: TFDConnection;
    FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink;
    qryUsuario: TFDQuery;
    TabUsuario: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure ConnBeforeConnect(Sender: TObject);
    procedure ConnAfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    procedure InserirUsuario(id_usuario: integer; nome, email, senha: string;
                            foto: TBitmap);
    procedure ExcluirUsuario;
    procedure EditarUsuarioAPI(id_usuario: integer; nome, email, senha,
                                foto64: string);
    procedure InserirUsuarioAPI(nome, email, senha, foto64: string);
    procedure LoginAPI(email, senha: string);
    procedure DadosUsuario;
  end;

var
  Dm: TDm;

Const
  BASE_URL = 'http://localhost:3001';
  //BASE_URL = 'http://192.168.0.105:3001';


implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDm.ConnAfterConnect(Sender: TObject);
begin
    Conn.ExecSQL('CREATE TABLE IF NOT EXISTS TAB_USUARIO ( ' +
                            'ID_USUARIO       INTEGER NOT NULL PRIMARY KEY, ' +
                            'EMAIL             VARCHAR(100), ' +
                            'SENHA             VARCHAR(100), ' +
                            'NOME              VARCHAR(100),' +
                            'FOTO              BLOB);'
                );
end;

procedure TDm.ConnBeforeConnect(Sender: TObject);
begin
    Conn.DriverName := 'SQLite';

    {$IFDEF MSWINDOWS}
    Conn.Params.Values['Database'] := System.SysUtils.GetCurrentDir + '\banco.db';
    {$ELSE}
    Conn.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'banco.db');
    {$ENDIF}
end;

procedure TDm.DataModuleCreate(Sender: TObject);
begin
    Conn.Connected := true;
end;

procedure TDm.InserirUsuario(id_usuario: integer;
                             nome, email, senha: string;
                             foto: TBitmap);
begin
    with qryUsuario do
    begin
        Active := false;
        SQL.Clear;
        SQL.Add('insert into tab_usuario(id_usuario, nome, email, senha, foto)');
        SQL.Add('values(:id_usuario, :nome, :email, :senha, :foto)');

        ParamByName('id_usuario').Value := id_usuario;
        ParamByName('nome').Value := nome;
        ParamByName('email').Value := email;
        ParamByName('senha').Value := senha;

        if foto <> nil then
            ParamByName('foto').Assign(foto)
        else
        begin
            ParamByName('foto').DataType := ftString;
            ParamByName('foto').Value := unassigned;
        end;

        ExecSQL;
    end;
end;

procedure TDm.ExcluirUsuario;
begin
    with qryUsuario do
    begin
        Active := false;
        SQL.Clear;
        SQL.Add('delete from tab_usuario');
        ExecSQL;
    end;
end;

procedure TDm.DadosUsuario;
begin
    with qryUsuario do
    begin
        Active := false;
        SQL.Clear;
        SQL.Add('select * from tab_usuario');
        Active := true;
    end;
end;

procedure TDm.InserirUsuarioAPI(nome, email, senha, foto64: string);
var
    json: TJsonObject;
    resp: IResponse;
begin
    try
        json := TJsonObject.Create;
        json.AddPair('nome', nome);
        json.AddPair('email', email);
        json.AddPair('senha', senha);
        json.AddPair('foto', foto64);

        resp := TRequest.New.BaseURL(BASE_URL)
                .Resource('/usuarios')
                .Accept('application/json')
                .AddBody(json.ToJSON)
                .DataSetAdapter(TabUsuario)
                .Post;

        if resp.StatusCode <> 201 then
            raise Exception.Create(resp.Content);

    finally
        json.DisposeOf;
    end;
end;

procedure TDm.EditarUsuarioAPI(id_usuario: integer;
                               nome, email, senha, foto64: string);
var
    json: TJsonObject;
    resp: IResponse;
begin
    try
        json := TJsonObject.Create;
        json.AddPair('nome', nome);
        json.AddPair('email', email);
        json.AddPair('senha', senha);
        json.AddPair('foto', foto64);

        resp := TRequest.New.BaseURL(BASE_URL)
                .Resource('/usuarios')
                .ResourceSuffix(id_usuario.ToString)
                .Accept('application/json')
                .AddBody(json.ToJSON)
                .Put;

        if resp.StatusCode <> 200 then
            raise Exception.Create(resp.Content);

    finally
        json.DisposeOf;
    end;
end;

procedure TDm.LoginAPI(email, senha: string);
var
    json: TJsonObject;
    resp: IResponse;
begin
    try
        json := TJsonObject.Create;
        json.AddPair('email', email);
        json.AddPair('senha', senha);

        resp := TRequest.New.BaseURL(BASE_URL)
                .Resource('/usuarios/login')
                .Accept('application/json')
                .AddBody(json.ToJSON)
                .DataSetAdapter(TabUsuario)
                .Post;

        if resp.StatusCode <> 200 then
            raise Exception.Create(resp.Content);

    finally
        json.DisposeOf;
    end;
end;

end.
