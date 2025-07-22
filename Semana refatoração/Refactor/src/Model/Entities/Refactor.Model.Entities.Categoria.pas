unit Refactor.Model.Entities.Categoria;

interface

uses
  Vcl.Graphics,
  System.SysUtils,
  Refactor.Model.DAO.Interfaces;

type
   TCategoria = class
    private
      [weak]
      FParent : iModelDAOEntity<TCategoria>;
      FDESCRICAO: string;
      FID_CATEGORIA: Integer;
      FINDICE_ICONE: Integer;
      FICONE: TBitmap;
    public
        constructor Create(aParent : iModelDAOEntity<TCategoria>);
        destructor Destroy; override;
        function ID_CATEGORIA ( aValue : Integer ) : TCategoria; overload;
        function ID_CATEGORIA : Integer; overload;
        function DESCRICAO ( aValue : String ) : TCategoria; overload;
        function DESCRICAO : String; overload;
        function ICONE ( aValue : TBitmap ) : TCategoria; overload;
        function ICONE : TBitmap; overload;
        function INDICE_ICONE ( aValue : Integer ) : TCategoria; overload;
        function INDICE_ICONE : Integer; overload;
        function &End : iModelDAOEntity<TCategoria>;
    end;

implementation

{ TCategoria }

function TCategoria.&End: iModelDAOEntity<TCategoria>;
begin
  Result := FParent;
end;

constructor TCategoria.Create(aParent : iModelDAOEntity<TCategoria>);
begin
  FParent := aParent;
end;

function TCategoria.DESCRICAO(aValue: String): TCategoria;
begin
  Result := Self;
  FDESCRICAO := aValue;
end;

function TCategoria.DESCRICAO: String;
begin
  if Trim(FDESCRICAO) = '' then
    raise Exception.Create('Informe a descricao da categoria');

  Result := FDESCRICAO;
end;

destructor TCategoria.Destroy;
begin

  inherited;
end;

function TCategoria.ICONE: TBitmap;
begin
  Result := FICONE;
end;

function TCategoria.ICONE(aValue: TBitmap): TCategoria;
begin
  Result := Self;
  FICONE := aValue;
end;

function TCategoria.ID_CATEGORIA: Integer;
begin
  if FID_CATEGORIA <= 0 then
    raise Exception.Create('ID da Categoria não pode ser Zero');

  Result := FID_CATEGORIA;
end;

function TCategoria.ID_CATEGORIA(aValue: Integer): TCategoria;
begin
  Result := Self;
  FID_CATEGORIA := aValue;
end;

function TCategoria.INDICE_ICONE(aValue: Integer): TCategoria;
begin
  Result := Self;
  FINDICE_ICONE := aValue;
end;

function TCategoria.INDICE_ICONE: Integer;
begin
  Result := FINDICE_ICONE;
end;

end.
