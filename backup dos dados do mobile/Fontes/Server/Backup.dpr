program Backup;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Classes,
  Horse,
  Horse.Jhonson,
  Horse.OctetStream,
  System.JSON;

begin
    THorse.Use(Jhonson);
    THorse.Use(OctetStream);

    THorse.Post('/backup', procedure (Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
        LStream: TMemoryStream;
    begin
        LStream := Req.Body<TMemoryStream>;
        LStream.SaveToFile('C:\Temp\Backup\backup.db');
        Res.Send('Backup realizado').Status(200);

        Writeln('Backup realizado');
    end);

    THorse.Get('/restore', procedure (Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
        LStream : TStream;
        arq : string;
    begin
        arq := 'C:\Temp\Backup\backup.db';

        if FileExists(arq) then
        begin
            LStream := TFileStream.Create(arq, fmOpenRead);
            Res.Send<TStream>(LStream).Status(200);
            Writeln('Arquivo enviado');
        end
        else
            Res.Send('Arquivo não encontrado: ' + arq).Status(404);
    end);

     THorse.Listen(9000, procedure (Horse: THorse)
    begin
        Writeln('Ouvindo porta ' + Horse.Port.ToString);
    end);
end.
