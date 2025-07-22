program EnumRtti;

uses
  Vcl.Forms,
  uFormMain in 'uFormMain.pas' {FormMain},
  EnumTypes in 'EnumTypes.pas',
  EnumHelper in 'EnumHelper.pas',
  uDmRepos in 'uDmRepos.pas' {dmRepos: TDataModule},
  uDmDF in 'uDmDF.pas' {dmDF: TDataModule},
  uFormDF in 'uFormDF.pas' {FormDF};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TdmRepos, dmRepos);
  Application.CreateForm(TdmDF, dmDF);
  Application.Run;
end.
