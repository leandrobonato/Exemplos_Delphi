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
  System.Variants, System.JSON, DataSet.Serialize.Config, DataSet.Serialize,
  uMD5;

type
  TDm = class(TDataModule)
    Conn: TFDConnection;
    FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink;
    qryUsuario: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure ConnBeforeConnect(Sender: TObject);
    procedure ConnAfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    function InserirUsuario(nome, email, senha: string;
                             foto: TBitmap): TJsonObject;
    procedure EditarUsuario(id_usuario: integer; nome, email, senha: string;
              foto: TBitmap);
    function Login(email, senha: string): TJsonObject;
  end;

var
  Dm: TDm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDm.ConnAfterConnect(Sender: TObject);
begin
    Conn.ExecSQL('CREATE TABLE IF NOT EXISTS TAB_USUARIO ( ' +
                            'ID_USUARIO       INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ' +
                            'EMAIL             VARCHAR(100), ' +
                            'SENHA             VARCHAR(100), ' +
                            'NOME              VARCHAR(100),' +
                            'FOTO              BLOB);'
                );
end;

procedure TDm.ConnBeforeConnect(Sender: TObject);
begin
    Conn.DriverName := 'SQLite';
    Conn.Params.Values['Database'] := System.SysUtils.GetCurrentDir + '\banco.db';
end;

procedure TDm.DataModuleCreate(Sender: TObject);
begin
    Conn.Connected := true;
end;

function TDm.InserirUsuario(nome, email, senha: string;
                            foto: TBitmap): TJsonObject;
begin
    with qryUsuario do
    begin
        Active := false;
        SQL.Clear;
        SQL.Add('insert into tab_usuario(nome, email, senha, foto)');
        SQL.Add('values(:nome, :email, :senha, :foto);');
        SQL.Add('select last_insert_rowid() as id_usuario');

        ParamByName('nome').Value := nome;
        ParamByName('email').Value := email;
        ParamByName('senha').Value := MD5(senha);

        if foto <> nil then
            ParamByName('foto').Assign(foto)
        else
        begin
            ParamByName('foto').DataType := ftString;
            ParamByName('foto').Value := unassigned;
        end;

        Active := true;
    end;

    Result := qryUsuario.ToJSONObject;
end;

procedure TDm.EditarUsuario(id_usuario: integer;
                            nome, email, senha: string;
                            foto: TBitmap);
begin
    with qryUsuario do
    begin
        Active := false;
        SQL.Clear;
        SQL.Add('update tab_usuario set nome=:nome, email=:email, senha=:senha, foto=:foto');
        SQL.Add('where id_usuario = :id_usuario');

        ParamByName('id_usuario').Value := id_usuario;
        ParamByName('nome').Value := nome;
        ParamByName('email').Value := email;
        ParamByName('senha').Value := MD5(senha);

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

function TDm.Login(email, senha: string): TJsonObject;
begin
    with qryUsuario do
    begin
        Active := false;
        SQL.Clear;
        SQL.Add('select * from tab_usuario');
        SQL.Add('where email=:email and senha=:senha');

        ParamByName('email').Value := email;
        ParamByName('senha').Value := MD5(senha);

        Active := true;
    end;

    Result := qryUsuario.ToJSONObject;

end;


end.
