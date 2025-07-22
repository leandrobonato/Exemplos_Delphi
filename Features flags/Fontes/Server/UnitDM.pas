unit UnitDM;

interface

uses
  System.SysUtils, System.Classes, uDWDataModule, uDWAbout, uRESTDWServerEvents,
  uDWConsts, uDWJSONObject, System.JSON;

type
  Tdm = class(TServerMethodDataModule)
    ServerEvents: TDWServerEvents;
    procedure ServerEventsEventsflagsReplyEventByType(var Params: TDWParams;
      var Result: string; const RequestType: TRequestType;
      var StatusCode: Integer; RequestHeader: TStringList);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure Tdm.ServerEventsEventsflagsReplyEventByType(var Params: TDWParams;
  var Result: string; const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
var
    jsonRet : TJSONObject;
begin
    try
        jsonRet := TJSONObject.Create;

        // Abrir conexao com seu banco...
        // Fazer select para identificar quais features vc devolve para seu usuario..

        if Params.ItemsString['usuario'].AsString = 'heber' then
        begin
            jsonRet.AddPair('buttomColor', 'green');
            jsonRet.AddPair('buttomTag', '001');
            jsonRet.AddPair('buttomText', 'Comprar');
        end
        else
        begin
            jsonRet.AddPair('buttomColor', 'red');
            jsonRet.AddPair('buttomTag', '002');
            jsonRet.AddPair('buttomText', 'Assinar');
        end;

        Result := jsonRet.ToJSON;
    finally
        jsonRet.DisposeOf;
    end;
end;

end.
