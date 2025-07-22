unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListBox, FMX.Layouts, FMX.Ani;

type
  TFrmPrincipal = class(TForm)
    rectToolbar: TRectangle;
    Label21: TLabel;
    imgMenu: TImage;
    rectAbas: TRectangle;
    imgAdd: TImage;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    Image2: TImage;
    Label5: TLabel;
    Label6: TLabel;
    Line1: TLine;
    Line2: TLine;
    ListBoxItem2: TListBoxItem;
    Label7: TLabel;
    Label8: TLabel;
    Line4: TLine;
    Image3: TImage;
    ListBoxItem3: TListBoxItem;
    Label9: TLabel;
    Label10: TLabel;
    Line3: TLine;
    Line5: TLine;
    Image4: TImage;
    ListBoxItem4: TListBoxItem;
    Label11: TLabel;
    Label12: TLabel;
    Line6: TLine;
    Line7: TLine;
    Image5: TImage;
    ListBoxItem5: TListBoxItem;
    Label13: TLabel;
    Label14: TLabel;
    Line8: TLine;
    Line9: TLine;
    Image6: TImage;
    ListBoxItem6: TListBoxItem;
    Label15: TLabel;
    Label16: TLabel;
    Line10: TLine;
    Line11: TLine;
    Image7: TImage;
    ListBoxItem7: TListBoxItem;
    Label17: TLabel;
    Label18: TLabel;
    Line12: TLine;
    Line13: TLine;
    Image8: TImage;
    ListBoxItem8: TListBoxItem;
    Label19: TLabel;
    Label20: TLabel;
    Line14: TLine;
    Line15: TLine;
    Image9: TImage;
    rectMenuAdd: TRectangle;
    lytMenu: TLayout;
    lblCliente: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    imgFechar: TImage;
    AnimationMenuAdd: TFloatAnimation;
    rectMenuLateral: TRectangle;
    Layout1: TLayout;
    Label1: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    imgFecharMenu: TImage;
    AnimationMenuLateral: TFloatAnimation;
    Label25: TLabel;
    Layout2: TLayout;
    Rectangle1: TRectangle;
    Label27: TLabel;
    Label28: TLabel;
    Image10: TImage;
    procedure imgAddClick(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
    procedure AnimationMenuAddFinish(Sender: TObject);
    procedure lblClienteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imgMenuClick(Sender: TObject);
    procedure AnimationMenuLateralFinish(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    procedure Menu(open: boolean);
    procedure MenuLateral;
    procedure SetMenuLateral;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

// Menu adicionar ------------------------------------------------
procedure TFrmPrincipal.AnimationMenuAddFinish(Sender: TObject);
begin
    if AnimationMenuAdd.Inverse then // Fechando o menu...
        rectMenuAdd.Visible := false;
end;

procedure TFrmPrincipal.Menu(open: boolean);
begin
    if open then  // Abrindo o menu...
    begin
        AnimationMenuAdd.Inverse := false;
        rectMenuAdd.Opacity := 0;
        rectMenuAdd.Visible := true;

        TAnimator.AnimateFloat(rectMenuAdd, 'Opacity', 1, 0.3);
    end
    else   // Fechando o menu...
    begin
        AnimationMenuAdd.Inverse := true;
        TAnimator.AnimateFloat(rectMenuAdd, 'Opacity', 0, 0.2);
    end;

    AnimationMenuAdd.Start;
end;

procedure TFrmPrincipal.imgFecharClick(Sender: TObject);
begin
     Menu(false);
end;

procedure TFrmPrincipal.lblClienteClick(Sender: TObject);
begin
     Menu(false);

     // Abrir o form de clientes...
end;

procedure TFrmPrincipal.imgAddClick(Sender: TObject);
begin
    Menu(true);
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
    // Setup inicial do menu adicionar...
    rectMenuAdd.Visible := false;

    // Setup inicial do menu lateral...
    SetMenuLateral;
end;



// Menu lateral ---------------------------------------------------

procedure TFrmPrincipal.FormResize(Sender: TObject);
begin
    SetMenuLateral;
end;

procedure TFrmPrincipal.AnimationMenuLateralFinish(Sender: TObject);
begin
    AnimationMenuLateral.Inverse := NOT AnimationMenuLateral.Inverse;
end;

procedure TFrmPrincipal.SetMenuLateral;
begin
    rectMenuLateral.Visible := true;
    AnimationMenuLateral.StartValue := rectToolbar.Width + 20;

    if rectMenuLateral.Margins.Right > 0 then  // Menu fechado...
        rectMenuLateral.Margins.Right := rectToolbar.Width + 20;
end;

procedure TFrmPrincipal.MenuLateral;
begin
    AnimationMenuLateral.Start;
end;

procedure TFrmPrincipal.imgMenuClick(Sender: TObject);
begin
    MenuLateral;
end;


end.
