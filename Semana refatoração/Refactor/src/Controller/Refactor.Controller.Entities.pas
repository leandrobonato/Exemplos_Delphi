unit Refactor.Controller.Entities;

interface

uses
  Refactor.Controller.Interfaces,
  Refactor.Model.DAO.Interfaces,
  Refactor.Model.Entities.Users,
  Refactor.Model.Entities.Categoria;

type
  TControllerEntities = class(TInterfacedObject, iControllerEntities)
    private
      FCategorias : iModelDAOEntity<TCategoria>;
      FUsers : iModelDAOEntity<TUsers>;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iControllerEntities;
      function Categorias : iModelDAOEntity<TCategoria>;
      function Users : iModelDAOEntity<TUsers>;
  end;

implementation

uses
  Refactor.Model;

{ TControllerEntities }

function TControllerEntities.Categorias: iModelDAOEntity<TCategoria>;
begin
  if not Assigned(FCategorias) then
    FCategorias := TRefactorModel.New.DAO.Categorias;

  Result := FCategorias;
end;

constructor TControllerEntities.Create;
begin

end;

destructor TControllerEntities.Destroy;
begin

  inherited;
end;

class function TControllerEntities.New: iControllerEntities;
begin
  Result := Self.Create;
end;

function TControllerEntities.Users: iModelDAOEntity<TUsers>;
begin
  if not Assigned(FUsers) then
    FUsers := TRefactorModel.New.DAO.Users;

  Result := FUsers;
end;

end.
