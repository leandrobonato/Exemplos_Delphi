unit UnitRanking;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.ListBox, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  RESTRequest4D, uLoading;

type
  TFrmRanking = class(TForm)
    rectVoltar: TRectangle;
    Image1: TImage;
    Image2: TImage;
    lb_ranking: TListBox;
    imgGold: TImage;
    TabPlacar: TFDMemTable;
    procedure FormShow(Sender: TObject);
    procedure rectVoltarClick(Sender: TObject);
  private
    procedure AddRanking(posicao, pontos: integer; nome: string);
    procedure CarregarRanking;
    procedure ThreadTerminate(Sender: TOBject);
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
    frame.lbl_pontuacao.Text := FormatFloat(',0', pontos);

    if posicao = 1 then
        frame.imgMedalha.bitmap := imgGold.Bitmap;

    item.AddObject(frame);

    lb_ranking.AddObject(item);
end;

procedure TFrmRanking.ThreadTerminate(Sender: TOBject);
begin
    TLoading.Hide;

    if Sender is TThread then
    begin
        if Assigned(TThread(Sender).FatalException) then
        begin
            showmessage(Exception(TThread(sender).FatalException).Message);
            exit;
        end;
    end;
end;

procedure TFrmRanking.CarregarRanking;
var
    i : integer;
    t: TThread;
begin
    lb_ranking.Items.Clear;
    TabPlacar.FieldDefs.Clear;
    TLoading.Show(FrmRanking, '');

    t := TThread.CreateAnonymousThread(procedure
    var
        Resp: IResponse;
    begin
        Resp := TRequest.New.BaseURL('http://localhost:9000')
                .Resource('ranking')
                .BasicAuthentication('numbers', 'numbers')
                .DataSetAdapter(TabPlacar)
                .Accept('application/json')
                .Get;

        if Resp.StatusCode <> 200 then
            raise Exception.Create(Resp.Content);

        while NOT TabPlacar.Eof do
        begin
            TThread.Synchronize(tthread.CurrentThread, procedure
            begin
                AddRanking(TabPlacar.RecNo,
                           TabPlacar.fieldbyname('pontos').AsInteger,
                           TabPlacar.fieldbyname('nome').AsString);
            end);


            TabPlacar.Next;
        end;

    end);

    t.OnTerminate := ThreadTerminate;
    t.Start;

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
