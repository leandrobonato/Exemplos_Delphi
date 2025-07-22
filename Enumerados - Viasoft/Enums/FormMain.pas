unit FormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ACBrBase, ACBrDFe, ACBrNFe;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ComboBox1: TComboBox;
    ACBrNFe1: TACBrNFe;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  EnumHelper, EnumTypes;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  sTexto: String;
  Enum: TSituacaoCadastro;
begin
  Enum := TEnumHelper<TSituacaoCadastro>.GetByCod('INT').Enum;
  sTexto := TEnumHelper<TSituacaoCadastro>.GetByEnum(Enum).Descricao;

  TEnumHelper<TSituacaoCadastro>.Fill(Combobox1.Items, [scAtivo, scInativo]);

  ShowMessage(sTexto);
end;

end.
