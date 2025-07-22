program Project1;

{$R *.res}

uses
  FastMM4 in 'C:\Users\DELPHI\Desktop\componentes\FastMM4-master\FastMM4.pas',
  vcl.forms,
  unit_DataModule in 'C:\Users\DELPHI\Desktop\SoftSig\dms\Softsig_branches\dmscontroller\unit_DataModule.pas' {dm: TDataModule},
  uDmFiscal in 'C:\Users\DELPHI\Desktop\SoftSig\dms\Softsig_branches\dmscontroller\uDmFiscal.pas' {dmFiscal: TDataModule},
  uFrmEnvioSAT in 'C:\Users\DELPHI\Desktop\SoftSig\dms\Softsig_branches\dmscontroller\uFrmEnvioSAT.pas' {frmEnvioSAT},
  unit_consts in 'C:\Users\DELPHI\Desktop\SoftSig\dms\Softsig_branches\dmscontroller\geral\unit_consts.pas',
  unFrmProgresso in 'C:\Users\DELPHI\Desktop\SoftSig\dms\Softsig_branches\dmscontroller\unFrmProgresso.pas' {frmProgresso},
  unit_classes in 'C:\Users\DELPHI\Desktop\SoftSig\dms\Softsig_branches\dmscontroller\sistema\unit_classes.pas',
  unit_rotinas in 'C:\Users\DELPHI\Desktop\SoftSig\dms\Softsig_branches\dmscontroller\sistema\unit_rotinas.pas',
  unit_tiposdados in 'C:\Users\DELPHI\Desktop\SoftSig\dms\Softsig_branches\dmscontroller\sistema\unit_tiposdados.pas',
  unit_funcoes_gerais in 'C:\Users\DELPHI\Desktop\SoftSig\dms\Softsig_branches\dmscontroller\FrameWork\unit_funcoes_gerais.pas',
  uClasse_XMLSat in 'C:\Users\DELPHI\Desktop\SoftSig\dms\Softsig_branches\dmscontroller\uClasse_XMLSat.pas',
  unit_Registro in 'C:\Users\DELPHI\Desktop\SoftSig\dms\Softsig_branches\dmscontroller\sistema\unit_Registro.pas',
  unFrmPesquisaPadrao in 'C:\Users\DELPHI\Desktop\SoftSig\dms\Softsig_branches\dmscontroller\unFrmPesquisaPadrao.pas' {frmPesquisaPadrao},
  uPadrao in 'C:\Users\DELPHI\Desktop\SoftSig\dms\Softsig_branches\dmscontroller\geral\uPadrao.pas' {frmPadraoCadastro};

begin
  FullDebugModeScanMemoryPoolBeforeEveryOperation := True;
  SuppressMessageBoxes := False;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TdmFiscal, dmFiscal);
  Application.CreateForm(TfrmEnvioSAT, frmEnvioSAT);
  Application.CreateForm(TfrmProgresso, frmProgresso);
  Application.CreateForm(TfrmPesquisaPadrao, frmPesquisaPadrao);
  Application.CreateForm(TfrmPadraoCadastro, frmPadraoCadastro);
  Application.Run;
end.
