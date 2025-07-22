unit UnitProduto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani;

type
  TFrmProduto = class(TForm)
    lytFundo: TLayout;
    rect_compra: TRectangle;
    Label2: TLabel;
    Rectangle1: TRectangle;
    Label1: TLabel;
    img_back: TImage;
    VertScrollBox1: TVertScrollBox;
    Layout1: TLayout;
    Image1: TImage;
    Label4: TLabel;
    Label5: TLabel;
    Image2: TImage;
    Image3: TImage;
    AnimationForm: TFloatAnimation;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure img_backClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmProduto: TFrmProduto;

implementation

{$R *.fmx}

procedure TFrmProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := TCloseAction.caFree;
    FrmProduto := nil;
end;

procedure TFrmProduto.FormCreate(Sender: TObject);
begin
    lytFundo.Opacity := 0;
end;

procedure TFrmProduto.FormShow(Sender: TObject);
begin
    AnimationForm.Start;
end;

procedure TFrmProduto.img_backClick(Sender: TObject);
begin
    close;
end;

end.
