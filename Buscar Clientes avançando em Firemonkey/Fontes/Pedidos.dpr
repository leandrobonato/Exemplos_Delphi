program Pedidos;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitPedido in 'UnitPedido.pas' {FrmPedido},
  UnitDM in 'UnitDM.pas' {Dm: TDataModule},
  UnitBuscaCliente in 'UnitBuscaCliente.pas' {FrmBuscaCliente};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPedido, FrmPedido);
  Application.CreateForm(TDm, Dm);
  Application.CreateForm(TFrmBuscaCliente, FrmBuscaCliente);
  Application.Run;
end.
