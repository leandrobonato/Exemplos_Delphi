unit Refactor.Model.DAO.Interfaces;

interface

uses
  Data.DB;

type

  iModelDAOEntity<T> = interface
    ['{57732BE7-25A7-4844-AC36-2A4AA5C69FC0}']
    function DataSet ( aValue : TDataSource ) : iModelDAOEntity<T>; overload;
    function DataSet : TDataSet; overload;
    function Delete : iModelDAOEntity<T>;
    function Get : iModelDAOEntity<T>; overload;
    function Get ( aValue : Variant ) : iModelDAOEntity<T>; overload;
    function Get ( aParam : String; aValue : Variant ) : iModelDAOEntity<T>; overload;
    function Insert : iModelDAOEntity<T>;
    function This : T;
    function Update : iModelDAOEntity<T>;
  end;

implementation

end.
