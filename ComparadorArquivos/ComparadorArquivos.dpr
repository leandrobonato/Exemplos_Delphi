program ComparadorArquivos;

uses
  Vcl.Forms,
  unFrmComparador in 'unFrmComparador.pas' {frmComparadorArquivos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmComparadorArquivos, frmComparadorArquivos);
  Application.Run;
end.
