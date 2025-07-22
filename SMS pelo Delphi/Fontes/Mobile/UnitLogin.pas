unit UnitLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.TabControl,

  // Para baixar e instalar essa unit, assista o seguinte video:
  // https://youtu.be/Im4LPpGmgAc
  RESTRequest4D,
  //---------------------------------

  System.JSON;

type
  TFrmLogin = class(TForm)
    TabControl: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    Layout1: TLayout;
    edtEmail: TEdit;
    EdtSenha: TEdit;
    Rectangle1: TRectangle;
    SpeedButton1: TSpeedButton;
    lblEsqueci: TLabel;
    lyt: TLayout;
    edtFoneRecuperacao: TEdit;
    Rectangle2: TRectangle;
    btnRecuperar: TSpeedButton;
    Layout2: TLayout;
    edtToken: TEdit;
    Rectangle3: TRectangle;
    btnToken: TSpeedButton;
    Label1: TLabel;
    Layout3: TLayout;
    edtSenha1: TEdit;
    EdtSenha2: TEdit;
    Rectangle4: TRectangle;
    btnRedefinir: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure lblEsqueciClick(Sender: TObject);
    procedure btnRecuperarClick(Sender: TObject);
    procedure btnTokenClick(Sender: TObject);
    procedure btnRedefinirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.fmx}

procedure TFrmLogin.btnRecuperarClick(Sender: TObject);
var
    resp: IResponse;
    json: TJSONObject;
begin
    try
        json := TJSONObject.Create;
        json.AddPair('fone', edtFoneRecuperacao.Text); // {"fone": "11900000000"}

        resp := TRequest.New.BaseURL('http://localhost:9000')
                        .Resource('usuarios/reset')
                        .AddBody(json.ToString)
                        .Accept('application/json')
                        .Post;

        if resp.StatusCode <> 200 then
            showmessage(resp.Content)
        else
            TabControl.GotoVisibleTab(2);

    finally
        json.DisposeOf;
    end;
end;

procedure TFrmLogin.btnRedefinirClick(Sender: TObject);
var
    resp: IResponse;
    json: TJSONObject;
begin
    try
        // {"fone": "1100000000", "token": "000000", "senha": "12345"}

        json := TJSONObject.Create;
        json.AddPair('fone', edtFoneRecuperacao.Text);
        json.AddPair('token', edtToken.Text);
        json.AddPair('senha', edtSenha1.Text);

        resp := TRequest.New.BaseURL('http://localhost:9000')
                        .Resource('usuarios/reset')
                        .AddBody(json.ToString)
                        .Accept('application/json')
                        .Put;

        if resp.StatusCode <> 200 then
            showmessage(resp.Content)
        else
            TabControl.GotoVisibleTab(0);

    finally
        json.DisposeOf;
    end;
end;

procedure TFrmLogin.btnTokenClick(Sender: TObject);
var
    resp: IResponse;
begin
    // http://localhost:9000/usuarios/reset?fone=1100000000000&token=00000

    resp := TRequest.New.BaseURL('http://localhost:9000')
                    .Resource('usuarios/reset')
                    .AddParam('fone', edtFoneRecuperacao.Text)
                    .AddParam('token', edtToken.Text)
                    .Accept('application/json')
                    .Get;

    if resp.StatusCode <> 200 then
        showmessage(resp.Content)
    else
        TabControl.GotoVisibleTab(3);
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
    TabControl.ActiveTab := TabItem1;
end;

procedure TFrmLogin.lblEsqueciClick(Sender: TObject);
begin
    TabControl.GotoVisibleTab(1);
end;

end.
