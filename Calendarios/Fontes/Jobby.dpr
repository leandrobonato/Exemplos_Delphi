program Jobby;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {FrmPrincipal},
  Frame.Dia in 'Frames\Frame.Dia.pas' {FrameDia: TFrame},
  uLoading in 'Units\uLoading.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
