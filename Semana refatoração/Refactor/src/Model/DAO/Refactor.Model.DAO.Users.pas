unit Refactor.Model.DAO.Users;

interface

uses
  Refactor.Model.Entities.Users,
  Refactor.Model.Components.Connections.Interfaces,
  Data.DB,
  Refactor.Model.DAO.Interfaces;

type
  TModelDAOUsers = class(TInterfacedObject, iModelDAOEntity<TUSERS>)
    private
      FConnection : iModelComponentsConnections;
      FDataSet : TDataSource;
      FEntity : TUSERS;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iModelDAOEntity<TUSERS>;
      function DataSet ( aValue : TDataSource ) : iModelDAOEntity<TUSERS>; overload;
      function DataSet : TDataSet; overload;
      function Delete : iModelDAOEntity<TUSERS>;
      function Get : iModelDAOEntity<TUSERS>; overload;
      function Get ( aValue : Variant ) : iModelDAOEntity<TUSERS>; overload;
      function Get ( aParam : String; aValue : Variant ) : iModelDAOEntity<TUSERS>; overload;
      function Insert : iModelDAOEntity<TUSERS>;
      function This : TUSERS;
      function Update : iModelDAOEntity<TUSERS>;
  end;

implementation

uses
  System.SysUtils,
  Refactor.Model.Components.Factory;

{ TModelDAOUsers }

constructor TModelDAOUsers.Create;
begin
  FEntity := TUSERS.Create(Self);
  FConnection := TModelComponentsFactory.New.Connection;
end;

function TModelDAOUsers.DataSet(aValue: TDataSource): iModelDAOEntity<TUSERS>;
begin
  Result := Self;
  FDataSet := aValue;
  FDataSet.DataSet := FConnection.DataSet;
end;

function TModelDAOUsers.DataSet: TDataSet;
begin
  Result := FConnection.DataSet;
end;

function TModelDAOUsers.Delete: iModelDAOEntity<TUSERS>;
begin
  Result := Self;
  try
    FConnection
      .Active(False)
      .SQLClear
      .SQL('DELETE FROM USERS')
      .SQL('WHERE ID = :ID')
      .AddParam('ID', FEntity.ID)
    .ExecSQL;
  except on ex:exception do
    raise Exception.Create('Erro ao Excluir Usuário: ' + ex.Message);
  end;
end;

destructor TModelDAOUsers.Destroy;
begin
  FEntity.DisposeOf;
  inherited;
end;

function TModelDAOUsers.Get(aValue: Variant): iModelDAOEntity<TUSERS>;
begin
  Result := Self;
  try
    FConnection
      .Active(False)
      .SQLClear
      .SQL('SELECT * FROM USERS WHERE ID = ' + aValue)
    .Open;
  except on ex:exception do
    raise Exception.Create('Erro ao Consultar Usuarios: ' + ex.Message);
  end;
end;

function TModelDAOUsers.Get(aParam: String;
  aValue: Variant): iModelDAOEntity<TUSERS>;
begin
  Result := Self;
  try
    FConnection
      .Active(False)
      .SQLClear
      .SQL('SELECT * FROM USERS WHERE ' +  aParam + ' = ' + QuotedStr(aValue))
    .Open;
  except on ex:exception do
    raise Exception.Create('Erro ao Consultar Usuarios: ' + ex.Message);
  end;
end;

function TModelDAOUsers.Get: iModelDAOEntity<TUSERS>;
begin
  Result := Self;
  try
    FConnection
      .Active(False)
      .SQLClear
      .SQL('SELECT * FROM USERS')
    .Open;
  except on ex:exception do
    raise Exception.Create('Erro ao Consultar Usuarios: ' + ex.Message);
  end;
end;

function TModelDAOUsers.Insert: iModelDAOEntity<TUSERS>;
begin
  Result := Self;
  try
    FConnection
      .Active(False)
      .SQLClear
      .SQL('INSERT INTO USERS(NAME)')
      .SQL('VALUES(:NAME)')
      .AddParam('NAME', FEntity.NAME)
    .ExecSQL;
  except on ex:exception do
    raise Exception.Create('Erro ao inserir Usuário: ' + ex.Message);
  end;
end;

class function TModelDAOUsers.New: iModelDAOEntity<TUSERS>;
begin
  Result := Self.Create;
end;

function TModelDAOUsers.This: TUSERS;
begin
  Result := FEntity;
end;

function TModelDAOUsers.Update: iModelDAOEntity<TUSERS>;
begin
  Result := Self;
  try
    FConnection
      .Active(False)
      .SQLClear
      .SQL('UPDATE USERS SET NAME=:NAME')
      .SQL('WHERE ID = :ID')
      .AddParam('NAME', FEntity.NAME)
      .AddParam('ID', FEntity.ID)
    .ExecSQL;
  except on ex:exception do
    raise Exception.Create('Erro ao alterar Usuário: ' + ex.Message);
  end;
end;

end.
