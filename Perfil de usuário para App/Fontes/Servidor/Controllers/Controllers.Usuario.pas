unit Controllers.Usuario;

interface

uses Horse,
     System.JSON,
     System.SysUtils,
     FMX.Graphics,
     uFunctions,
     DataModule.Global;

procedure RegistrarRotas;
procedure Login(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure InserirUsuario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure EditarUsuario(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

procedure RegistrarRotas;
begin
    THorse.Post('/usuarios', InserirUsuario);
    THorse.Put('/usuarios/:id_usuario', EditarUsuario);
    THorse.Post('/usuarios/login', Login);
end;

procedure Login(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
    Dm: TDm;
    body, json: TJSONObject;
    email, senha: string;
begin
    try
        try
            Dm := TDm.create(nil);

            body := Req.Body<TJSONObject>;
            email := body.GetValue<string>('email', '');
            senha := body.GetValue<string>('senha', '');

            json := Dm.Login(email, senha);

            if (json.Size = 0) then
            begin
                Res.Send('E-mail ou senha inválida').Status(401);
                FreeAndNil(json);
            end
            else
                Res.Send<TJSONObject>(json).Status(200);

        except on ex:exception do
            Res.Send(ex.message).Status(500);
        end;

    finally
        FreeAndNil(Dm);
    end;
end;

procedure InserirUsuario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
    Dm: TDm;
    body: TJSONObject;
    nome, email, senha, foto64: string;
    foto: TBitmap;
begin
    try
        try
            Dm := TDm.create(nil);

            body := Req.Body<TJSONObject>;
            nome := body.GetValue<string>('nome', '');
            email := body.GetValue<string>('email', '');
            senha := body.GetValue<string>('senha', '');
            foto64 := body.GetValue<string>('foto', '');

            if foto64 = '' then
                foto := nil
            else
                foto := TFunctions.BitmapFromBase64(foto64);

            Res.Send<TJSONObject>(Dm.InserirUsuario(nome, email, senha, foto)).Status(201);
            //                    {"id_usuario": 123}

        except on ex:exception do
            Res.Send(ex.message).Status(500);
        end;

    finally
        FreeAndNil(Dm);
    end;
end;

procedure EditarUsuario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
    Dm: TDm;
    body: TJSONObject;

    id_usuario: integer;
    nome, email, senha, foto64: string;
    foto: TBitmap;
begin
    try
        try
            Dm := TDm.create(nil);

            try
                id_usuario := Req.Params.Items['id_usuario'].ToInteger;
            except
                id_usuario := 0;
            end;

            body := Req.Body<TJSONObject>;
            nome := body.GetValue<string>('nome', '');
            email := body.GetValue<string>('email', '');
            senha := body.GetValue<string>('senha', '');
            foto64 := body.GetValue<string>('foto', '');

            if foto64 = '' then
                foto := nil
            else
                foto := TFunctions.BitmapFromBase64(foto64);

            Dm.EditarUsuario(id_usuario, nome, email, senha, foto);

            Res.Send('OK').Status(200);

        except on ex:exception do
            Res.Send(ex.message).Status(500);
        end;

    finally
        FreeAndNil(Dm);
    end;
end;


end.
