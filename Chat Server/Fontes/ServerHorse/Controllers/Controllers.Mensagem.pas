unit Controllers.Mensagem;

interface

uses Horse,
     Horse.Jhonson,
     System.Classes,
     System.JSON,
     System.SysUtils,
     DataModule.Global;

procedure RegistrarRotas;
procedure ListarNovasMensagens(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure ListarHistoricoMensagem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure InserirMensagem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure InserirGrupo(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

procedure RegistrarRotas;
begin
    THorse.Get('/messages', ListarNovasMensagens); // Buscar por novas msg...
    THorse.Get('/messages/historico', ListarHistoricoMensagem); // Todas as msg...
    THorse.Post('/messages', InserirMensagem);

    THorse.Post('/groups', InserirGrupo);
end;

procedure ListarHistoricoMensagem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
    cod_usuario_logado: integer;
    DmGlobal: TDmGlobal;
begin
    try
        try
            DmGlobal := TDmGlobal.Create(nil);

            try
                cod_usuario_logado := Req.Query['cod_usuario_logado'].ToInteger;
            except
                cod_usuario_logado := 0;
            end;

            Res.Send(DmGlobal.ListarHistoricoMensagem(cod_usuario_logado)).Status(200);

        except on ex:exception do
            Res.Send(ex.Message).Status(500);
        end;
    finally
        FreeAndNil(DmGlobal);
    end;
end;

procedure ListarNovasMensagens(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
    cod_usuario_de, cod_usuario_para, cod_mensagem: integer;
    DmGlobal: TDmGlobal;
begin
    try
        try
            DmGlobal := TDmGlobal.Create(nil);

            try
                cod_usuario_de := Req.Query['cod_usuario_de'].ToInteger;
            except
                cod_usuario_de := 0;
            end;

            try
                cod_usuario_para := Req.Query['cod_usuario_para'].ToInteger;
            except
                cod_usuario_para := 0;
            end;

            try
                cod_mensagem := Req.Query['cod_mensagem'].ToInteger;
            except
                cod_mensagem := 0;
            end;

            Res.Send(DmGlobal.ListarNovasMensagens(cod_usuario_de, cod_usuario_para, cod_mensagem)).Status(200);

        except on ex:exception do
            Res.Send(ex.Message).Status(500);
        end;
    finally
        FreeAndNil(DmGlobal);
    end;
end;

procedure InserirMensagem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
    cod_usuario_de, cod_usuario_para, cod_grupo: integer;
    texto: string;
    body: TJSONValue;

    DmGlobal: TDmGlobal;
begin
    try
        try
            DmGlobal := TDmGlobal.Create(nil);

            body := Req.Body<TJSONObject>;
            cod_usuario_de := body.GetValue<integer>('cod_usuario_de', 0);
            cod_usuario_para := body.GetValue<integer>('cod_usuario_para', 0);
            cod_grupo := body.GetValue<integer>('cod_grupo', 0);
            texto := body.GetValue<string>('texto', '');


            Res.Send(DmGlobal.InserirMensagem(cod_usuario_de, cod_usuario_para, cod_grupo, texto)).Status(201);

        except on ex:exception do
            Res.Send(ex.Message).Status(500);
        end;
    finally
        FreeAndNil(DmGlobal);
    end;
end;

procedure InserirGrupo(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
    cod_usuario: integer;
    nome: string;
    membros: TJSONArray;
    body: TJSONValue;
    DmGlobal: TDmGlobal;
begin
    try
        try
            DmGlobal := TDmGlobal.Create(nil);

            body := Req.Body<TJSONObject>;
            cod_usuario := body.GetValue<integer>('cod_usuario', 0);
            nome := body.GetValue<string>('nome', '');
            membros := body.GetValue<TJSONArray>('membros');

            Res.Send(DmGlobal.InserirGrupo(cod_usuario, nome, membros)).Status(201);

        except on ex:exception do
            Res.Send(ex.Message).Status(500);
        end;
    finally
        FreeAndNil(DmGlobal);
    end;
end;

end.
