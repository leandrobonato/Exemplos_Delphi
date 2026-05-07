unit uShellFolders;

interface

uses
  System.SysUtils;

function GetDesktopFolder: string;
function GetDocumentsFolder: string;
function GetDownloadsFolder: string;
function GetMusicFolder: string;
function GetPicturesFolder: string;
function GetVideosFolder: string;
function GetAppDataFolder: string;

implementation

uses
  Winapi.Windows, Winapi.ShlObj;

const
  CSIDL_DESKTOP = $0000;
  CSIDL_MYDOCUMENTS = $000C;
  CSIDL_MYMUSIC = $000D;
  CSIDL_MYPICTURES = $0027;
  CSIDL_MYVIDEO = $000E;
  CSIDL_DOWNLOADS = $0020;
  CSIDL_APPDATA = $001A;

function GetShellFolder(CSIDL: Integer): string;
var
  Path: array[0..MAX_PATH] of Char;
begin
  Result := '';
  if SHGetSpecialFolderPath(0, Path, CSIDL, False) then
    Result := Path;
end;

function GetDesktopFolder: string;
begin
  Result := GetShellFolder(CSIDL_DESKTOP);
end;

function GetDocumentsFolder: string;
begin
  Result := GetShellFolder(CSIDL_MYDOCUMENTS);
end;

function GetDownloadsFolder: string;
begin
  Result := GetShellFolder(CSIDL_DOWNLOADS);
end;

function GetMusicFolder: string;
begin
  Result := GetShellFolder(CSIDL_MYMUSIC);
end;

function GetPicturesFolder: string;
begin
  Result := GetShellFolder(CSIDL_MYPICTURES);
end;

function GetVideosFolder: string;
begin
  Result := GetShellFolder(CSIDL_MYVIDEO);
end;

function GetAppDataFolder: string;
begin
  Result := GetShellFolder(CSIDL_APPDATA);
end;

end.