program FileTransfer;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {Form1},
  u99Permissions in 'Units\u99Permissions.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
