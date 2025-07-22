unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.StdCtrls, FMX.Objects, FMX.Layouts, FMX.Controls.Presentation, FMX.Types,
  FMX.MediaLibrary.Actions, System.Actions, FMX.ActnList, FMX.StdActns, UnitDM,
  Rest.Types, System.JSON, System.IOUtils;

type
  TFrmPrincipal = class(TForm)
    rectBackup: TRoundRect;
    label2: TLabel;
    rectDelete: TRoundRect;
    Label1: TLabel;
    restRestore: TRoundRect;
    Label3: TLabel;
    rectCount: TRoundRect;
    Label4: TLabel;
    rectInsert: TRoundRect;
    Label5: TLabel;
    procedure rectDeleteClick(Sender: TObject);
    procedure rectCountClick(Sender: TObject);
    procedure rectInsertClick(Sender: TObject);
    procedure rectBackupClick(Sender: TObject);
    procedure restRestoreClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}


procedure TFrmPrincipal.rectBackupClick(Sender: TObject);
var
    Stream : TMemoryStream;
    arq : string;
begin
    try
        dm.conn.Connected := false;

        try
            {$IFDEF MSWINDOWS}
            arq := System.SysUtils.GetCurrentDir + '\DB\banco.db';
            {$ELSE}
            arq := TPath.Combine(TPath.GetDocumentsPath, 'banco.db');
            {$ENDIF}

            Stream := TMemoryStream.Create;
            Stream.LoadFromFile(arq);
            Stream.Position := 0;

            dm.RESTClientBackup.FallbackCharsetEncoding := 'raw';
            dm.ReqBackup.ClearBody;
            dm.ReqBackup.AddBody(Stream, ctAPPLICATION_OCTET_STREAM);
            dm.ReqBackup.Execute;

        except on ex:exception do
            showmessage('Erro ao enviar backup: ' + ex.Message);
        end;
    finally
        dm.conn.Connected := true;
        Stream.DisposeOf;
    end;
end;

procedure TFrmPrincipal.rectCountClick(Sender: TObject);
begin
    dm.qry.active := false;
    dm.qry.sql.clear;
    dm.qry.sql.add('SELECT * FROM TAB_CATEGORIA');
    dm.qry.open;

    showmessage(dm.qry.recordcount.tostring);

    dm.qry.active := false;
end;

procedure TFrmPrincipal.rectDeleteClick(Sender: TObject);
begin
    dm.qry.active := false;
    dm.qry.sql.clear;
    dm.qry.sql.add('DELETE FROM TAB_CATEGORIA');
    dm.qry.execsql;
end;

procedure TFrmPrincipal.rectInsertClick(Sender: TObject);
begin
    dm.qry.active := false;
    dm.qry.sql.clear;
    dm.qry.sql.add('INSERT INTO TAB_CATEGORIA(DESCRICAO) VALUES(''TESTE'')');
    dm.qry.execsql;
end;

procedure TFrmPrincipal.restRestoreClick(Sender: TObject);
var
    Stream : TMemoryStream;
    arq : string;
begin
    {$IFDEF MSWINDOWS}
    arq := System.SysUtils.GetCurrentDir + '\DB\banco.db';
    {$ELSE}
    arq := TPath.Combine(TPath.GetDocumentsPath, 'banco.db');
    {$ENDIF}

    try
        dm.ReqRestore.Execute;

        if dm.ReqRestore.Response.StatusCode <> 200 then
            showmessage('Erro ao restaurar backup: ' + dm.ReqRestore.Response.Content)
        else
        begin
            dm.conn.Connected := false;

            try
                Stream := TMemoryStream.Create;
                Stream.Write(dm.ReqRestore.Response.RawBytes,
                             Length(dm.ReqRestore.Response.RawBytes));
                Stream.Position := 0;
                Stream.SaveToFile(arq);
            finally
                Stream.DisposeOf;
            end;
        end;

    finally
        dm.conn.Connected := true;
    end;
end;

end.
