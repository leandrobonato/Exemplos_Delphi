unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  Horse,
 Horse.Jhonson,
 Horse.CORS,
 System.JSON,
 DataModule.Global,
 System.IOUtils,
 RESTRequest4D, FMX.Memo.Types, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Memo;

type
  TFrmPrincipal = class(TForm)
    TabSMS: TFDMemTable;
    memo: TMemo;
    procedure FormShow(Sender: TObject);
  private
    procedure SendSMS(celular, msg: string);
    procedure EnviarSMS(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure EditarSenha(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure EnviarEmail(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure RelClienteTXT(Req: THorseRequest; Res: THorseResponse;
      Next: TProc);
    procedure SendEmail(destinatario, assunto, texto: string; arquivo: string = '');
    procedure SolicitarResetSenha(Req: THorseRequest; Res: THorseResponse;
      Next: TProc);
    procedure ValidarTokenSenha(Req: THorseRequest; Res: THorseResponse;
      Next: TProc);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

Const
  MINHA_SENHA = 'sua senha aqui...';
  API_KEY = 'seu token aqui...';
  BASE_URL_SMS = 'https://api.smsempresa.com.br/v1';


implementation


{$R *.fmx}


uses IdSMTP,
     IdMessage,
     IdSSLOpenSSL,
     IdExplicitTLSClientServerBase,
     IdAttachmentFile,
     IdText;

procedure TFrmPrincipal.SendEmail(destinatario, assunto, texto: string; arquivo: string = '');
var
    SMTP: TIdSMTP;
    Msg: TIdMessage;
    IdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
    IdText: TIdText;
begin
    if destinatario.IsEmpty then
        raise Exception.Create('E-mail do destintário não informado');
    if assunto.IsEmpty then
        raise Exception.Create('Assunto do e-mail não informado');
    if texto.IsEmpty then
        raise Exception.Create('Texto do e-mail não informado');


    Msg := TIdMessage.Create(nil);
    IdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create();

    // SSL...
    IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
    IdSSLIOHandlerSocket.SSLOptions.Mode := sslmClient;

    try
        Msg.From.Address := 'aws99coders@gmail.com';
        Msg.From.Name := '99 Coders';
        Msg.Recipients.EMailAddresses := destinatario;
        Msg.Subject := assunto;
        Msg.Encoding := meMIME;


        // Corpo email...
        IdText := TIdText.Create(Msg.MessageParts);
        IdText.Body.Add(texto);
        IdText.ContentType := 'text/html;charset=utf-8';

        // Anexo...
        if FileExists(arquivo) then
            TIdAttachmentFile.Create(Msg.MessageParts, arquivo);  //--> c:\arquivos\teste.txt


        SMTP := TIdSMTP.Create(nil);
        SMTP.IOHandler := IdSSLIOHandlerSocket;
        SMTP.Host := 'smtp.gmail.com';
        SMTP.Port := 587;
        SMTP.AuthType := satDefault;
        SMTP.UseTLS := utUseImplicitTLS;
        SMTP.Username := 'aws99coders@gmail.com';
        SMTP.Password := MINHA_SENHA;
        SMTP.Connect;
        SMTP.Send(Msg);
    finally
        SMTP.Free;
        Msg.Free;
        IdSSLIOHandlerSocket.Free;
    end;
end;

procedure TFrmPrincipal.EnviarEmail(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
    destinatario, assunto, texto: string;
    body: TJSONObject;
begin
    try
        body := Req.Body<TJSONObject>;

        destinatario := body.GetValue<string>('destinatario', '');
        assunto := body.GetValue<string>('assunto', '');
        texto := body.GetValue<string>('texto', '');

        SendEmail(destinatario, assunto, texto);

        Res.Send('E-mail enviado com sucesso').Status(200);

    except on ex:exception do
        Res.Send(ex.Message).Status(500);
    end;
end;

procedure TFrmPrincipal.SolicitarResetSenha(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
    fone, token, texto: string;
    body: TJSONObject;
    DmGlobal: TDmGlobal;
begin
    try
        try
            body := Req.Body<TJSONObject>;
            fone := body.GetValue<string>('fone', '');

            // Gerar o token...
            DmGlobal := TDmGlobal.Create(nil);
            token := DmGlobal.GerarTokenFone(fone);

            // Enviar do SMS...
            texto := 'Segue o token para alterar a senha: ' + token;

            SendSMS(fone, texto);

            Res.Send('SMS enviado com sucesso').Status(200);

        except on ex:exception do
            Res.Send(ex.Message).Status(500);
        end;
    finally
        FreeAndNil(DmGlobal);
    end;
end;

procedure TFrmPrincipal.ValidarTokenSenha(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
    fone, token: string;
    DmGlobal: TDmGlobal;
begin
    try
        try
            fone := Req.Query.Items['fone'];
            token := Req.Query.Items['token'];

            // Validar o token...
            DmGlobal := TDmGlobal.Create(nil);
            DmGlobal.ValidarTokenSenha(fone, token);

            Res.Send('Token válido').Status(200);

        except on ex:exception do
            Res.Send(ex.Message).Status(500);
        end;
    finally
        FreeAndNil(DmGlobal);
    end;
end;

procedure TFrmPrincipal.EditarSenha(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
    fone, token, senha: string;
    body: TJSONObject;
    DmGlobal: TDmGlobal;
begin
    try
        try
            body := Req.Body<TJSONObject>;
            fone := body.GetValue<string>('fone', '');
            token := body.GetValue<string>('token', '');
            senha := body.GetValue<string>('senha', '');

            DmGlobal := TDmGlobal.Create(nil);
            DmGlobal.EditarSenha(fone, token, senha);

            Res.Send('Senha alterada com sucesso').Status(200);

        except on ex:exception do
            Res.Send(ex.Message).Status(500);
        end;
    finally
        FreeAndNil(DmGlobal);
    end;
end;

procedure TFrmPrincipal.RelClienteTXT(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
    email, arq: string;
    body: TJSONObject;
    DmGlobal: TDmGlobal;
begin
    try
        try
            body := Req.Body<TJSONObject>;
            email := body.GetValue<string>('email', '');

            // Monta nome do arquivo...
            arq := System.SysUtils.GetCurrentDir + '\reports';

            if NOT TDirectory.Exists(arq) then
                TDirectory.CreateDirectory(arq);

            arq := arq + '\rel-clientes.txt';
            //--------------------------


            DmGlobal := TDmGlobal.Create(nil);

            if email.IsEmpty then
                raise Exception.Create('E-mail do usuário não informado');

            DmGlobal.RelClienteTXT(arq);

            SendEmail(email, 'Relatório de Clientes', 'Segue o relatório de clientes.<br><br>99 Coders', arq);

            // Excluir arquivo...
            if FileExists(arq) then
                DeleteFile(arq);


            Res.Send('Relatório enviado com sucesso').Status(200);

        except on ex:exception do
            Res.Send(ex.Message).Status(500);
        end;
    finally
        FreeAndNil(DmGlobal);
    end;
end;

procedure TFrmPrincipal.SendSMS(celular, msg: string);
var
    json: TJSONObject;
    resp: IResponse;
begin
    if celular.IsEmpty then
        raise Exception.Create('Celular do destintário não informado');
    if msg.IsEmpty then
        raise Exception.Create('Mensagem não informada');

    try
        json := TJSONObject.Create;
        json.AddPair('key', API_KEY);
        json.AddPair('type', '9');
        json.AddPair('number', celular);
        json.AddPair('msg', msg);
        json.AddPair('out', 'JSON');
        json.AddPair('refer', 'ped-1000');

        resp := TRequest.New.BaseURL(BASE_URL_SMS)
                .Resource('send')
                .Accept('application/json')
                .AddBody(json.ToString)
                .DataSetAdapter(TabSMS)
                .Post;

        memo.Lines.Add(resp.StatusCode.ToString);
        memo.Lines.Add(resp.Content);

        if resp.StatusCode = 200 then
        begin
            memo.Lines.Add('situacao=' + TabSMS.FieldByName('situacao').AsString);
            memo.Lines.Add('codigo=' + TabSMS.FieldByName('codigo').AsString);
            memo.Lines.Add('id=' + TabSMS.FieldByName('id').AsString);
            memo.Lines.Add('refer=' + TabSMS.FieldByName('refer').AsString);
            memo.Lines.Add('number=' + TabSMS.FieldByName('number').AsString);
            memo.Lines.Add('descricao=' + TabSMS.FieldByName('descricao').AsString);
        end;

    finally
        json.DisposeOf;
    end;
end;

procedure TFrmPrincipal.EnviarSMS(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
    celular, msg: string;
    body: TJSONObject;
begin
    try
        body := Req.Body<TJSONObject>;

        celular := body.GetValue<string>('celular', '');
        msg := body.GetValue<string>('msg', '');


        SendSMS(celular, msg);

        Res.Send('SMS enviado com sucesso').Status(200);

    except on ex:exception do
        Res.Send(ex.Message).Status(500);
    end;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
    THorse.Use(Jhonson());
    THorse.Use(CORS);

    // Email...
    THorse.Post('/email', EnviarEmail);

    {
    THorse.Post('/usuarios/reset', SolicitarResetSenha); // Criar o token e enviar o email...
    THorse.Get('/usuarios/reset', ValidarTokenSenha); // Validacao se o token pertence ao usuario...
    THorse.Put('/usuarios/reset', EditarSenha); // Efetivamente muda a senha do usuario...
    }

    THorse.Post('/usuarios/reset', SolicitarResetSenha); // Criar o token e enviar por SMS...
    THorse.Get('/usuarios/reset', ValidarTokenSenha); // Validacao se o token pertence ao usuario...
    THorse.Put('/usuarios/reset', EditarSenha); // Efetivamente muda a senha do usuario...

    THorse.Post('/reports/clientes', RelClienteTXT);


    // SMS...
    THorse.Post('/sms', EnviarSMS);


    THorse.Listen(9000);

    {
    THorse.Listen(9000, procedure (Horse: THorse)
    begin

    end);
    }
end;

end.
