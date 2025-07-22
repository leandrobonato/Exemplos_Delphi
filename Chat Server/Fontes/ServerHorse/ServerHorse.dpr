program ServerHorse;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {FrmPrincipal},
  DataModule.Global in 'DataModule\DataModule.Global.pas' {DmGlobal: TDataModule},
  Controllers.Mensagem in 'Controllers\Controllers.Mensagem.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
