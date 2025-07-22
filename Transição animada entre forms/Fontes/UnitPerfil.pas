unit UnitPerfil;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Ani,
  FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFrmPerfil = class(TForm)
    lytFundo: TLayout;
    Rectangle1: TRectangle;
    Label1: TLabel;
    img_back: TImage;
    FloatAnimation1: TFloatAnimation;
    Label4: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure img_backClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPerfil: TFrmPerfil;

implementation

{$R *.fmx}

procedure TFrmPerfil.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := TCloseAction.caFree;
    FrmPerfil := nil;
end;

procedure TFrmPerfil.FormCreate(Sender: TObject);
begin
    lytFundo.Opacity := 0;
end;

procedure TFrmPerfil.FormShow(Sender: TObject);
begin
    lytFundo.Opacity := 0;
    FloatAnimation1.Start;
end;

procedure TFrmPerfil.img_backClick(Sender: TObject);
begin
    close;
end;

end.
