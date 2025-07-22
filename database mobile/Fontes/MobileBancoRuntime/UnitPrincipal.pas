unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFrmPrincipal = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses UnitDM;

procedure TFrmPrincipal.Button1Click(Sender: TObject);
begin
    dm.qry.Active := false;
    dm.qry.SQL.Clear;
    dm.qry.SQL.Add('SELECT * FROM TAB');
    dm.qry.Active := true;

    ShowMessage(dm.qry.RecordCount.ToString + ' Registro(s)');
end;

procedure TFrmPrincipal.Button2Click(Sender: TObject);
begin
    dm.qry.Active := false;
    dm.qry.SQL.Clear;
    dm.qry.SQL.Add('SELECT * FROM TAB2');
    dm.qry.Active := true;

    ShowMessage(dm.qry.RecordCount.ToString + ' Registro(s)');
end;

end.
