unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFrmPrincipal = class(TForm)
    btnPerfil: TSpeedButton;
    Image1: TImage;
    procedure btnPerfilClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses UnitPerfil;

procedure TFrmPrincipal.btnPerfilClick(Sender: TObject);
begin
    if NOT Assigned(FrmPerfil) then
        Application.CreateForm(TFrmPerfil, FrmPerfil);

    FrmPerfil.Show;
end;

procedure TFrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := TCloseAction.caFree;
    FrmPrincipal := nil;
end;

end.
