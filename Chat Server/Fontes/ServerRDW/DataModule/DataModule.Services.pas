unit DataModule.Services;

interface

uses
  System.SysUtils, System.Classes, uRESTDWDatamodule, uRESTDWComponentBase,
  uRESTDWServerEvents, uRESTDWParams, uRESTDWConsts, System.JSON;

type
  TDmServices = class(TServerMethodDataModule)
    ServerEvents: TRESTDWServerEvents;
    procedure ServerEventsEventsmessagesReplyEventByType(
      var Params: TRESTDWParams; var Result: string;
      const RequestType: TRequestType; var StatusCode: Integer;
      RequestHeader: TStringList);
  private
    procedure ListarMensagens(var Params: TRESTDWParams; var Result: string;
      const RequestType: TRequestType; var StatusCode: Integer;
      RequestHeader: TStringList);
    procedure InserirMensagem(var Params: TRESTDWParams; var Result: string;
      const RequestType: TRequestType; var StatusCode: Integer;
      RequestHeader: TStringList);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmServices: TDmServices;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses DataModule.Global;

{$R *.dfm}

procedure TDmServices.ListarMensagens(var Params: TRESTDWParams; var Result: string;
  const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
var
    cod_usuario, cod_mensagem: integer;
    json: TJSOnArray;
    DmGlobal: TDmGlobal;
begin
    try
        try
            DmGlobal := TDmGlobal.Create(nil);

            try
                cod_usuario := Params.ItemsString['cod_usuario'].AsInteger;
            except
                cod_usuario := 0;
            end;

            try
                cod_mensagem := Params.ItemsString['cod_mensagem'].AsInteger;
            except
                cod_mensagem := 0;
            end;

            json := DmGlobal.ListarMensagens(cod_usuario, cod_mensagem);
            Result := json.ToJSON;
            FreeAndNil(json);
            StatusCode := 200;

        except on ex:exception do
            begin
                Result := '{"erro": "' + ex.Message + '"}';
                StatusCode := 500;
            end;
        end;
    finally
        FreeAndNil(DmGlobal);
    end;
end;

procedure TDmServices.InserirMensagem(var Params: TRESTDWParams; var Result: string;
  const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
var
    cod_usuario_de, cod_usuario_para: integer;
    texto: string;
    json: TJSONObject;
    DmGlobal: TDmGlobal;
    body: System.JSON.TJSONValue;
begin
    try
        try
            DmGlobal := TDmGlobal.Create(nil);

            body := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Params.RawBody.AsString), 0) as TJSONValue;
            cod_usuario_de := body.GetValue<integer>('cod_usuario_de', 0);
            cod_usuario_para := body.GetValue<integer>('cod_usuario_para', 0);
            texto := body.GetValue<string>('texto', '');
            FreeAndNil(body);

            json := DmGlobal.InserirMensagem(cod_usuario_de, cod_usuario_para, texto);
            Result := json.ToJSON;
            FreeAndNil(json);
            StatusCode := 201;

        except on ex:exception do
            begin
                Result := '{"erro": "' + ex.Message + '"}';
                StatusCode := 500;
            end;
        end;
    finally
        FreeAndNil(DmGlobal);
    end;
end;

procedure TDmServices.ServerEventsEventsmessagesReplyEventByType(
  var Params: TRESTDWParams; var Result: string;
  const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
begin
    if RequestType = rtGet then
        ListarMensagens(Params, Result, RequestType, StatusCode, RequestHeader)
    else
    if RequestType = rtPost then
        InserirMensagem(Params, Result, RequestType, StatusCode, RequestHeader)
    else
        Result := '{"retorno": "Verbo não implementado"}';
end;

end.
