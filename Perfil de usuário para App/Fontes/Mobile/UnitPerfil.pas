unit UnitPerfil;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit, uLoading,
  uFunctions, Data.DB, FMX.MediaLibrary.Actions, System.Actions, FMX.ActnList,
  FMX.StdActns, u99Permissions;

type
  TFrmPerfil = class(TForm)
    Rectangle1: TRectangle;
    imgVoltar: TImage;
    imgSalvar: TImage;
    Label1: TLabel;
    cFoto: TCircle;
    Layout1: TLayout;
    Label2: TLabel;
    edtNome: TEdit;
    Layout2: TLayout;
    Label3: TLabel;
    edtEmail: TEdit;
    Layout3: TLayout;
    Label4: TLabel;
    edtSenha: TEdit;
    Label5: TLabel;
    ActionList: TActionList;
    ActCamera: TTakePhotoFromCameraAction;
    ActLibrary: TTakePhotoFromLibraryAction;
    OpenDialog: TOpenDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure imgSalvarClick(Sender: TObject);
    procedure cFotoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ActLibraryDidFinishTaking(Image: TBitmap);
  private
    id_usuario: integer;
    permissao: T99Permissions;
    procedure ThreadContaTerminate(Sender: TObject);
    procedure TrataErroPermissao(Sender: TObject);
  public
    { Public declarations }
  end;

var
  FrmPerfil: TFrmPerfil;

implementation

{$R *.fmx}

uses DataModule.Global;

procedure TFrmPerfil.TrataErroPermissao(Sender: TObject);
begin
    showmessage('Você não possui permissão para esse recurso');
end;

procedure TFrmPerfil.ActLibraryDidFinishTaking(Image: TBitmap);
begin
    cfoto.fill.bitmap.bitmap := Image;
end;

procedure TFrmPerfil.cFotoClick(Sender: TObject);
begin
     {$IFDEF MSWINDOWS}
        if OpenDialog.Execute then
            cFoto.Fill.Bitmap.Bitmap.LoadFromFile(OpenDialog.FileName);
    {$ELSE}
        permissao.PhotoLibrary(ActLibrary, TrataErroPermissao);
    {$ENDIF}

end;

procedure TFrmPerfil.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := TCloseAction.caFree;
    FrmPerfil := nil;
end;

procedure TFrmPerfil.FormCreate(Sender: TObject);
begin
    permissao := T99Permissions.Create;
end;

procedure TFrmPerfil.FormDestroy(Sender: TObject);
begin
    permissao.DisposeOf;
end;

procedure TFrmPerfil.FormShow(Sender: TObject);
begin
    try
        Dm.DadosUsuario;

        id_usuario := Dm.qryUsuario.fieldbyname('id_usuario').asinteger;
        edtNome.Text := Dm.qryUsuario.fieldbyname('nome').asstring;
        edtEmail.Text := Dm.qryUsuario.fieldbyname('email').asstring;
        edtSenha.Text := Dm.qryUsuario.fieldbyname('senha').asstring;

        //Foto do usuario...
        if Dm.qryUsuario.fieldbyname('foto').asstring <> '' then
            TFunctions.LoadBitmapFromBlob(cFoto.Fill.bitmap.bitmap,
                                          TBlobField(Dm.qryUsuario.fieldbyname('foto')));

    except on ex:exception do
        showmessage(ex.Message);
    end;
end;

procedure TFrmPerfil.ThreadContaTerminate(Sender: TObject);
begin
    TLoading.Hide;

    if Assigned(TThread(Sender).FatalException) then
    begin
        showmessage(Exception(TThread(sender).FatalException).Message);
        exit;
    end;

    close;
end;

procedure TFrmPerfil.imgSalvarClick(Sender: TObject);
var
    t: TThread;
begin
    TLoading.Show(FrmPerfil, 'Salvando...');

    t := TThread.CreateAnonymousThread(procedure
    var
        foto64: string;
    begin
        sleep(2000);

        foto64 := TFunctions.Base64FromBitmap(cFoto.fill.Bitmap.Bitmap);

        Dm.EditarUsuarioAPI(id_usuario,
                            edtNome.text,
                            edtEmail.Text,
                            edtSenha.Text,
                            foto64);

        Dm.ExcluirUsuario;
        Dm.InserirUsuario(id_usuario,
                          edtNome.text,
                          edtEmail.Text,
                          edtSenha.Text,
                          cFoto.Fill.Bitmap.Bitmap);
    end);

    t.OnTerminate := ThreadContaTerminate;
    t.Start;
end;

end.
