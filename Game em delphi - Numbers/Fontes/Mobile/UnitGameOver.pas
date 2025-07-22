unit UnitGameOver;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit,
  RESTRequest4D, System.JSON;

type
  TCallbackGameOver = procedure(acao: string) of Object;

  TFrmGameOver = class(TForm)
    rectVoltar: TRectangle;
    Image1: TImage;
    Image2: TImage;
    lytScore: TLayout;
    Label3: TLabel;
    lblScore: TLabel;
    rectPlay: TRectangle;
    Image3: TImage;
    Label1: TLabel;
    lytFundo: TLayout;
    Rectangle1: TRectangle;
    rectCancelar: TRectangle;
    Image4: TImage;
    edtNome: TEdit;
    Label2: TLabel;
    rectRegistrar: TRectangle;
    Label4: TLabel;
    lytLevel: TLayout;
    Label5: TLabel;
    lblLevel: TLabel;
    procedure rectPlayClick(Sender: TObject);
    procedure rectVoltarClick(Sender: TObject);
    procedure rectCancelarClick(Sender: TObject);
    procedure rectRegistrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    ExecuteOnClose: TCallbackGameOver;  // ExecutarAcao;
  end;

var
  FrmGameOver: TFrmGameOver;

implementation

{$R *.fmx}

procedure TFrmGameOver.FormShow(Sender: TObject);
begin
    lytFundo.Visible := true;
end;

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

procedure TFrmGameOver.rectRegistrarClick(Sender: TObject);
var
    Resp: IResponse;
    json: TJsonObject;
begin
    if edtNome.Text.Length < 3 then
    begin
        showmessage('Informe o nome com pelo menos 3 caracteres.');
        exit;
    end;

    try
        json := TJSONObject.Create;
        json.AddPair('nome', edtNome.Text);
        json.AddPair('level', TJSONNumber.Create(lblLevel.Text));
        json.AddPair('pontos', TJSONNumber.Create(lblScore.Text));

        Resp := TRequest.New.BaseURL('http://localhost:9000')
                .Resource('ranking')
                .BasicAuthentication('numbers', 'numbers')
                .AddBody(json.ToJSON)
                .Accept('application/json')
                .Post;

        if Resp.StatusCode <> 201 then
        begin
            showmessage('Erro ao salvar o placar: ' + Resp.Content);
            exit;
        end;

        lytFundo.Visible := false;

    finally
        json.disposeof;
    end;
end;

procedure TFrmGameOver.rectVoltarClick(Sender: TObject);
begin
    close;

    if Assigned(ExecuteOnClose) then
        ExecuteOnClose('CLOSE');
end;

end.
