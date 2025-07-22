unit UnitMainService;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,

  Horse,
  Horse.Jhonson,
  Horse.BasicAuthentication,
  Controllers.Ranking;

type
  TMainService = class(TService)
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  MainService: TMainService;

implementation

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  MainService.Controller(CtrlCode);
end;

function TMainService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TMainService.ServiceCreate(Sender: TObject);
begin
    THorse.Use(Jhonson());

    THorse.Use(HorseBasicAuthentication(
    function(const AUsername, APassword: string): Boolean
    begin
        Result := AUsername.Equals('numbers') and APassword.Equals('numbers');
    end));

    Controllers.Ranking.RegistrarRotas;
end;

procedure TMainService.ServiceStart(Sender: TService; var Started: Boolean);
begin
    THorse.Listen(9000);
end;

procedure TMainService.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
    THorse.StopListen;
end;

end.
