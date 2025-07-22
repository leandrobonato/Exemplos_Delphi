unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, pcnConversao;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ComboBox1: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  TypInfo;

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  Ind: TpcnIndicadorPagamento;
  vOut: Boolean;
begin
  showMessage(GetEnumName(TypeInfo(TpcnIndicadorPagamento), Ord(ComboBox1.ItemIndex)));
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Ind: TpcnIndicadorPagamento;
  nome: String;
  valor: Variant;
  I: Integer;
begin
  ComboBox1.Items.Clear;
  ind:= low(pcnConversao.TpcnIndicadorPagamento);
  while ind <= High(pcnConversao.TpcnIndicadorPagamento) do
  begin
    nome  := GetEnumName(TypeInfo(TpcnIndicadorPagamento), Ord(Ind));
    valor := GetEnumValue(TypeInfo(TpcnIndicadorPagamento), nome);
    case valor of
      0: nome := 'À Vista';
      1: nome := 'À prazo';
      2: nome := 'Outras formas de pagamento';
      3: nome := 'Nenhum';
    end;
    ComboBox1.Items.Add(nome);
    Inc(Ind);
  end;
end;

end.
