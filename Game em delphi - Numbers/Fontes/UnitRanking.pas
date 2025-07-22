unit UnitRanking;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.ListBox;

type
  TFrmRanking = class(TForm)
    rectVoltar: TRectangle;
    Image1: TImage;
    Image2: TImage;
    lb_ranking: TListBox;
    imgGold: TImage;
    procedure FormShow(Sender: TObject);
    procedure rectVoltarClick(Sender: TObject);
  private
    procedure AddRanking(posicao, pontos: integer; nome: string);
    procedure CarregarRanking;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRanking: TFrmRanking;

implementation

{$R *.fmx}

uses UnitFrameRanking;

procedure TFrmRanking.AddRanking(posicao, pontos: integer; nome: string);
var
    item : TListBoxItem;
    frame: TFrameRanking;
begin
    item := TListBoxItem.Create(lb_ranking);
    item.Parent := lb_ranking;
    item.Text := '';
    item.Selectable := false;
    item.Height := 60;

    frame := TFrameRanking.Create(item);
    frame.Parent := item;
    frame.lbl_posicao.Text := posicao.ToString;
    frame.lbl_nome.Text := nome;
    frame.lbl_pontuacao.Text := FormatFloat('#,##', pontos);

    if posicao = 1 then
        frame.imgMedalha.bitmap := imgGold.Bitmap;

    item.AddObject(frame);

    lb_ranking.AddObject(item);
end;

procedure TFrmRanking.CarregarRanking;
var
    i : integer;
begin
    // Buscar dados do nosso backend (servidor)...

    for i := 1 to 10 do
        AddRanking(i, i * 100, 'Heber');
end;

procedure TFrmRanking.FormShow(Sender: TObject);
begin
    CarregarRanking;
end;

procedure TFrmRanking.rectVoltarClick(Sender: TObject);
begin
    close;
end;

end.
