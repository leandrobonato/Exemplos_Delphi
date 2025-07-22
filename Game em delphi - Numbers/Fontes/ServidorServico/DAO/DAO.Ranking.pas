unit DAO.Ranking;

interface

uses FireDAC.Comp.Client,
     FireDAC.DApt,
     Data.DB,
     System.JSON,
     System.SysUtils,
     System.StrUtils,
     DataSet.Serialize,
     DAO.Connection;

type
    TRanking = class
    private
        FConn: TFDConnection;
    public
        constructor Create;
        destructor Destroy; override;

        function Listar(num_rows: integer): TJSONArray;
        procedure Adicionar(nome: string; level, pontos: integer);
    end;

implementation

{ TRanking }

constructor TRanking.Create;
begin
    FConn := TConnection.CreateConnection;
end;

destructor TRanking.Destroy;
begin
    if Assigned(FConn) then
        FConn.Free;

    inherited;
end;

function TRanking.Listar(num_rows: integer): TJSONArray;
var
    qry: TFDQuery;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := FConn;

        with qry do
        begin
            Active := false;
            SQL.Clear;
            SQL.Add('SELECT * FROM TAB_RANKING');
            SQL.Add('WHERE PONTOS > 0');
            SQL.Add('ORDER BY PONTOS DESC');

            if num_rows > 0 then
                SQL.Add('LIMIT ' + num_rows.ToString);

            Active := true;
        end;

        Result := qry.ToJSONArray();

    finally
        qry.Free;
    end;

end;

procedure TRanking.Adicionar(nome: string; level, pontos: integer);
var
    qry: TFDQuery;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := FConn;

        with qry do
        begin
            Active := false;
            SQL.Clear;
            SQL.Add('INSERT INTO TAB_RANKING(NOME, LEVEL, PONTOS)');
            SQL.Add('VALUES(:NOME, :LEVEL, :PONTOS)');

            ParamByName('NOME').Value := nome;
            ParamByName('LEVEL').Value := level;
            ParamByName('PONTOS').Value := pontos;

            ExecSQL;
        end;

    finally
        qry.Free;
    end;
end;



end.
