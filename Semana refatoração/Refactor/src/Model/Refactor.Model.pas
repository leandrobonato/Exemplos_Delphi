unit Refactor.Model;

interface

uses
    Refactor.Model.Interfaces,
    Refactor.Model.DAO.Factory,
    Refactor.Model.Components.Interfaces;

type
  TRefactorModel = class(TInterfacedObject, iModelInterface)
    private
      FDAO : iModelDAOFactory;
      FComponents : iModelComponentsFactory;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iModelInterface;
      function Components : iModelComponentsFactory;
      function DAO : iModelDAOFactory;
  end;

implementation

uses
  Refactor.Model.Components.Factory;

{ TModel }

function TRefactorModel.Components: iModelComponentsFactory;
begin
  if not Assigned(FComponents) then
    FComponents := TModelComponentsFactory.New;

  Result := FComponents;
end;

constructor TRefactorModel.Create;
begin

end;

function TRefactorModel.DAO: iModelDAOFactory;
begin
  if not Assigned(FDAO) then
    FDAO := TModelDAOFactory.New;

  Result := FDAO;
end;

destructor TRefactorModel.Destroy;
begin

  inherited;
end;

class function TRefactorModel.New: iModelInterface;
begin
  Result := Self.Create;
end;

end.
