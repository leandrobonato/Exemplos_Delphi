unit UnitLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Layouts, FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects,
  u99Permissions, FMX.MediaLibrary.Actions, System.Actions, FMX.ActnList,
  FMX.StdActns, uLoading, uFunctions, Data.DB;

type
  TFrmLogin = class(TForm)
    TabControl: TTabControl;
    TabLogin: TTabItem;
    TabConta1: TTabItem;
    TabConta2: TTabItem;
    TabFoto: TTabItem;
    Layout1: TLayout;
    Label1: TLabel;
    Label2: TLabel;
    edtEmail: TEdit;
    Label3: TLabel;
    edtSenha: TEdit;
    Rectangle1: TRectangle;
    btnLogin: TSpeedButton;
    lblCriarConta: TLabel;
    Label5: TLabel;
    Layout2: TLayout;
    Label6: TLabel;
    Label7: TLabel;
    EdtContaEmail: TEdit;
    Label8: TLabel;
    EdtContaNome: TEdit;
    Rectangle2: TRectangle;
    btnProximo: TSpeedButton;
    lblLogin: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    EdtContaSenha: TEdit;
    Layout3: TLayout;
    Rectangle3: TRectangle;
    btnCriarConta: TSpeedButton;
    Layout4: TLayout;
    Label12: TLabel;
    imgCamera: TImage;
    imgLibrary: TImage;
    imgVoltar1: TImage;
    imgVoltar2: TImage;
    ActionList: TActionList;
    ActCamera: TTakePhotoFromCameraAction;
    ActLibrary: TTakePhotoFromLibraryAction;
    cFoto: TCircle;
    OpenDialog: TOpenDialog;
    procedure lblCriarContaClick(Sender: TObject);
    procedure lblLoginClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure imgVoltar1Click(Sender: TObject);
    procedure imgVoltar2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure imgCameraClick(Sender: TObject);
    procedure imgLibraryClick(Sender: TObject);
    procedure ActCameraDidFinishTaking(Image: TBitmap);
    procedure ActLibraryDidFinishTaking(Image: TBitmap);
    procedure cFotoClick(Sender: TObject);
    procedure btnCriarContaClick(Sender: TObject);
  private
    permissao: T99Permissions;
    procedure AbrirFormPrincipal;
    procedure TrataErroPermissao(Sender: TObject);
    procedure ThreadContaTerminate(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.fmx}

uses UnitPrincipal, DataModule.Global;

procedure TFrmLogin.AbrirFormPrincipal;
begin
    if NOT Assigned(FrmPrincipal) then
        Application.CreateForm(TFrmPrincipal, FrmPrincipal);

    FrmPrincipal.show;
end;

procedure TFrmLogin.ActCameraDidFinishTaking(Image: TBitmap);
begin
    cFoto.Fill.Bitmap.Bitmap := Image;
    TabControl.GotoVisibleTab(2);
end;

procedure TFrmLogin.ActLibraryDidFinishTaking(Image: TBitmap);
begin
    cFoto.Fill.Bitmap.Bitmap := Image;
    TabControl.GotoVisibleTab(2);
end;

procedure TFrmLogin.ThreadContaTerminate(Sender: TObject);
begin
    TLoading.Hide;

    if Assigned(TThread(Sender).FatalException) then
    begin
        showmessage(Exception(TThread(sender).FatalException).Message);
        exit;
    end;

    AbrirFormPrincipal;
end;

procedure TFrmLogin.btnCriarContaClick(Sender: TObject);
var
    t: TThread;
begin
    TLoading.Show(FrmLogin, 'Criando Conta...');

    t := TThread.CreateAnonymousThread(procedure
    var
        foto64: string; // Carregar uma foto como base64...
    begin
        sleep(2000);
        Dm.ExcluirUsuario;

        foto64 := TFunctions.Base64FromBitmap(cFoto.Fill.Bitmap.Bitmap);

        Dm.InserirUsuarioAPI(EdtContaNome.Text,
                             EdtContaEmail.Text,
                             EdtContaSenha.Text,
                             foto64);

        Dm.InserirUsuario(Dm.TabUsuario.fieldbyname('id_usuario').asinteger,
                          EdtContaNome.Text,
                          EdtContaEmail.Text,
                          EdtContaSenha.Text,
                          cFoto.Fill.Bitmap.Bitmap);
    end);

    t.OnTerminate := ThreadContaTerminate;
    t.Start;
end;

procedure TFrmLogin.btnLoginClick(Sender: TObject);
var
    t: TThread;
begin
    TLoading.Show(FrmLogin, 'Acessando...');

    t := TThread.CreateAnonymousThread(procedure
    var
        foto: TBitmap;
    begin
        sleep(2000);
        Dm.ExcluirUsuario;

        Dm.LoginAPI(edtEmail.Text, edtSenha.Text);

        // Tratamento da foto...
        foto := TBitmap.create;

        if Dm.TabUsuario.fieldbyname('foto').asstring = '' then
            foto := nil
        else
            TFunctions.LoadBitmapFromBlob(foto, TBlobField(Dm.TabUsuario.fieldbyname('foto')));


        Dm.InserirUsuario(Dm.TabUsuario.fieldbyname('id_usuario').asinteger,
                          Dm.TabUsuario.fieldbyname('nome').asstring,
                          EdtEmail.Text,
                          EdtSenha.Text,
                          foto);

        foto.DisposeOf;
    end);

    t.OnTerminate := ThreadContaTerminate;
    t.Start;
end;

procedure TFrmLogin.btnProximoClick(Sender: TObject);
begin
    TabControl.GotoVisibleTab(2);
end;

procedure TFrmLogin.cFotoClick(Sender: TObject);
begin
    {$IFDEF MSWINDOWS}
        if OpenDialog.Execute then
            cFoto.Fill.Bitmap.Bitmap.LoadFromFile(OpenDialog.FileName);
    {$ELSE}
        TabControl.GotoVisibleTab(3);
    {$ENDIF}
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
    TabControl.ActiveTab := TabLogin;
    permissao := T99Permissions.Create;
end;

procedure TFrmLogin.FormDestroy(Sender: TObject);
begin
    permissao.DisposeOf;
end;

procedure TFrmLogin.TrataErroPermissao(Sender: TObject);
begin
    showmessage('Você não possui permissão para esse recurso');
end;

procedure TFrmLogin.imgCameraClick(Sender: TObject);
begin
    permissao.Camera(ActCamera, TrataErroPermissao);
end;

procedure TFrmLogin.imgLibraryClick(Sender: TObject);
begin
    permissao.PhotoLibrary(ActLibrary, TrataErroPermissao);
end;

procedure TFrmLogin.imgVoltar1Click(Sender: TObject);
begin
    TabControl.GotoVisibleTab(1);
end;

procedure TFrmLogin.imgVoltar2Click(Sender: TObject);
begin
    TabControl.GotoVisibleTab(2);
end;

procedure TFrmLogin.lblCriarContaClick(Sender: TObject);
begin
    TabControl.GotoVisibleTab(1);
end;

procedure TFrmLogin.lblLoginClick(Sender: TObject);
begin
    TabControl.GotoVisibleTab(0);
end;

end.
