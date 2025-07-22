unit Refactor.Model.Entities.Users;

interface

uses
  Refactor.Model.DAO.Interfaces;

type
  TUSERS = class
    private
    [weak]
    FParent : iModelDAOEntity<TUSERS>;
    FNAME: String;
    FID: Integer;
    public
      constructor Create ( aParent : iModelDAOEntity<TUSERS>);
      function ID ( aValue : Integer ) : TUSERS; overload;
      function ID : Integer; overload;
      function NAME ( aValue : String ) : TUSERS; overload;
      function NAME : String; overload;
      function &End : iModelDAOEntity<TUSERS>;
  end;

implementation

uses
  System.SysUtils;

{ TUSERS }


function TUSERS.&End : iModelDAOEntity<TUSERS>;
begin
  Result := FParent;
end;

function TUSERS.ID(aValue: Integer): TUSERS;
begin
  Result := Self;
  FID  := aValue;
end;

constructor TUSERS.Create(aParent: iModelDAOEntity<TUSERS>);
begin
  FParent := aParent;
end;

function TUSERS.ID: Integer;
begin
  Result := FID;
end;

function TUSERS.NAME(aValue: String): TUSERS;
begin
  Result := Self;
  FNAME := aValue;
end;

function TUSERS.NAME: String;
begin
  if Trim(FNAME) = '' then
    raise Exception.Create('Informe o nome do Usuário');

  Result := FNAME;
end;


end.
