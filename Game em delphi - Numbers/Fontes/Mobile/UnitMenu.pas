unit UnitMenu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFrmNumbers = class(TForm)
    Image1: TImage;
    rectPlay: TRectangle;
    rectRanking: TRectangle;
    Image2: TImage;
    Label1: TLabel;
    Image3: TImage;
    Label2: TLabel;
    procedure rectPlayClick(Sender: TObject);
    procedure rectRankingClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmNumbers: TFrmNumbers;

implementation

{$R *.fmx}

uses UnitPrincipal, UnitRanking;

procedure TFrmNumbers.rectPlayClick(Sender: TObject);
begin
    if NOT Assigned(FrmPrincipal) then
        Application.CreateForm(TFrmPrincipal, FrmPrincipal);

    FrmPrincipal.Show;
end;

procedure TFrmNumbers.rectRankingClick(Sender: TObject);
begin
    if NOT Assigned(FrmRanking) then
        Application.CreateForm(TFrmRanking, FrmRanking);

    FrmRanking.Show;
end;

end.
