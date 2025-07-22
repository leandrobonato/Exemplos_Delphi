unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListBox, FMX.Ani;

type
  TFrmPrincipal = class(TForm)
    lytFundo: TLayout;
    ListBox: TListBox;
    ListBoxItem1: TListBoxItem;
    Image1: TImage;
    Layout2: TLayout;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Line1: TLine;
    ListBoxItem2: TListBoxItem;
    Image5: TImage;
    Layout3: TLayout;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Line2: TLine;
    ListBoxItem3: TListBoxItem;
    Image6: TImage;
    Layout4: TLayout;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Line3: TLine;
    ListBoxItem4: TListBoxItem;
    Image7: TImage;
    Layout5: TLayout;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Line4: TLine;
    lyt_pesquisa: TLayout;
    lbl_qtd: TLabel;
    Line5: TLine;
    rect_toolbar: TRectangle;
    Label1: TLabel;
    Image2: TImage;
    Image3: TImage;
    Rectangle2: TRectangle;
    Image4: TImage;
    Label2: TLabel;
    AnimationForm: TFloatAnimation;
    procedure ListBoxItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure AnimationFormFinish(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private
    FFrm: TForm;
    procedure OpenForm(Classe: TComponentClass; Frm: TForm);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses UnitProduto, UnitPerfil;

procedure TFrmPrincipal.OpenForm(Classe: TComponentClass; Frm: TForm);
begin
    if NOT Assigned(Frm) then
            Application.CreateForm(Classe, Frm);

    FFrm := Frm;

    //Frm.show;
    AnimationForm.start;
end;

procedure TFrmPrincipal.AnimationFormFinish(Sender: TObject);
begin
    if NOT AnimationForm.Inverse then
    begin
        AnimationForm.Tag := 1;

        FFrm.Show;
    end;

    AnimationForm.Inverse := NOT AnimationForm.Inverse;
end;

procedure TFrmPrincipal.FormActivate(Sender: TObject);
begin
    if AnimationForm.Tag > 0 then
        AnimationForm.Start;
end;

procedure TFrmPrincipal.Label2Click(Sender: TObject);
begin
    OpenForm(TFrmPerfil, FrmPerfil);
end;

procedure TFrmPrincipal.ListBoxItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
    OpenForm(TFrmProduto, FrmProduto);
end;

end.
