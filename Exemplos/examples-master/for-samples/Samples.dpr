program Samples;

uses
  Vcl.Forms,
  Samples.Main in 'src\Samples.Main.pas' {FrmMain},
  Samples.Product in 'src\Samples.Product.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
