program Project9;

uses
  Vcl.Forms,
  Unit9 in 'Unit9.pas' {Form9},
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm9, Form9);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
