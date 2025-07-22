unit Refactor.Model.DAO.Factory;

interface

uses
  Refactor.Model.DAO.Interfaces,
  Refactor.Model.Entities.Users,
  Refactor.Model.Entities.Categoria;

type
  iModelDAOFactory = interface
    ['{10B2E77D-4ED1-45E9-ACE0-9B08CF924ABA}']
    function Categorias : iModelDAOEntity<TCategoria>;
    function Users : iModelDAOEntity<TUsers>;
  end;

  TModelDAOFactory = class(TInterfacedObject, iModelDAOFactory)
    private
      FCategorias : iModelDAOEntity<TCategoria>;
      FUsers : iModelDAOEntity<TUsers>;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iModelDAOFactory;
      function Categorias : iModelDAOEntity<TCategoria>;
      function Users : iModelDAOEntity<TUsers>;
  end;

implementation

uses
  Refactor.Model.DAO.Categoria, Refactor.Model.DAO.Users;

{ TModelDAOFactory }

function TModelDAOFactory.Categorias: iModelDAOEntity<TCategoria>;
begin
  if not Assigned(FCategorias) then
    FCategorias := TModelDAOCategoria.New;

  Result := FCategorias;
end;

constructor TModelDAOFactory.Create;
begin

end;

destructor TModelDAOFactory.Destroy;
begin

  inherited;
end;

class function TModelDAOFactory.New: iModelDAOFactory;
begin
  Result := Self.Create;
end;

function TModelDAOFactory.Users: iModelDAOEntity<TUsers>;
begin
  if not Assigned(FUsers) then
    FUsers := TModelDAOUsers.New;

  Result := FUsers;
end;

end.
