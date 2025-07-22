unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  uLoading, RESTRequest4D, uOpenViewUrl,
  System.Net.HttpClient, System.Net.HttpClientComponent;

type
  TFrmPrincipal = class(TForm)
    Rectangle1: TRectangle;
    Label1: TLabel;
    lytMessage: TLayout;
    rectFundo: TRectangle;
    rectMessage: TRectangle;
    imgIcone: TImage;
    imgFechar: TImage;
    lblMsg: TLabel;
    rectButton: TRectangle;
    lblButton: TLabel;
    TabMessage: TFDMemTable;
    procedure FormShow(Sender: TObject);
    procedure rectButtonClick(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
  private
    procedure ThreadMessageTerminate(Sender: TObject);
    procedure ListarMensagens;
    procedure LoadImageFromURL(img: TBitmap; url: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

procedure TFrmPrincipal.LoadImageFromURL(img: TBitmap; url: string);
var
    http : TNetHTTPClient;
    vStream : TMemoryStream;
begin
    try
        try
            http := TNetHTTPClient.Create(nil);
            vStream :=  TMemoryStream.Create;

            if (Pos('https', LowerCase(url)) > 0) then
                  HTTP.SecureProtocols  := [THTTPSecureProtocol.TLS1,
                                            THTTPSecureProtocol.TLS11,
                                            THTTPSecureProtocol.TLS12];

            http.Get(url, vStream);
            vStream.Position  :=  0;


            img.LoadFromStream(vStream);
        except
        end;

    finally
        vStream.DisposeOf;
        http.DisposeOf;
    end;
end;

procedure TFrmPrincipal.rectButtonClick(Sender: TObject);
begin
    if TabMessage.FieldByName('action').AsString = 'open-url' then
        OpenURL(TabMessage.FieldByName('action_param').AsString, false);

    lytMessage.Visible := false;
end;

procedure TFrmPrincipal.imgFecharClick(Sender: TObject);
begin
    lytMessage.Visible := false;
end;

procedure TFrmPrincipal.ListarMensagens;
var
    Resp : IResponse;
begin
    TabMessage.FieldDefs.Clear;

    Resp := TRequest.New.BaseURL('http://localhost:9000')
            .Resource('usuarios')
            .ResourceSuffix('10/notificacoes')
            .DataSetAdapter(TabMessage)
            .Accept('application/json')
            .Get;

    if Resp.StatusCode <> 200 then
        raise Exception.Create(Resp.Content);
end;

procedure TFrmPrincipal.ThreadMessageTerminate(Sender: TObject);
begin
    TLoading.Hide;

    if Sender is TThread then
    begin
        if Assigned(TThread(Sender).FatalException) then
        begin
            showmessage('Não foi possível acessar o servidor');
            exit;
        end;
    end;

    if TabMessage.RecordCount > 0 then
    begin
        lblMsg.Text := TabMessage.FieldByName('message').AsString;
        lblButton.Text := TabMessage.FieldByName('button').AsString;

        try
            LoadImageFromURL(imgIcone.Bitmap, TabMessage.FieldByName('url').AsString);
        except
        end;

        lytMessage.Visible := true;
    end;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
var
    t: TThread;
begin
    TLoading.Show(FrmPrincipal, '');

    t := TThread.CreateAnonymousThread(procedure
    begin
        sleep(3000);

        ListarMensagens;
    end);

    t.OnTerminate := ThreadMessageTerminate;
    t.Start;
end;

end.
