program Perfil;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitLogin in 'UnitLogin.pas' {FrmLogin},
  UnitPrincipal in 'UnitPrincipal.pas' {FrmPrincipal},
  UnitPerfil in 'UnitPerfil.pas' {FrmPerfil},
  u99Permissions in 'Units\u99Permissions.pas',
  DataModule.Global in 'DataModules\DataModule.Global.pas' {Dm: TDataModule},
  uLoading in 'Units\uLoading.pas',
  uFunctions in 'Units\uFunctions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TDm, Dm);
  Application.Run;
end.
