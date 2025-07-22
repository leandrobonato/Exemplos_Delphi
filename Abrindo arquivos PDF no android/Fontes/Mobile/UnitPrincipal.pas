unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, REST.Types,
  REST.Client, REST.Authenticator.Basic, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON, uDWJSONObject,

  {$IFDEF ANDROID}
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.provider,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Net,
  Androidapi.JNI.App,
  AndroidAPI.jNI.OS,
  Androidapi.JNIBridge,
  FMX.Helpers.Android,
  Androidapi.Helpers,
  FMX.Platform.Android,
  {$ENDIF}


  System.IOUtils, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button3: TButton;
    Button2: TButton;
    Button4: TButton;
    RESTClient1: TRESTClient;
    HTTPBasicAuthenticator1: THTTPBasicAuthenticator;
    ReqRDW: TRESTRequest;
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    arqLocal : string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.ZLib;

{$R *.fmx}

procedure TForm1.Button2Click(Sender: TObject);
{$IFDEF ANDROID}
var
    IntentJ : JIntent;
    JArq : JFile;
{$ENDIF}
begin
    {$IFDEF MSWINDOWS}
    arqLocal := GetCurrentDir + '\arquivo-mobile.pdf';
    {$ELSE}
    arqLocal := TPath.Combine(TPath.GetDocumentsPath, 'arquivo-mobile.pdf');
    {$ENDIF}

    if NOT FileExists(arqLocal) then
        ShowMessage('Arquivo não encontrado: ' + arqLocal)
    else
    begin
        {$IFDEF ANDROID}
        JArq := TJFile.JavaClass.init(StringToJString(arqLocal));
        IntentJ := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW);
        IntentJ.setDataAndType(TAndroidHelper.JFileToJURI(JArq), StringToJString('application/pdf'));
        IntentJ.setFlags(TJIntent.JavaClass.FLAG_GRANT_READ_URI_PERMISSION);
        TAndroidHelper.Activity.startActivity(IntentJ);
        {$ENDIF}
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
    {$IFDEF MSWINDOWS}
    arqLocal := GetCurrentDir + '\arquivo-mobile.pdf';
    {$ELSE}
    arqLocal := TPath.Combine(TPath.GetDocumentsPath, 'arquivo-mobile.pdf');
    {$ENDIF}

    if FileExists(arqLocal) then
        DeleteFile(arqLocal);
end;

procedure TForm1.Button4Click(Sender: TObject);
var
    jsonParam : TJSONObject;
    retJson : uDWJsonObject.TJSONValue;
    arqStream : TStringStream;
begin
    try
        jsonParam := TJSONObject.Create;
        jsonParam.AddPair('arquivo', 'arquivo.pdf');

        ReqRDW.Params.Clear;
        ReqRDW.Body.ClearBody;
        ReqRDW.Body.Add(jsonParam.ToString, ContentTypeFromString('application/json'));
        ReqRDW.Execute;

        if ReqRDW.Response.StatusCode <> 200 then
            ShowMessage('Erro ao baixar arquivo: ' + ReqRDW.Response.Content)
        else
        begin
            try
                retJson := uDWJsonObject.TJSONValue.Create;
                retJson.LoadFromJSON(ReqRDW.Response.Content);

                {$IFDEF MSWINDOWS}
                arqLocal := GetCurrentDir + '\arquivo-mobile.pdf';
                {$ELSE}
                arqLocal := TPath.Combine(TPath.GetDocumentsPath, 'arquivo-mobile.pdf');
                {$ENDIF}

                arqStream := TStringStream.Create('');
                retJson.SaveToStream(arqStream);
                arqStream.SaveToFile(arqLocal);
            finally
                retJson.DisposeOf;
                arqStream.DisposeOf;
            end;
        end;
    finally
        jsonParam.DisposeOf;
    end;
end;

end.
