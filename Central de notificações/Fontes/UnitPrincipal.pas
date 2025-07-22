unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Platform,

  {$IFDEF ANDROID}
  FMX.PushNotification.Android,
  {$ENDIF}
  {$IFDEF IOS}
  FMX.PushNotification.FCM.iOS,
  {$ENDIF}

  System.PushNotification, System.Notification;

type
  TFrmPrincipal = class(TForm)
    memLog: TMemo;
    NotificationCenter: TNotificationCenter;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    FPushService: TPushService;
    FPushServiceConnection: TPushServiceConnection;
    procedure RegistrarDevice(token: string);
    procedure OnServiceConnectionChange(Sender: TObject;
      PushChanges: TPushService.TChanges);
    procedure OnServiceConnectionReceiveNotification(Sender: TObject;
      const ServiceNotification: TPushServiceNotification);
    procedure LimparNotificacoes;
    function AppEventProc(AAppEvent: TApplicationEvent;
      AContext: TObject): Boolean;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

procedure TFrmPrincipal.LimparNotificacoes;
begin
    NotificationCenter.CancelAll;
end;

// Recebe notificacoes com o app fechado...
procedure TFrmPrincipal.FormActivate(Sender: TObject);
var
    Notifications : TArray<TPushServiceNotification>;
    x : integer;
    msg : string;
begin
    Notifications := FPushService.StartupNotifications; // notificacoes que abriram meu app...

    if Length(Notifications) > 0 then
    begin
        for x := 0 to Notifications[0].DataObject.Count - 1 do
        begin
            memLog.lines.Add(Notifications[0].DataObject.Pairs[x].JsonString.Value + ' = ' +
                             Notifications[0].DataObject.Pairs[x].JsonValue.Value);

            if Notifications[0].DataObject.Pairs[x].JsonString.Value = 'mensagem' then
                msg := Notifications[0].DataObject.Pairs[x].JsonValue.Value;
        end;
    end;

    if msg <> '' then
        showmessage(msg);
end;

function TFrmPrincipal.AppEventProc(AAppEvent: TApplicationEvent; AContext: TObject): Boolean;
begin
    if (AAppEvent = TApplicationEvent.BecameActive) then
        LimparNotificacoes;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
var
    AppEvent : IFMXApplicationEventService;
begin
    // Eventos do app (para exclusao das notificacoes)...
    if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationEventService, IInterface(AppEvent)) then
        AppEvent.SetApplicationEventHandler(AppEventProc);

    FPushService := TPushServiceManager.Instance.GetServiceByName(TPushService.TServiceNames.FCM);
    FPushServiceConnection := TPushServiceConnection.Create(FPushService);

    FPushServiceConnection.OnChange := OnServiceConnectionChange;
    FPushServiceConnection.OnReceiveNotification := OnServiceConnectionReceiveNotification;

    FPushServiceConnection.Active := True;
end;

procedure TFrmPrincipal.FormDestroy(Sender: TObject);
begin
    FPushServiceConnection.Free;
end;

procedure TFrmPrincipal.OnServiceConnectionChange(Sender: TObject;
  PushChanges: TPushService.TChanges);
var
    token : string;
begin
    if TPushService.TChange.Status in PushChanges then
    begin
        if FPushService.Status = TPushService.TStatus.Started then
        begin
            memLog.Lines.Add('Serviço de push iniciado com sucesso');
            memLog.Lines.Add('----');
        end
        else
        if FPushService.Status = TPushService.TStatus.StartupError then
        begin
            FPushServiceConnection.Active := False;

            memLog.Lines.Add('Erro ao iniciar serviço de push');
            memLog.Lines.Add(FPushService.StartupError);
            memLog.Lines.Add('----');
        end;
    end;

    if TPushService.TChange.DeviceToken in PushChanges then
    begin
        token := FPushService.DeviceTokenValue[TPushService.TDeviceTokenNames.DeviceToken];

        memLog.Lines.Add('Token do aparelho recebido');
        memLog.Lines.Add('Token: ' + token);
        memLog.Lines.Add('---');
        memLog.Lines.EndUpdate;

        RegistrarDevice(token);
    end;
end;

// Recebe notificacoes com o app aberto...
procedure TFrmPrincipal.OnServiceConnectionReceiveNotification(Sender: TObject;
  const ServiceNotification: TPushServiceNotification);
var
    x : integer;
    msg : string;
begin
    memLog.Lines.Add('Push recebido');
    memLog.Lines.Add('DataKey: ' + ServiceNotification.DataKey);
    memLog.Lines.Add('Json: ' + ServiceNotification.Json.ToString);
    memLog.Lines.Add('DataObject: ' + ServiceNotification.DataObject.ToString);
    memLog.Lines.Add('---');

    {
    for x := 0 to ServiceNotification.DataObject.Count - 1 do
    begin
        memLog.lines.Add(ServiceNotification.DataObject.Pairs[x].JsonString.Value + ' = ' +
                         ServiceNotification.DataObject.Pairs[x].JsonValue.Value);

        if ServiceNotification.DataObject.Pairs[x].JsonString.Value = 'mensagem' then
                msg := ServiceNotification.DataObject.Pairs[x].JsonValue.Value;
    end;

    if msg <> '' then
        showmessage(msg);
    }
end;

procedure TFrmPrincipal.RegistrarDevice(token: string);
begin
    // Salvar o token do aparelho na tabela de usuarios do servidor
    // TAB_USUARIO
    //------------------
    // Cod_usuario INT
    // Token_device varchar(100)
end;

end.
