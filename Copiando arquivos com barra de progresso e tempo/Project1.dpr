program Project1;

uses
  Vcl.Forms,
  Unit2 in 'Unit2.pas' {frmProgressoCopiaArquivo};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmProgressoCopiaArquivo, frmProgressoCopiaArquivo);
  Application.Run;
end.
