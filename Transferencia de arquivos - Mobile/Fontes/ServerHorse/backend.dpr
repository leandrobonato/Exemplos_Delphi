program backend;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse, System.JSON,
  Horse.Jhonson,
  Horse.BasicAuthentication,
  Horse.OctetStream,
  System.Classes;

begin
    THorse.Use(Jhonson);
    THorse.Use(OctetStream);
    THorse.Use(HorseBasicAuthentication(
    function(const AUserName, APassword: string): boolean
    begin
        Result := (AUserName = 'testserver') and (APassword = 'testserver');
    end));

    THorse.Get('/getfile', procedure(req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
        ArqStream: TStream;
        body: TJSONValue;
        arq : string;
    begin
        body := TJSONObject.ParseJSONValue(TEncoding.UTF8.Getbytes(req.Body), 0) as TJsonValue;
        arq := 'C:\Temp\Files\' + body.GetValue<string>('arquivo'); // {"arquivo": "arquivo.pdf"}
        body.DisposeOf;

        if FileExists(arq) then
        begin
            ArqStream := TFileStream.Create(arq, fmOpenRead);
            Res.Send<TStream>(ArqStream);
            Writeln('Arquivo enviado: ' + arq);
        end
        else
            Res.Send('Arquivo não encontrado: ' + arq).Status(404);
    end);

    THorse.Listen(9000, procedure(Horse: THorse)
    begin
        Writeln('Servidor no ar... Porta 9000');
    end);

end.
