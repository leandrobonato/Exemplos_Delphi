unit UnitDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, System.IOUtils;

type
  TDm = class(TDataModule)
    Conn: TFDConnection;
    qryCliente: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure ConnAfterConnect(Sender: TObject);
    procedure ConnBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    //procedure ListarClientes(busca: string);
  end;

var
  Dm: TDm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDm.ConnAfterConnect(Sender: TObject);
begin
    Conn.ExecSQL('CREATE TABLE IF NOT EXISTS TAB_CLIENTE ( ' +
                            'ID_CLIENTE      INTEGER NOT NULL PRIMARY KEY, ' +
                            'NOME            VARCHAR(100));'
                );

    Conn.ExecSQL('INSERT OR REPLACE INTO TAB_CLIENTE (ID_CLIENTE, NOME) VALUES(1, ''99 Coders'')');

    Conn.ExecSQL('INSERT OR REPLACE INTO TAB_CLIENTE (ID_CLIENTE, NOME) VALUES(2, ''Kalunga'')');

    Conn.ExecSQL('INSERT OR REPLACE INTO TAB_CLIENTE (ID_CLIENTE, NOME) VALUES(3, ''ABC Peças'')');

    Conn.ExecSQL('INSERT OR REPLACE INTO TAB_CLIENTE (ID_CLIENTE, NOME) VALUES(4, ''Walmart'')');

    Conn.ExecSQL('INSERT OR REPLACE INTO TAB_CLIENTE (ID_CLIENTE, NOME) VALUES(5, ''Pão de Açúcar'')');

    Conn.ExecSQL('INSERT OR REPLACE INTO TAB_CLIENTE (ID_CLIENTE, NOME) VALUES(6, ''Posto Ipiranga'')');

    Conn.ExecSQL('INSERT OR REPLACE INTO TAB_CLIENTE (ID_CLIENTE, NOME) VALUES(7, ''Auto Posto Bela Vista'')');

    Conn.ExecSQL('INSERT OR REPLACE INTO TAB_CLIENTE (ID_CLIENTE, NOME) VALUES(8, ''LATAM'')');

    Conn.ExecSQL('INSERT OR REPLACE INTO TAB_CLIENTE (ID_CLIENTE, NOME) VALUES(9, ''Petrobras'')');

    Conn.ExecSQL('INSERT OR REPLACE INTO TAB_CLIENTE (ID_CLIENTE, NOME) VALUES(10, ''Vale'')');

    Conn.ExecSQL('INSERT OR REPLACE INTO TAB_CLIENTE (ID_CLIENTE, NOME) VALUES(11, ''Itaú Unibanco'')');

    Conn.ExecSQL('INSERT OR REPLACE INTO TAB_CLIENTE (ID_CLIENTE, NOME) VALUES(12, ''Ambev'')');

    Conn.ExecSQL('INSERT OR REPLACE INTO TAB_CLIENTE (ID_CLIENTE, NOME) VALUES(13, ''Bradesco'')');

    Conn.ExecSQL('INSERT OR REPLACE INTO TAB_CLIENTE (ID_CLIENTE, NOME) VALUES(14, ''Santander'')');

    Conn.ExecSQL('INSERT OR REPLACE INTO TAB_CLIENTE (ID_CLIENTE, NOME) VALUES(15, ''Eletrobrás'')');

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

{
procedure TDm.ListarClientes(busca: string);
begin
    with Dm.qryCliente do
    begin
        Active := false;
        SQL.Clear;
        SQL.Add('select id_cliente, nome from tab_cliente');
        SQL.Add('where id_cliente > 0');

        if busca <> '' then
        begin
            SQL.Add('and nome like :nome');
            ParamByName('nome').Value := '%' + busca + '%';
        end;

        SQL.Add('order by nome');
        Active := true;
    end;
end;
}

end.
