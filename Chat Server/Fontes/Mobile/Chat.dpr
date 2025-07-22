program Chat;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitChat in 'UnitChat.pas' {FrmChat},
  UnitPrincipal in 'UnitPrincipal.pas' {FrmPrincipal},
  DataModule.Global in 'DataModule\DataModule.Global.pas' {DmGlobal: TDataModule},
  uSession in 'Units\uSession.pas',
  uFunctions in 'Units\uFunctions.pas',
  UnitNovoChat in 'UnitNovoChat.pas' {FrmNovoChat};

{$R *.res}

begin
  //ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmChat, FrmChat);
  Application.CreateForm(TDmGlobal, DmGlobal);
  Application.CreateForm(TFrmNovoChat, FrmNovoChat);
  Application.Run;
end.
