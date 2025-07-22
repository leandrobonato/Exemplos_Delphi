unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, u99Permissions, FMX.MediaLibrary.Actions, System.Actions,
  FMX.ActnList, FMX.StdActns;

type
  TFrmPrincipal = class(TForm)
    Layout1: TLayout;
    imgCamera: TImage;
    imgLibrary: TImage;
    imgFoto: TImage;
    ActionList1: TActionList;
    ActCamera: TTakePhotoFromCameraAction;
    ActLibrary: TTakePhotoFromLibraryAction;
    OpenDialog: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ActCameraDidFinishTaking(Image: TBitmap);
    procedure imgCameraClick(Sender: TObject);
    procedure imgLibraryClick(Sender: TObject);
  private
    { Private declarations }
    permissao: T99Permissions;
    procedure ErroPermissaoFoto(Sender: TObject);
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

procedure TFrmPrincipal.ActCameraDidFinishTaking(Image: TBitmap);
begin
    imgFoto.Bitmap := Image;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
    permissao := T99Permissions.Create;
end;

procedure TFrmPrincipal.FormDestroy(Sender: TObject);
begin
    permissao.DisposeOf;
end;

procedure TFrmPrincipal.ErroPermissaoFoto(Sender: TObject);
begin
    showmessage('Você não possui acesso a esse recurso no aparelho');
end;

procedure TFrmPrincipal.imgCameraClick(Sender: TObject);
begin
    {$IFDEF MSWINDOWS}
    if OpenDialog.Execute then
        imgFoto.Bitmap.LoadFromFile(OpenDialog.FileName);
    {$ELSE}
    permissao.Camera(ActCamera, ErroPermissaoFoto);
    {$ENDIF}
end;

procedure TFrmPrincipal.imgLibraryClick(Sender: TObject);
begin
    {$IFDEF MSWINDOWS}
    if OpenDialog.Execute then
        imgFoto.Bitmap.LoadFromFile(OpenDialog.FileName);
    {$ELSE}
    permissao.PhotoLibrary(ActLibrary, ErroPermissaoFoto);
    {$ENDIF}

end;

end.
