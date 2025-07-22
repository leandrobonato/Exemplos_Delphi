unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, REST.Types, REST.Client,
  REST.Authenticator.Basic, Data.Bind.Components, Data.Bind.ObjectScope,
  System.JSON, uDWJSONObject, System.IOUtils;

type
  TFrmPrincipal = class(TForm)
    btnRDW: TButton;
    RESTClient: TRESTClient;
    ReqRDW: TRESTRequest;
    HTTPBasicAuthenticator1: THTTPBasicAuthenticator;
    btnHorse: TButton;
    ReqHorse: TRESTRequest;
    procedure btnRDWClick(Sender: TObject);
    procedure btnHorseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

procedure TFrmPrincipal.btnRDWClick(Sender: TObject);
var
    jsonParam : TJSONObject;
    retJson : uDWJsonObject.TJSONValue;
    arqLocal : string;
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
                arqLocal := GetCurrentDir + '\arquivo-baixado-windows.pdf';
                {$ELSE}
                arqLocal := TPath.Combine(TPath.GetDocumentsPath, 'arquivo-baixado-mobile.pdf');
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

procedure TFrmPrincipal.btnHorseClick(Sender: TObject);
var
    arqStream: TMemoryStream;
    arqLocal : string;
    json: TJSONObject;
begin
    {$IFDEF MSWINDOWS}
    arqLocal := GetCurrentDir + '\arquivo-baixado-windows.pdf';
    {$ELSE}
    arqLocal := TPath.Combine(TPath.GetDocumentsPath, 'arquivo-baixado-mobile.pdf');
    {$ENDIF}

    try
        json := TJSONObject.Create;
        json.AddPair('arquivo', 'arquivo.pdf');

        ReqHorse.Params.Clear;
        ReqHorse.Body.ClearBody;
        ReqHorse.Body.Add(json.ToString, ContentTypeFromString('application/json'));
        ReqHorse.Execute;

        if ReqHorse.Response.StatusCode <> 200 then
            ShowMessage('Erro ao baixar o arquivo: ' + ReqHorse.Response.Content)
        else
        begin
            try
                arqStream := TMemoryStream.Create;
                arqStream.Write(ReqHorse.Response.RawBytes,
                                length(ReqHorse.Response.RawBytes));
                arqStream.Position := 0;
                arqStream.SaveToFile(arqLocal);
            finally
                arqStream.DisposeOf;
            end;
        end;

    finally
        json.DisposeOf;
    end;
end;


end.
