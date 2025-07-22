unit DataModule.Global;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.DApt;

type
  TDmGlobal = class(TDataModule)
    Conn: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure ConnAfterConnect(Sender: TObject);
  private
    procedure GerarTXT(texto, arquivo: string);
    { Private declarations }
  public
    function GerarTokenEmail(email: string): String;
    procedure ValidarTokenSenha(fone, token: string);
    procedure EditarSenha(fone, token, senha: string);
    procedure RelClienteTXT(arq: string);
    function GerarTokenFone(fone: string): String;
  end;

var
  DmGlobal: TDmGlobal;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDmGlobal.ConnAfterConnect(Sender: TObject);
begin
    Conn.ExecSQL('CREATE TABLE IF NOT EXISTS TAB_USUARIO ( ' +
                            'COD_USUARIO   INTEGER NOT NULL PRIMARY KEY, ' +
                            'NOME          VARCHAR(100),' +
                            'EMAIL         VARCHAR(100),' +
                            'TOKEN         VARCHAR(100),' +
                            'FONE          VARCHAR(20),' +
                            'SENHA         VARCHAR(50));'
                );


    Conn.ExecSQL('CREATE TABLE IF NOT EXISTS TAB_CLIENTE ( ' +
                            'COD_CLIENTE   INTEGER NOT NULL PRIMARY KEY, ' +
                            'NOME          VARCHAR(100),' +
                            'EMAIL         VARCHAR(100));'
                );


    {
    try
        Conn.ExecSQL('INSERT INTO TAB_USUARIO (COD_USUARIO, NOME, EMAIL, SENHA, FONE) ' +
                     'VALUES(1, ''Heber Stein Mazutti'', ''heber@99coders.com.br'', ''12345'', ''11974614291'')');
    except
    end;
    }


    Conn.ExecSQL('INSERT OR REPLACE INTO TAB_CLIENTE (COD_CLIENTE, NOME, EMAIL) VALUES(1, ''Heber'', ''teste@99coders.com.br'')');
    Conn.ExecSQL('INSERT OR REPLACE INTO TAB_CLIENTE (COD_CLIENTE, NOME, EMAIL) VALUES(2, ''Joao'', ''joao99coders.com.br'')');
    Conn.ExecSQL('INSERT OR REPLACE INTO TAB_CLIENTE (COD_CLIENTE, NOME, EMAIL) VALUES(3, ''Maria'', ''maria@99coders.com.br'')');
    Conn.ExecSQL('INSERT OR REPLACE INTO TAB_CLIENTE (COD_CLIENTE, NOME, EMAIL) VALUES(4, ''Antonio'', ''antonio@99coders.com.br'')');
end;

procedure TDmGlobal.DataModuleCreate(Sender: TObject);
begin
    Conn.DriverName := 'SQLite';
    Conn.Params.Values['Database'] := System.SysUtils.GetCurrentDir + '\banco.db';

    Conn.Connected := true;
end;

procedure TDmGlobal.GerarTXT(texto, arquivo: string);
var
    str: TStringList;
begin
    try
        str := TStringList.Create;
        str.Add(texto);
        str.SaveToFile(arquivo);
    finally
        FreeAndNil(str);
    end;
end;

function TDmGlobal.GerarTokenEmail(email: string): String;
var
    qry: TFDQuery;
    token: string;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Conn;

        // Valida se usuario existe...
        qry.Active := false;
        qry.SQL.Clear;
        qry.SQL.Add('select * from tab_usuario where email=:email');
        qry.ParamByName('email').Value := email;
        qry.Active := true;

        if qry.RecordCount = 0 then
            raise Exception.Create('E-mail não encontrado no banco de dados');

        // Gerar token do usuario...
        Randomize;
        token := FormatFloat('000000', Random(999999));

        // Atualiza tabela usuario...
        qry.Active := false;
        qry.SQL.Clear;
        qry.SQL.Add('update tab_usuario set token = :token where email = :email');
        qry.ParamByName('token').Value := token;
        qry.ParamByName('email').Value := email;
        qry.ExecSQL;

        Result := token;
    finally
        FreeAndNil(qry);
    end;

end;

function TDmGlobal.GerarTokenFone(fone: string): String;
var
    qry: TFDQuery;
    token: string;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Conn;

        // Valida se usuario existe...
        qry.Active := false;
        qry.SQL.Clear;
        qry.SQL.Add('select * from tab_usuario where fone=:fone');
        qry.ParamByName('fone').Value := fone;
        qry.Active := true;

        if qry.RecordCount = 0 then
            raise Exception.Create('Telefone não encontrado no banco de dados');

        // Gerar token do usuario...
        Randomize;
        token := FormatFloat('000000', Random(999999));

        // Atualiza tabela usuario...
        qry.Active := false;
        qry.SQL.Clear;
        qry.SQL.Add('update tab_usuario set token = :token where fone = :fone');
        qry.ParamByName('token').Value := token;
        qry.ParamByName('fone').Value := fone;
        qry.ExecSQL;

        Result := token;
    finally
        FreeAndNil(qry);
    end;

end;

procedure TDmGlobal.ValidarTokenSenha(fone, token: string);
var
    qry: TFDQuery;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Conn;

        // Valida se token existe...
        qry.Active := false;
        qry.SQL.Clear;
        qry.SQL.Add('select * from tab_usuario where fone=:fone and token=:token');
        qry.ParamByName('fone').Value := fone;
        qry.ParamByName('token').Value := token;
        qry.Active := true;

        if qry.RecordCount = 0 then
            raise Exception.Create('O código informado não é válido');

    finally
        FreeAndNil(qry);
    end;

end;

procedure TDmGlobal.EditarSenha(fone, token, senha: string);
var
    qry: TFDQuery;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Conn;

        qry.Active := false;
        qry.SQL.Clear;
        qry.SQL.Add('update tab_usuario set senha = :senha, token=null where fone=:fone and token=:token');
        qry.ParamByName('senha').Value := senha;
        qry.ParamByName('fone').Value := fone;
        qry.ParamByName('token').Value := token;
        qry.ExecSQL;

    finally
        FreeAndNil(qry);
    end;

end;

procedure TDmGlobal.RelClienteTXT(arq: string);
var
    qry: TFDQuery;
    str: string;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Conn;

        qry.Active := false;
        qry.SQL.Clear;
        qry.SQL.Add('select * from tab_cliente order by nome');
        qry.Active := true;


        // Gerar o arquivo...
        str := '------------------------------------' + sLineBreak;
        str := str + 'RELATORIO DE CLIENTES' + sLineBreak;
        str := str + '------------------------------------' + sLineBreak;
        str := str + 'CodCliente;Nome;Email' + sLineBreak;

        while NOT qry.Eof do
        begin
            str := str + qry.FieldByName('cod_cliente').AsString + ';' +
                         qry.FieldByName('nome').AsString + ';' +
                         qry.FieldByName('email').AsString + sLineBreak;

            qry.Next;
        end;

        GerarTXT(str, arq);

    finally
        FreeAndNil(qry);
    end;

end;

end.
