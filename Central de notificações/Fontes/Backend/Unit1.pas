unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, System.JSON,

  Horse,
  Horse.Jhonson;

type
  TForm1 = class(TForm)
    memo: TMemo;
    procedure FormShow(Sender: TObject);
  private
    procedure GetNotificacao(Req: THorseRequest; Res: THorseResponse;
      Next: TNextProc);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.GetNotificacao(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
    json: TJSONObject;
begin
    json := TJSONObject.Create;
    json.AddPair('id_usuario', TJSONNumber.Create(Req.Params.Items['id'].ToInteger));
    json.AddPair('id_message', TJSONNumber.Create(123));
    json.AddPair('url', 'https://99coders.s3.amazonaws.com/icone.png');
    json.AddPair('message', 'Uma nova versão do app está disponível.');
    json.AddPair('button', 'Atualizar');
    json.AddPair('action', 'open-url'); // open-form, etc...
    json.AddPair('action_param', 'https://play.google.com/store/apps/details?id=br.com.wine.app&hl=pt'); // frmCliente, etc...

    Res.Send<TJsonObject>(json);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
    THorse.Use(Jhonson());

    THorse.Get('/usuarios/:id/notificacoes', GetNotificacao);

    THorse.Listen(9000, procedure(Horse: THorse)
    begin
        memo.Lines.Add('Servidor executando na porta: ' + Horse.Port.ToString);
    end);
end;

end.
