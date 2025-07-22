unit Refactor.Model.Components.Connections.Zeus;

interface

uses
  Refactor.Model.Components.Connections.Interfaces,
  Data.DB,
  System.Classes;

type
  TModelComponentsConnectionsZeus = class(TInterfacedObject, iModelComponentsConnections)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iModelComponentsConnections;
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

{ TModelComponentsConnectionsZeus }

function TModelComponentsConnectionsZeus.Active(
  aValue: Boolean): iModelComponentsConnections;
begin

end;

function TModelComponentsConnectionsZeus.AddParam(aParam: String;
  aValue: TPersistent): iModelComponentsConnections;
begin

end;

function TModelComponentsConnectionsZeus.AddParam(aParam: String;
  aValue: Variant): iModelComponentsConnections;
begin

end;

constructor TModelComponentsConnectionsZeus.Create;
begin

end;

function TModelComponentsConnectionsZeus.DataSet: TDataSet;
begin

end;

destructor TModelComponentsConnectionsZeus.Destroy;
begin

  inherited;
end;

function TModelComponentsConnectionsZeus.ExecSQL: iModelComponentsConnections;
begin

end;

class function TModelComponentsConnectionsZeus.New: iModelComponentsConnections;
begin
  Result := Self.Create;
end;

function TModelComponentsConnectionsZeus.Open: iModelComponentsConnections;
begin

end;

function TModelComponentsConnectionsZeus.SQL(
  aValue: String): iModelComponentsConnections;
begin

end;

function TModelComponentsConnectionsZeus.SQLClear: iModelComponentsConnections;
begin

end;

end.
