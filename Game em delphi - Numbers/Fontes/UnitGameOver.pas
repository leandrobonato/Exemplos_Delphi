unit UnitGameOver;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit;

type
  TCallbackGameOver = procedure(acao: string) of Object;

  TFrmGameOver = class(TForm)
    rectVoltar: TRectangle;
    Image1: TImage;
    Image2: TImage;
    Layout1: TLayout;
    Label3: TLabel;
    lblScore: TLabel;
    rectPlay: TRectangle;
    Image3: TImage;
    Label1: TLabel;
    lytFundo: TLayout;
    Rectangle1: TRectangle;
    rectCancelar: TRectangle;
    Image4: TImage;
    Edit1: TEdit;
    Label2: TLabel;
    rectRegistrar: TRectangle;
    Label4: TLabel;
    procedure rectPlayClick(Sender: TObject);
    procedure rectVoltarClick(Sender: TObject);
    procedure rectCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    ExecuteOnClose: TCallbackGameOver;  // ExecutarAcao;
  end;

var
  FrmGameOver: TFrmGameOver;

implementation

{$R *.fmx}

procedure TFrmGameOver.rectCancelarClick(Sender: TObject);
begin
    lytFundo.Visible := false;
end;

procedure TFrmGameOver.rectPlayClick(Sender: TObject);
begin
    close;

    if Assigned(ExecuteOnClose) then
        ExecuteOnClose('PLAY');
end;

procedure TFrmGameOver.rectVoltarClick(Sender: TObject);
begin
    close;

    if Assigned(ExecuteOnClose) then
        ExecuteOnClose('CLOSE');
end;

end.
