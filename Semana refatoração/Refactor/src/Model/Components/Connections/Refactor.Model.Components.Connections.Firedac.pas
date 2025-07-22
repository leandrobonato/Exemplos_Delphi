unit Refactor.Model.Components.Connections.Firedac;

interface

uses
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.VCLUI.Wait,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  Refactor.Model.Components.Connections.Interfaces,
  System.Classes;

type
  TModelComponentsConnectionsFiredac = class(TInterfacedObject, iModelComponentsConnections)
    private
      FConnection : TFDConnection;
      FQuery : TFDQuery;
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

{ TModelComponentsConnectionsFiredac }

function TModelComponentsConnectionsFiredac.Active(
  aValue: Boolean): iModelComponentsConnections;
begin
  Result := Self;
  FQuery.Active := aValue;
end;

function TModelComponentsConnectionsFiredac.AddParam(aParam: String;
  aValue: Variant): iModelComponentsConnections;
begin
  Result := Self;
  FQuery.ParamByName(aParam).Value := aValue;
end;

function TModelComponentsConnectionsFiredac.AddParam(aParam: String;
  aValue: TPersistent): iModelComponentsConnections;
begin
  Result := Self;
  FQuery.ParamByName(aParam).Assign(aValue);
end;

constructor TModelComponentsConnectionsFiredac.Create;
begin
  FConnection := TFDConnection.Create(nil);
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := FConnection;
  FConnection.Params.DriverID := 'SQLite';
  FConnection.Params.Database := 'C:\Users\thuli\Desktop\Semana Refatoração\Refactor\database\refactordb.db3';
  FConnection.Params.Add('LockingMode=Normal');
  FConnection.Connected;
end;

function TModelComponentsConnectionsFiredac.DataSet: TDataSet;
begin
  Result := FQuery;
end;

destructor TModelComponentsConnectionsFiredac.Destroy;
begin
  FQuery.DisposeOf;
  FConnection.DisposeOf;
  inherited;
end;

function TModelComponentsConnectionsFiredac.ExecSQL: iModelComponentsConnections;
begin
  Result := Self;
  FQuery.ExecSQL;
end;

class function TModelComponentsConnectionsFiredac.New: iModelComponentsConnections;
begin
  Result := Self.Create;
end;

function TModelComponentsConnectionsFiredac.Open: iModelComponentsConnections;
begin
  Result := Self;
  FQuery.Open;
end;

function TModelComponentsConnectionsFiredac.SQL(
  aValue: String): iModelComponentsConnections;
begin
  Result := Self;
  FQuery.SQL.Add(aValue);
end;

function TModelComponentsConnectionsFiredac.SQLClear: iModelComponentsConnections;
begin
  Result := Self;
  FQuery.SQL.Clear;
end;

end.
