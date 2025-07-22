program Servidor;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {FrmPrincipal},
  Controllers.Usuario in 'Controllers\Controllers.Usuario.pas',
  uFunctions in 'Units\uFunctions.pas',
  DataModule.Global in 'DataModules\DataModule.Global.pas' {Dm: TDataModule},
  uMD5 in 'Units\uMD5.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
