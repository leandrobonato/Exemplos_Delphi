program dprCriacaoBase;

uses
  System.StartUpCopy,
  FMX.Forms,
  unPrincipal in 'unPrincipal.pas' {frmPrincipal},
  unDataModule in 'unDataModule.pas' {frmDataModule: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmDataModule, frmDataModule);
  Application.Run;
end.
