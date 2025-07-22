unit Refactor.Model.Components.Factory;

interface

uses
  Refactor.Model.Components.Interfaces,
  Refactor.Model.Components.Connections.Interfaces,
  Refactor.Model.Components.Connections.Firedac;

type
  TModelComponentsFactory = class(TInterfacedObject, iModelComponentsFactory)
    private
      FConnection : iModelComponentsConnections;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iModelComponentsFactory;
      function Connection : iModelComponentsConnections;
  end;

implementation

{ TModelComponentsFactory }

function TModelComponentsFactory.Connection: iModelComponentsConnections;
begin
  if not Assigned(FConnection) then
    FConnection := TModelComponentsConnectionsFiredac.New;

  Result := FConnection;
end;

constructor TModelComponentsFactory.Create;
begin

end;

destructor TModelComponentsFactory.Destroy;
begin

  inherited;
end;

class function TModelComponentsFactory.New: iModelComponentsFactory;
begin
  Result := Self.Create;
end;

end.
