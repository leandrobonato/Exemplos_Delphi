unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation,

  {$IFDEF ANDROID}
  Execute.FMXBasedDragDrop,
  {$ENDIF}

  FMX.StdCtrls, FMX.Ani;

type
  TFrmPrincipal = class(TForm)
    lytToolbar: TLayout;
    rectPlacar: TRectangle;
    Label1: TLabel;
    lblPlacar: TLabel;
    rectVoltar: TRectangle;
    Image1: TImage;
    Layout1: TLayout;
    Label3: TLabel;
    lblLevel: TLabel;
    GridLayout: TGridLayout;
    Rectangle1: TRectangle;
    lblQuadrado1: TLabel;
    Rectangle2: TRectangle;
    lblQuadrado2: TLabel;
    Rectangle3: TRectangle;
    lblQuadrado3: TLabel;
    Rectangle4: TRectangle;
    Label6: TLabel;
    Rectangle5: TRectangle;
    Label7: TLabel;
    Rectangle6: TRectangle;
    Label8: TLabel;
    Rectangle7: TRectangle;
    Label9: TLabel;
    Rectangle8: TRectangle;
    Label10: TLabel;
    Rectangle9: TRectangle;
    Label11: TLabel;
    Rectangle10: TRectangle;
    Label12: TLabel;
    Rectangle11: TRectangle;
    Label13: TLabel;
    Rectangle12: TRectangle;
    Label14: TLabel;
    Rectangle13: TRectangle;
    Label15: TLabel;
    Rectangle14: TRectangle;
    Label16: TLabel;
    Rectangle15: TRectangle;
    Label17: TLabel;
    Rectangle16: TRectangle;
    Label18: TLabel;
    Rectangle17: TRectangle;
    Label19: TLabel;
    Rectangle18: TRectangle;
    Label20: TLabel;
    Rectangle19: TRectangle;
    Label21: TLabel;
    Rectangle20: TRectangle;
    Label22: TLabel;
    AnimationGame: TFloatAnimation;
    TimerLevel: TTimer;
    Arc1: TArc;
    AnimationArco: TFloatAnimation;
    procedure rectVoltarClick(Sender: TObject);
    procedure lblQuadrado1DragDrop(Sender: TObject; const Data: TDragObject;
      const Point: TPointF);
    procedure lblQuadrado1DragOver(Sender: TObject; const Data: TDragObject;
      const Point: TPointF; var Operation: TDragOperation);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure AnimationGameFinish(Sender: TObject);
    procedure TimerLevelTimer(Sender: TObject);
  private
    procedure SomarPontos(pontos: integer);
    procedure ExecutarAcao(acao: string);
    procedure Reset;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses UnitGameOver;

procedure TFrmPrincipal.Reset;
var
    lbl: TLabel;
    rect : TRectangle;
    i: integer;
begin
    lblPlacar.Text := '0';
    lblLevel.Text := '1';
    lblLevel.Tag := 1;
    AnimationGame.Duration := 1; // 1 segundo...

    for i := 0 to GridLayout.ChildrenCount - 1 do
        if GridLayout.Children[i] is TRectangle then
        begin
            rect := TRectangle(GridLayout.Children[i]);

            lbl := TLabel(rect.Children[0]);
            lbl.Text := '';
            lbl.Tag := 0;
        end;

    AnimationGame.Start;
    AnimationArco.Start;
    TimerLevel.Enabled := true;
end;

procedure TFrmPrincipal.SomarPontos(pontos: integer);
begin
    lblPlacar.Text := inttostr(lblPlacar.Text.ToInteger + pontos);
end;

procedure TFrmPrincipal.TimerLevelTimer(Sender: TObject);
begin
    lblLevel.Tag := lblLevel.Tag + 1;
    lblLevel.Text := lblLevel.Tag.ToString;
    AnimationGame.Duration := AnimationGame.Duration - 0.05;
end;

procedure TFrmPrincipal.ExecutarAcao(acao: string);
begin
    if acao = 'PLAY' then
        Reset
    else if acao = 'CLOSE' then
        close;
end;

procedure TFrmPrincipal.AnimationGameFinish(Sender: TObject);
var
    i, cont: integer;
    lbl: TLabel;
    arrayNum: array of Integer;
begin
    cont := 0;

    for i := 0 to GridLayout.ChildrenCount - 1 do // i = posicao objeto quadrado branco
    begin
        lbl := TLabel(TRectangle(GridLayout.Children[i]).Children[0]);

        if lbl.Tag = 0 then
        begin
            Inc(cont);
            SetLength(arrayNum, cont);

            arrayNum[cont - 1] := i;
        end;
    end;

    // Se possui quadrados vazios...
    if cont > 0 then
    begin
        i := Random(Length(arrayNum));

        lbl := TLabel(TRectangle(GridLayout.Children[arrayNum[i]]).Children[0]);
        lbl.Text := '2';
        lbl.Tag := 2;
        AnimationGame.Start;
    end
    else
    // Game Over...
    begin
        TimerLevel.Enabled := false;
        AnimationGame.Enabled := false;
        AnimationArco.Stop;

        if NOT Assigned(FrmGameOver) then
            Application.CreateForm(TFrmGameOver, FrmGameOver);

        FrmGameOver.ExecuteOnClose := ExecutarAcao;
        //FrmGameOver.ExecuteOnClose := nil;
        FrmGameOver.lblScore.text := lblPlacar.Text;
        FrmGameOver.Show;
    end;
end;

procedure TFrmPrincipal.FormResize(Sender: TObject);
begin
    GridLayout.ItemWidth := Trunc(GridLayout.Width / 4) - 1;
    GridLayout.ItemHeight := Trunc(GridLayout.Height / 5) - 1;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
    Reset;
end;

procedure TFrmPrincipal.lblQuadrado1DragDrop(Sender: TObject;
  const Data: TDragObject; const Point: TPointF);
var
    lblOrigem, lblDestino : TLabel;
begin
    lblDestino := TLabel(Sender); // Onde eu soltei (destino)
    lblOrigem := TLabel(Data.Source); // Quem eu arrastei (origem)

    if (lblOrigem.Tag > 0) and (lblDestino.Tag > 0) then
    begin
        SomarPontos(lblDestino.Tag);

        lblDestino.Tag := lblDestino.Tag + lblOrigem.Tag;
        lblDestino.Text := lblDestino.Tag.ToString;

        lblOrigem.Tag := 0;
        lblOrigem.Text := '';
    end;
end;

procedure TFrmPrincipal.lblQuadrado1DragOver(Sender: TObject;
  const Data: TDragObject; const Point: TPointF; var Operation: TDragOperation);
begin
    Operation := TDragOperation.None;

    if (Sender is TLabel) and // Onde eu movi (destino)
       (Data.Source is TLabel) and // Quem eu estou arrastando (origem)
       (Data.Source <> Sender) then // Origem <> Destino
    begin
        if (TLabel(Data.Source).Tag = TLabel(Sender).Tag) and
           (TLabel(Sender).Tag > 0) then
            Operation := TDragOperation.Move;
    end;
end;

procedure TFrmPrincipal.rectVoltarClick(Sender: TObject);
begin
    TimerLevel.Enabled := false;
    AnimationGame.Enabled := false;
    close;
end;

end.
