program Server;

uses
  FastMM4,
  Vcl.Forms,
  Server.Container in 'Server.Container.pas' {ServerContainer: TDataModule},
  Vcl.Server.Main in 'Vcl.Server.Main.pas' {MainForm},
  TesteService in 'TesteService.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TServerContainer, ServerContainer);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
