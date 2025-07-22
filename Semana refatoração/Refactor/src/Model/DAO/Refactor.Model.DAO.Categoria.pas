unit Refactor.Model.DAO.Categoria;

interface

uses
  Data.DB,
  Refactor.Model.Entities.Categoria,
  Refactor.Model.Components.Connections.Interfaces,
  Refactor.Model.DAO.Interfaces;

type
  TModelDAOCategoria = class(TInterfacedObject, iModelDAOEntity<TCategoria>)
    private
      FConnection : iModelComponentsConnections;
      FDataSet : TDataSource;
      FEntity : TCategoria;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iModelDAOEntity<TCategoria>;
      function DataSet ( aValue : TDataSource ) : iModelDAOEntity<TCategoria>;  overload;
      function DataSet : TDataSet; overload;
      function Delete : iModelDAOEntity<TCategoria>;
      function Get : iModelDAOEntity<TCategoria>; overload;
      function Get ( aValue : Variant ) : iModelDAOEntity<TCategoria>; overload;
      function Get ( aParam : String; aValue : Variant ) : iModelDAOEntity<TCategoria>; overload;
      function Insert : iModelDAOEntity<TCategoria>;
      function This : TCategoria;
      function Update : iModelDAOEntity<TCategoria>;
  end;

implementation

uses
  System.SysUtils,
  Refactor.Model.Components.Factory;

{ TModelDAOCategoria }

constructor TModelDAOCategoria.Create;
begin
  FConnection := TModelComponentsFactory.New.Connection;
  FEntity := TCategoria.Create(Self);
end;

function TModelDAOCategoria.DataSet(aValue: TDataSource): iModelDAOEntity<TCategoria>;
begin
  Result := Self;
  FDataSet := aValue;
  FDataSet.DataSet := FConnection.DataSet;
end;

function TModelDAOCategoria.DataSet: TDataSet;
begin
  Result := FConnection.DataSet;
end;

function TModelDAOCategoria.Delete: iModelDAOEntity<TCategoria>;
begin
  Result := Self;
  try
    FConnection
      .Active(False)
      .SQLClear
      .SQL('DELETE FROM TAB_CATEGORIA')
      .SQL('WHERE ID_CATEGORIA = :ID_CATEGORIA')
      .AddParam('ID_CATEGORIA', FEntity.ID_CATEGORIA)
    .ExecSQL;
  except on ex:exception do
    raise Exception.Create('Erro ao Excluir Categorias: ' + ex.Message);
  end;
end;

destructor TModelDAOCategoria.Destroy;
begin
  FEntity.DisposeOf;
  inherited;
end;

function TModelDAOCategoria.Get(aValue: Variant): iModelDAOEntity<TCategoria>;
begin
  Result := Self;
  try
    FConnection
      .Active(False)
      .SQLClear
      .SQL('SELECT * FROM TAB_CATEGORIA WHERE ID_CATEGORIA = ' + aValue)
    .Open;
  except on ex:exception do
    raise Exception.Create('Erro ao Consultar Categorias: ' + ex.Message);
  end;
end;

function TModelDAOCategoria.Get(aParam: String;
  aValue: Variant): iModelDAOEntity<TCategoria>;
begin
  Result := Self;
  try
    FConnection
      .Active(False)
      .SQLClear
      .SQL('SELECT * FROM TAB_CATEGORIA WHERE ' + aParam + ' = ' + QuotedStr(aValue))
    .Open;
  except on ex:exception do
    raise Exception.Create('Erro ao Consultar Categorias: ' + ex.Message);
  end;
end;

function TModelDAOCategoria.Get: iModelDAOEntity<TCategoria>;
begin
  Result := Self;
  try
    FConnection
      .Active(False)
      .SQLClear
      .SQL('SELECT * FROM TAB_CATEGORIA')
    .Open;
  except on ex:exception do
    raise Exception.Create('Erro ao Consultar Categorias: ' + ex.Message);
  end;
end;

function TModelDAOCategoria.Insert: iModelDAOEntity<TCategoria>;
begin
  Result := Self;
  try
    FConnection
      .Active(False)
      .SQLClear
      .SQL('INSERT INTO TAB_CATEGORIA(DESCRICAO, ICONE, INDICE_ICONE)')
      .SQL('VALUES(:DESCRICAO, :ICONE, :INDICE_ICONE)')
      .AddParam('DESCRICAO', FEntity.DESCRICAO)
      .AddParam('ICONE', FEntity.ICONE)
      .AddParam('INDICE_ICONE', FEntity.INDICE_ICONE)
    .ExecSQL;
  except on ex:exception do
    raise Exception.Create('Erro ao inserir categorias: ' + ex.Message);
  end;
end;

class function TModelDAOCategoria.New: iModelDAOEntity<TCategoria>;
begin
  Result := Self.Create;
end;

function TModelDAOCategoria.This: TCategoria;
begin
  Result := FEntity;
end;

function TModelDAOCategoria.Update: iModelDAOEntity<TCategoria>;
begin
  Result := Self;
  try
    FConnection
      .Active(False)
      .SQLClear
      .SQL('UPDATE TAB_CATEGORIA SET DESCRICAO=:DESCRICAO, ICONE=:ICONE,')
      .SQL('INDICE_ICONE=:INDICE_ICONE')
      .SQL('WHERE ID_CATEGORIA = :ID_CATEGORIA')
      .AddParam('DESCRICAO', FEntity.DESCRICAO)
      .AddParam('ICONE', FEntity.ICONE)
      .AddParam('ID_CATEGORIA', FEntity.ID_CATEGORIA)
      .AddParam('INDICE_ICONE', FEntity.INDICE_ICONE)
    .ExecSQL;
  except on ex:exception do
    raise Exception.Create('Erro ao alterar categorias: ' + ex.Message);
  end;
end;

end.
