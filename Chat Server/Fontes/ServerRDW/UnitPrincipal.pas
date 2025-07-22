unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  uRESTDWComponentBase, uRESTDWBasic, uRESTDWIdBase, FMX.Controls.Presentation,
  FMX.StdCtrls;

type
  TFrmPrincipal = class(TForm)
    ServicePooler: TRESTDWIdServicePooler;
    Switch: TSwitch;
    procedure FormCreate(Sender: TObject);
    procedure SwitchSwitch(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses DataModule.Services;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
    ServicePooler.ServerMethodClass := TDmServices;
    ServicePooler.Active := Switch.IsChecked;
end;

procedure TFrmPrincipal.SwitchSwitch(Sender: TObject);
begin
    ServicePooler.Active := Switch.IsChecked;
end;

end.
