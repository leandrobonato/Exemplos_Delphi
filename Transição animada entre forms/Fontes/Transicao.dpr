program Transicao;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {FrmPrincipal},
  UnitProduto in 'UnitProduto.pas' {FrmProduto},
  UnitPerfil in 'UnitPerfil.pas' {FrmPerfil};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
