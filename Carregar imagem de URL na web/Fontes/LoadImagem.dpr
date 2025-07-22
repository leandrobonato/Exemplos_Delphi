program LoadImagem;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {Form1},
  AnonThread in 'Units\AnonThread.pas',
  FMX.BitmapHelper in 'Units\FMX.BitmapHelper.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
