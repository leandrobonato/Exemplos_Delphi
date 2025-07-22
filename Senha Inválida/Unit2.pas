unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask;

type
  TForm2 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    MaskEdit1: TMaskEdit;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.BitBtn1Click(Sender: TObject);
var
  vPosicaoOriginal: Integer;
begin
  MaskEdit1.Color := $00A8A8FF;
  MaskEdit1.StyleElements := [seFont, seClient];
  MaskEdit1.Brush.Style := bsClear;

  vPosicaoOriginal := Self.Left;
  sleep(25);
  Self.Left := Self.Left + 10;
  sleep(25);
  Self.Left := Self.Left - 20;
  sleep(25);
  Self.Left := Self.Left + 20;
  sleep(25);
  Self.Left := Self.Left - 20;
  sleep(25);
  Self.Left := vPosicaoOriginal;

  MaskEdit1.SetFocus;

end;

end.
