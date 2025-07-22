unit UfrmYouTube;
{
Voc� pode gerar um arquivo html tempor�rio, somente com o c�digo embbeded do v�deo no youtube, e carregar este html tempor�rio em um TWebbrowser.
Este "c�digo embbeded" voc� consegue ao visualizar qualquer v�deo no youtube, clicando no bot�o "Incorporar",
logo abaixo do v�deo. Se voc� notar, a �nica coisa que muda entre um v�deo e outro � o endere�o do v�deo,
e isto voc� pode armazenado em seu programa (ou em um edit, como comentou), para montar o html tempor�rio.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ActiveX,
  Dialogs, OleCtrls, SHDocVw;

type
  TfrmYouTube = class(TForm)
    WebBrowser1: TWebBrowser;
    procedure WebBrowser1DocumentComplete(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure LoadHtml(const HTMLStr: AnsiString);
  public
    { Public declarations }
  end;

var
  frmYouTube: TfrmYouTube;

implementation

uses UnitX;  //minha unit que cont�m a _yutu, onde passo url do video

{$R *.dfm}

procedure TfrmYouTube.WebBrowser1DocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  WebBrowser1.OleObject.Document.body.Scroll := 'no';
end;

procedure TfrmYouTube.FormShow(Sender: TObject);
begin
  if _yutu <> '' then
    LoadHtml(AnsiString(
      '<!DOCTYPE html>' +
      '<html>' +
      '<head>' +
      '<meta http-equiv="X-UA-Compatible" content="IE=edge"></meta>' + // compatibility mode
      '</head>' +
      '<body>' +
      '<iframe width="' + inttostr(frmYouTube.width - 20) + '" height="' + inttostr(frmYouTube.Height - 20) + '" ' +
      'src="https://www.youtube.com/embed/' + _yutu + //oY8YpvZc5ao'+  // 1n2-7l_d6RU'+    //transformar en parametro
      '?controls=0' +
      ' frameborder="0" ' +
      ' autoplay=1&rel=0&controls=0&showinfo=0" ' + // autoplay, no related videos, no info nor controls
      ' allow="autoplay" frameborder="0">' + // allow autoplay, no border
      '</iframe>' +

      {<iframe width="560" height="315"
      src="https://www.youtube.com/embed/jj9r93KVwMk?controls=0"
      frameborder="0"
      allow="accelerometer;
      autoplay;
      clipboard-write;
      encrypted-media;
      gyroscope;
      picture-in-picture"
      allowfullscreen></iframe>}

      {<iframe width="1271" height="715" src="https://www.youtube.com/embed/oY8YpvZc5ao" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>}


      '</body>' +
      '</html>'
      ));
end;

procedure TfrmYouTube.LoadHtml(const HTMLStr: AnsiString);
var
  aStream: TMemoryStream;
begin
  WebBrowser1.Navigate('about:blank'); //reset the webbrowser
  while WebBrowser1.ReadyState < READYSTATE_INTERACTIVE do //wait to load the empty page
    Application.ProcessMessages;

  if Assigned(WebBrowser1.Document) then
  begin
    aStream := TMemoryStream.Create;
    try
      aStream.WriteBuffer(Pointer(HTMLStr)^, Length(HTMLStr));
      aStream.Seek(0, soFromBeginning);
      (WebBrowser1.Document as IPersistStreamInit).Load(TStreamAdapter.Create(aStream));
    finally
      aStream.Free;
    end;
  end;
end;

procedure TfrmYouTube.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  _yutu := '';
end;

end.

