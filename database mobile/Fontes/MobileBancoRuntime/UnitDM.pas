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
  Tdm = class(TDataModule)
    conn: TFDConnection;
    qry: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure connAfterConnect(Sender: TObject);
    procedure connBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure Tdm.connAfterConnect(Sender: TObject);
begin
    conn.ExecSQL('CREATE TABLE IF NOT EXISTS TAB (cod INTEGER, descricao VARCHAR(100));');
    conn.ExecSQL('CREATE TABLE IF NOT EXISTS TAB2 (cod INTEGER, descricao VARCHAR(100));');

    conn.ExecSQL('INSERT INTO TAB(cod, descricao) VALUES(1, ''XXXXX'');');
    conn.ExecSQL('INSERT INTO TAB(cod, descricao) VALUES(2, ''XXXXX'');');

    conn.ExecSQL('INSERT INTO TAB2(cod, descricao) VALUES(1, ''XXXXX'');');
    conn.ExecSQL('INSERT INTO TAB2(cod, descricao) VALUES(2, ''XXXXX'');');
end;

procedure Tdm.connBeforeConnect(Sender: TObject);
begin
    conn.DriverName := 'SQLite';

    {$IFDEF MSWINDOWS}
    conn.Params.Values['Database'] := System.SysUtils.GetCurrentDir + '\DB\banco.db';
    {$ELSE}
    conn.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'banco.db');
    {$ENDIF}
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
    try
        conn.Connected := true;
    except on e:exception do
        raise Exception.Create('Erro de conexão com o banco de dados: ' + e.Message);
    end;

end;

end.
