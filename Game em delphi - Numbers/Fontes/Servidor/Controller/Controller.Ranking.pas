unit Controller.Ranking;

interface

uses Horse,
     System.JSON,
     System.SysUtils,
     DAO.Ranking;

procedure RegistrarRotas;
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Inserir(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

procedure RegistrarRotas;
begin
    THorse.Get('/ranking', Listar);
    THorse.Post('/ranking', Inserir);
end;

procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
    ranking: TRanking;
begin
    try
        try
            sleep(2000);
            ranking := TRanking.Create;

            Res.Send<TJSONArray>(ranking.Listar(10));
        except on ex:exception do
            Res.Send(ex.Message).Status(THTTPStatus.InternalServerError);
        end;
    finally
        ranking.Free;
    end;
end;

procedure Inserir(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
    ranking: TRanking;
    body: TJSONValue;
begin
    try
        ranking := TRanking.Create;

        try
            body := Req.Body<TJSONObject>;

            ranking.Adicionar(body.GetValue<string>('nome', ''),
                              body.GetValue<integer>('level', 0),
                              body.GetValue<integer>('pontos', 0));

            Res.Send('success').Status(THTTPStatus.Created); // 201

        except on ex:exception do
            Res.Send(ex.Message).Status(THTTPStatus.InternalServerError);
        end;
    finally
        ranking.Free;
    end;
end;



end.
