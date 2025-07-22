program ServerRDW;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {FrmPrincipal},
  DataModule.Services in 'DataModule\DataModule.Services.pas' {DmServices: TDataModule},
  DataModule.Global in 'DataModule\DataModule.Global.pas' {DmGlobal: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TDmServices, DmServices);
  Application.Run;
end.
