unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, WinSvc;

type
  TForm2 = class(TForm)
    pnlInfoServices: TPanel;
    pnlStartStopService: TPanel;
    btnStartServer: TBitBtn;
    btnStopSerrver: TBitBtn;
    shpStatus: TShape;
    btnProcurar: TBitBtn;
    procedure btnStopSerrverClick(Sender: TObject);
    procedure btnStartServerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FListaServices: TStringList;
    FPrefixoNomeServico: String;
    FDisplayNameService: String;
    FStatusService: Cardinal;
    FNomeServico: String;
    function IniciarPararServico: Boolean;
    function ServiceGetList(const AMachine : string; AdwServiceType: DWord;
      AdwServiceState : DWord): TStringList;

  public
    { Public declarations }

  published
    { Published declarations }
    property ListaServices: TStringList read FListaServices write FListaServices;
    property PrefixoNomeServico: String read FPrefixoNomeServico write FPrefixoNomeServico;
    property NomeServico: String read FNomeServico write FNomeServico;
    property DisplayNameService: String read FDisplayNameService write FDisplayNameService;
    property StatusService: Cardinal read FStatusService write FStatusService;
  end;

var
  Form2: TForm2;

implementation

uses
  ComCtrls;

{$R *.dfm}

procedure TForm2.btnStartServerClick(Sender: TObject);
begin
  ShowMessage(FListaServices.Strings[0]);
  FStatusService := SERVICE_START;
  IniciarPararServico;
  shpStatus.Brush.Color := clGreen;
  ShowMessage('Serviço do firebird iniciado!');
end;

procedure TForm2.btnStopSerrverClick(Sender: TObject);
begin
  FStatusService := SERVICE_STOP;
  IniciarPararServico;
  shpStatus.Brush.Color := clRed;
  showMessage('Serviço do firebird parado');
end;

function TForm2.IniciarPararServico:Boolean;
var
  lHWND : HWND;
  vServiceManager: SC_Handle;
  vServiceHandle : SC_Handle;
  vServiceStatus : TServiceStatus;
  vEspera : Integer;
  vIdxServices: Integer;
  vArg: PChar;
begin
  Screen.Cursor := crHourglass;
  try
    if (Win32Platform=VER_PLATFORM_WIN32_WINDOWS) then
    begin
      lHWND := FindWindow(PWideChar(FNomeServico),PWideChar(FDisplayNameService));
      PostMessage(lHWND,WM_CLOSE,0,0);
    end
    else if (Win32Platform=VER_PLATFORM_WIN32_NT) then
    begin
      vServiceManager := OpenSCManager('',nil,SC_MANAGER_CONNECT);
      if (vServiceManager>0) then
      begin
        if FStatusService = SERVICE_STOP then
        begin
          for vIdxServices := 0 to FListaServices.Count - 1 do
          begin
            vServiceHandle := OpenService(vServiceManager,PWideChar(FListaServices.Strings[vIdxServices]),SERVICE_STOP);
            Application.ProcessMessages;
            ControlService(vServiceHandle,SERVICE_CONTROL_STOP,vServiceStatus);
            CloseServiceHandle(vServiceHandle);
          end;
        end
        else if FStatusService = SERVICE_START then
        begin
          for vIdxServices := 0 to FListaServices.Count - 1 do
          begin
            vServiceHandle := OpenService(vServiceManager,PWideChar(FListaServices.Strings[vIdxServices]),SERVICE_ALL_ACCESS);
            Application.ProcessMessages;
            StartService(vServiceHandle, 0, vArg);
            CloseServiceHandle(vServiceHandle);
          end;
        end;
      end;
      CloseServiceHandle(vServiceManager);
    end;
  finally
    Application.ProcessMessages;
    vEspera := 0;
    while ((FindWindow(PWideChar(FNomeServico),PWideChar(FDisplayNameService))<>0) and (vEspera<100)) do
    begin
      Application.ProcessMessages;
      Sleep(500);
      Inc(vEspera);
    end;
    Screen.Cursor := crDefault;
    Result := ( FindWindow(PWideChar(FNomeServico),PWideChar(FDisplayNameService)) = 0 ) ;
  end;
end;


procedure TForm2.FormCreate(Sender: TObject);
begin
  FNomeServico := 'FB_Server';
  FDisplayNameService := 'Firebird Server - Default Instance';
  FPrefixoNomeServico := 'FIREBIRD';
  FListaServices := ServiceGetList('', SERVICE_WIN32, SERVICE_STATE_ALL);
end;

function TForm2.ServiceGetList(const AMachine : string; AdwServiceType: DWord;
  AdwServiceState : DWord): TStringList;
var
  vIdxServices : integer;
  vServiceManager : SC_Handle;
  nBytesNeeded: DWord;
  nServices: DWord;
  nResumeHandle : DWord;
  vBuffer : array of Byte;
  vEnumServiceStatus: PEnumServiceStatus;
  vEnumServiceStatus_New: PEnumServiceStatus;
begin
  vServiceManager := OpenSCManager(PChar(AMachine), nil, SC_MANAGER_CONNECT or SC_MANAGER_ENUMERATE_SERVICE);
  try
    if (vServiceManager <> 0) then
    begin
      nResumeHandle := 0;
      if not EnumServicesStatus(
        vServiceManager,
        AdwServiceType,
        AdwServiceState,
        {$IFDEF lpServices_Param_Is_Pointer}nil{$ELSE}PEnumServiceStatus(nil)^{$ENDIF},
        0,
        nBytesNeeded,
        nServices,
        nResumeHandle) then
      begin
        if (GetLastError() <> ERROR_INSUFFICIENT_BUFFER) and (GetLastError() <> ERROR_MORE_DATA) then
        begin
          Exit;
        end;
        SetLength(vBuffer, nBytesNeeded);
        vEnumServiceStatus := PEnumServiceStatus(vBuffer);
        if not EnumServicesStatus(
          vServiceManager,
          AdwServiceType,
          AdwServiceState,
          vEnumServiceStatus{$IFNDEF lpServices_Param_Is_Pointer}^{$ENDIF},
          Length(vBuffer),
          nBytesNeeded,
          nServices,
          nResumeHandle) then
        begin
          Exit;
        end;
      end;
      if (nServices > 0) then
      begin
        vEnumServiceStatus_New := vEnumServiceStatus;
        for vIdxServices := 0 to nServices-1 do
        begin
          if Pos(FPrefixoNomeServico, UpperCase(vEnumServiceStatus_New.lpDisplayName)) > 0 then
            Result.Add(vEnumServiceStatus_New.lpServiceName);
          Inc(vEnumServiceStatus_New);
        end;
      end;
    end;
  finally
    CloseServiceHandle(vServiceManager);
  end;
end;

end.

//FNomeService = FB_Server
//FDisplayNameService = Firebird Server - Default Instance
//FPrefixoNomeServico = FIREBIRD
