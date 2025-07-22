unit Refactor.Controller;

interface

uses
  Refactor.Controller.Interfaces;

type
  TController = class(TInterfacedObject, iController)
    private
      FEntities : iControllerEntities;
      FServices : iControllerServices;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iController;
      function Entities : iControllerEntities;
      function Services : iControllerServices;
  end;

implementation

uses
  Refactor.Controller.Entities, Refactor.Controller.Services;

{ TController }

constructor TController.Create;
begin

end;

destructor TController.Destroy;
begin

  inherited;
end;

function TController.Entities: iControllerEntities;
begin
  if not Assigned(FEntities) then
    FEntities := TControllerEntities.New;

  Result := FEntities;
end;

class function TController.New: iController;
begin
  Result := Self.Create;
end;

function TController.Services: iControllerServices;
begin
  if not Assigned(FServices) then
    FServices := TControllerServices.New;

  Result := FServices;
end;

end.
