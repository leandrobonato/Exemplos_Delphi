unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Winsock,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, Vcl.Imaging.jpeg, Vcl.ComCtrls, Data.DB;

type
  PNetResourceArray = ^TNetResourceArray;
  TNetResourceArray = array [0 .. 100] of TNetResource;

  TForm1 = class(TForm)
    Button1: TButton;
    lstEstacoes: TListView;
    listaUsuarios: TListBox;
    procedure Button1Click(Sender: TObject);
  private
    Plataforma: String;
    function GetIP(AEstacao: string): string;
    procedure IncluiEstacao(AEstacao, AIP: string);
    procedure ListaAmbienteRede;
    function VersaoWindows: string;

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  I: shortint;
  Nome: string;
  IP: string;
begin
  try
    ListaUsuarios.Clear;
    lstEstacoes.Items.Clear;
    Screen.Cursor := crHourGlass;

    Plataforma := VersaoWindows;
    ListaAmbienteRede;

    lstEstacoes.Items.Clear;
    for I := 0 to ListaUsuarios.Count - 1 do
    begin
     Nome := ListaUsuarios.Items[I];
     try
       IP := GetIP(ListaUsuarios.Items[I]);
     except
       IP := ' ';
     end;

     IncluiEstacao(Nome, IP);
     Update;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.IncluiEstacao(AEstacao, AIP: string);
var
  Item: TListItem;
begin
with lstEstacoes do
begin
 Item := Items.Add;
 Item.Caption := AEstacao;
 Item.SubItems.Add(AIP);
end;
end;

procedure TForm1.ListaAmbienteRede;
procedure Enumera(Res: PnetResource);
var
 Hnd: THandle;
 NumeroEntradas: DWord;
 Buffer: array[1..255] of TNetResource;
 LongBuffer: DWord;
 N: Integer;
 S: string;
begin
 LongBuffer := SizeOf(Buffer);
 if WNetOpenEnum(RESOURCE_GLOBALNET, RESOURCETYPE_ANY, 0, Res, Hnd) = No_ERROR then
 begin
   NumeroEntradas := 255;
   WNetEnumResource(Hnd, NumeroEntradas, @Buffer[1], LongBuffer);
   for N := 1 to NumeroEntradas do
   begin
     S := string(Buffer[N].lpRemoteName);
     if Plataforma = 'xp' then
       if (Buffer[1].dwType = 0) and (Copy(S, 1, 2) = '\\') then
         ListaUsuarios.Items.Add(Copy(S, 3, Length(S) - 2));
     if Plataforma = '9x' then
       if (Buffer[1].dwType = 3) and (Copy(S, 1, 2) = '\\') then
         ListaUsuarios.Items.Add(Copy(S, 3, Length(S) - 2));
     if (Buffer[N].dwUsage and RESOURCEUSAGE_CONTAINER) = RESOURCEUSAGE_CONTAINER then
       Enumera(@Buffer[N]);
     Update;
   end;
 end;
end;
begin
Enumera(nil);
end;

function TForm1.GetIP(AEstacao: string): string;
var
WSAData: TWSAData;
HostEnt: PHostEnt;
begin
  WSAStartup(2, WSAData);
  HostEnt := GetHostByName(PAnsiChar(AEstacao));
  with HostEnt^ do
   Result :=
     Format('%d.%d.%d.%d', [Byte(h_addr^[0]), Byte(h_addr^[1]), Byte(h_addr^[2]), Byte(h_addr^[3])]);
  WSACleanup;
end;

function TForm1.VersaoWindows: string;
var
  PlatformId, CSDVersion: string;
begin
  CSDVersion := '';
  case Win32Platform of
   VER_PLATFORM_WIN32_WINDOWS:
     begin
       if Win32MajorVersion = 4 then
         case Win32MinorVersion of
           0: PlatformId := '9x';
           10: PlatformId := '9x';
           90: PlatformId := 'ME';
         end
       else
         PlatformId := '9x';
       Result := '9x';
     end;

   VER_PLATFORM_WIN32_NT:
     begin
       if Length(Win32CSDVersion) > 0 then
         CSDVersion := Win32CSDVersion;
       if Win32MajorVersion <= 4 then
         PlatformId := 'NT'
       else if Win32MajorVersion = 5 then
         case Win32MinorVersion of
           0: PlatformId := '2000';
           1: PlatformId := 'XP';
           2: PlatformId := '2003';
         else
           PlatformId := '?';
         end
       else
         PlatformId := '?';
       Result := 'xp';
     end;
  end;
end;
end.
