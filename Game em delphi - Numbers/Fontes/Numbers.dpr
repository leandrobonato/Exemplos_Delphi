program Numbers;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitMenu in 'UnitMenu.pas' {FrmNumbers},
  UnitPrincipal in 'UnitPrincipal.pas' {FrmPrincipal},
  UnitGameOver in 'UnitGameOver.pas' {FrmGameOver},
  UnitRanking in 'UnitRanking.pas' {FrmRanking},
  UnitFrameRanking in 'UnitFrameRanking.pas' {FrameRanking: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(TFrmNumbers, FrmNumbers);
  Application.Run;
end.
