unit UnitDataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, System.IOUtils, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDm = class(TDataModule)
    Conn: TFDConnection;
    qryProduto: TFDQuery;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    procedure ConnBeforeConnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure ConnAfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ListarProdutos;
  end;

var
  Dm: TDm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDm.ConnAfterConnect(Sender: TObject);
begin
    Conn.ExecSQL('CREATE TABLE IF NOT EXISTS TAB_PRODUTO ( ' +
                            'COD_PRODUTO   INTEGER NOT NULL PRIMARY KEY, ' +
                            'DESCRICAO     VARCHAR(100),' +
                            'CATEGORIA     VARCHAR(20));'
                );


    {
    Conn.ExecSQL('insert into tab_produto(cod_produto, descricao, categoria) values(1, ''Monitor'', ''Informática'')');
    Conn.ExecSQL('insert into tab_produto(cod_produto, descricao, categoria) values(2, ''Mouse'', ''Informática'')');
    Conn.ExecSQL('insert into tab_produto(cod_produto, descricao, categoria) values(3, ''Webcam'', ''Informática'')');
    Conn.ExecSQL('insert into tab_produto(cod_produto, descricao, categoria) values(4, ''Caderno'', ''Papelaria'')');
    Conn.ExecSQL('insert into tab_produto(cod_produto, descricao, categoria) values(5, ''Caneta'', ''Papelaria'')');
    Conn.ExecSQL('insert into tab_produto(cod_produto, descricao, categoria) values(6, ''Lápis'', ''Papelaria'')');
    }

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

procedure TDm.ListarProdutos;
begin
    with qryProduto do
    begin
        Active := false;
        SQL.Clear;
        SQL.Add('SELECT * FROM TAB_PRODUTO ORDER BY CATEGORIA, DESCRICAO');
        Active := true;
    end;
end;

end.
