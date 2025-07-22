unit Refactor.Model.Components.Connections.Interfaces;

interface

uses
  Data.DB,
  System.Classes;

type

  iModelComponentsConnections = interface
    ['{40D3E554-99A1-4001-83DF-D7E8BBB85405}']
    function Active ( aValue : Boolean ) : iModelComponentsConnections;
    function AddParam ( aParam : String; aValue : Variant ) : iModelComponentsConnections; overload;
    function AddParam ( aParam : String; aValue : TPersistent ) : iModelComponentsConnections; overload;
    function DataSet : TDataSet;
    function ExecSQL : iModelComponentsConnections;
    function Open : iModelComponentsConnections;
    function SQL ( aValue : String ) : iModelComponentsConnections;
    function SQLClear : iModelComponentsConnections;
  end;

implementation

end.
