program Client;

uses
  FastMM4,
  Vcl.Forms,
  Vcl.Client.Main in 'Vcl.Client.Main.pas' {Form13},
  TesteService in 'TesteService.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm13, Form13);
  Application.Run;
end.
