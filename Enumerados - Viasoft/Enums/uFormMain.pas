unit uFormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ACBrBase, ACBrDFe, ACBrNFe,
  Vcl.ExtCtrls, Vcl.CheckLst, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxImageComboBox, cxGroupBox, cxRadioGroup;

type
  TFormMain = class(TForm)
    Button1: TButton;
    cbSituacao: TComboBox;
    clbSituacao: TCheckListBox;
    rgSituacao: TRadioGroup;
    Button2: TButton;
    Button3: TButton;
    cxImageComboBox1: TcxImageComboBox;
    cxImageComboBox2: TcxImageComboBox;
    Button4: TButton;
    cxRadioGroup1: TcxRadioGroup;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure cbSituacaoChange(Sender: TObject);
    procedure rgSituacaoClick(Sender: TObject);
    procedure clbSituacaoClickCheck(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    procedure Fill(pItems: TStrings);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

uses
  EnumHelper, EnumTypes, uFormDF, uDmRepos;

{$R *.dfm}

{ TFormMain }

procedure TFormMain.Button1Click(Sender: TObject);
begin
  Fill(cbSituacao.Items);
end;

procedure TFormMain.Button2Click(Sender: TObject);
begin
  Fill(clbSituacao.Items);
end;

procedure TFormMain.Button3Click(Sender: TObject);
begin
  Fill(rgSituacao.Items);
end;

procedure TFormMain.Button4Click(Sender: TObject);
var
  oForm: TFormDF;
begin
  oForm := TFormDF.Create(Self);
  try
    oForm.ShowModal;
  finally
    FreeAndNil(oForm);
  end;
end;

procedure TFormMain.cbSituacaoChange(Sender: TObject);
begin
  if cbSituacao.ItemIndex > -1 then
    ShowMessage(TEnumUtils<TSituacaoCadastro>.GetByDescricao(cbSituacao.Items[cbSituacao.ItemIndex]).Codigo);
end;

procedure TFormMain.clbSituacaoClickCheck(Sender: TObject);
begin
  if clbSituacao.ItemIndex > -1 then
    ShowMessage(TEnumUtils<TSituacaoCadastro>.GetByDescricao(clbSituacao.Items[clbSituacao.ItemIndex]).Codigo);
end;

procedure TFormMain.Fill(pItems: TStrings);
begin
//  TEnumUtils<TSituacaoCadastro>.Fill(pItems, TSituacaoCadastroCad);
  TEnumUtils<TSituacaoCadastroSel>.Fill(pItems);
end;

procedure TFormMain.rgSituacaoClick(Sender: TObject);
begin
  if rgSituacao.ItemIndex > -1 then
    ShowMessage(TEnumUtils<TSituacaoCadastro>.GetByDescricao(rgSituacao.Items[rgSituacao.ItemIndex]).Codigo);
end;

end.
