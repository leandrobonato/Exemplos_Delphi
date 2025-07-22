unit unDataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef, FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteWrapper;

type
  TfrmDataModule = class(TDataModule)
    fdConexãoSQLite: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    fdQrySQLite: TFDQuery;
    dsSqlite: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDataModule: TfrmDataModule;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TfrmDataModule.DataModuleCreate(Sender: TObject);
var
  sSQL, DBFile, diretorio: String;
begin
  try
    fdConexãoSQLite.Connected := True;
  except on E: Exception do
  begin
    DBFile := trim(ExtractFilePath(ParamStr(0)) + 'BD\SQLite.s3db');
    diretorio := trim(ExtractFilePath(ParamStr(0)) + 'BD\');
    CreateDir(diretorio);
    SetCurrentDir(diretorio);
    fdConexãoSQLite.Params.Database := DBFile;
  end;
  end;

  try
    sSQL := fdQrySQLite.SQL.Text;
    fdQrySQLite.Close;
    fdQrySQLite.Open;
  except on E: Exception do
  begin
    fdQrySQLite.ExecSQL('CREATE TABLE IF NOT EXISTS TESTE (ID INTEGER PRIMARY KEY, TESTE VARCHAR(20)); ' +
                        'INSERT INTO TESTE VALUES (1, ' + quotedStr('01')+ ');' +
                        'INSERT INTO TESTE VALUES (2, ' + quotedStr('02')+ ');' +
                        'INSERT INTO TESTE VALUES (3, ' + quotedStr('03')+ ');' +
                        'INSERT INTO TESTE VALUES (4, ' + quotedStr('04')+ ');' +
                        'INSERT INTO TESTE VALUES (5, ' + quotedStr('05')+ ');' +
                        'INSERT INTO TESTE VALUES (6, ' + quotedStr('06')+ ');' +
                        'INSERT INTO TESTE VALUES (7, ' + quotedStr('07')+ ');' +
                        'INSERT INTO TESTE VALUES (8, ' + quotedStr('08')+ ');' +
                        'INSERT INTO TESTE VALUES (9, ' + quotedStr('09')+ ');' +
                        'INSERT INTO TESTE VALUES (10, ' + quotedStr('010')+ ');');
    fdConexãoSQLite.Connected := False;
    fdQrySQLite.Close;
    fdQrySQLite.SQL.Clear;
    fdQrySQLite.SQL.Add(sSQL);
    fdQrySQLite.Open;
  end;
  end;
end;

end.
