unit Refactor.Controller.Services;

interface

uses
  Refactor.Controller.Interfaces;

type
  TControllerServices = class(TInterfacedObject, iControllerServices)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iControllerServices;
      function MercadoLivre : iControllerServicesGeneric;
      function NFe : iControllerServicesGeneric;
      function NFSe : iControllerServicesGeneric;
      function Boleto : iControllerServicesGeneric;
  end;

implementation

{ TControllerServices }

function TControllerServices.Boleto: iControllerServicesGeneric;
begin

end;

constructor TControllerServices.Create;
begin

end;

destructor TControllerServices.Destroy;
begin

  inherited;
end;

function TControllerServices.MercadoLivre: iControllerServicesGeneric;
begin

end;

class function TControllerServices.New: iControllerServices;
begin
  Result := Self.Create;
end;

function TControllerServices.NFe: iControllerServicesGeneric;
begin

end;

function TControllerServices.NFSe: iControllerServicesGeneric;
begin

end;

end.
