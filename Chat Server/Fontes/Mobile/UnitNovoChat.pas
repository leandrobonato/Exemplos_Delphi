unit UnitNovoChat;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit,
  FMX.ListBox, System.JSON, uSession;

type
  TFrmNovoChat = class(TForm)
    TabControl: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    Layout1: TLayout;
    imgContato: TImage;
    imgGrupo: TImage;
    edtGrupo: TEdit;
    Rectangle1: TRectangle;
    btnGrupo: TSpeedButton;
    Label1: TLabel;
    Layout2: TLayout;
    lblTitulo: TLabel;
    imgVoltar: TImage;
    imgFechar: TImage;
    Image1: TImage;
    btnCriar: TSpeedButton;
    Rectangle2: TRectangle;
    Label2: TLabel;
    lbContatos: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgFecharClick(Sender: TObject);
    procedure imgContatoClick(Sender: TObject);
    procedure imgGrupoClick(Sender: TObject);
    procedure lbContatosChangeCheck(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtGrupoTyping(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure imgVoltarClick(Sender: TObject);
    procedure btnCriarClick(Sender: TObject);
    procedure lbContatosItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure btnGrupoClick(Sender: TObject);
  private
    tipo: string;
    procedure HabilitarBotaoCriar;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmNovoChat: TFrmNovoChat;

implementation

{$R *.fmx}

uses DataModule.Global, UnitChat;

procedure TFrmNovoChat.btnCriarClick(Sender: TObject);
var
    membros: TJsonArray;
    i, cod_grupo: integer;
begin
    try
        membros := TJsonArray.Create;

        for i := 0 to lbContatos.Count - 1 do
            if lbContatos.ItemByIndex(i).IsChecked then
                membros.Add(
                    TJSONObject.Create(TJSONPair.Create('cod_usuario', TJSONNumber.Create(lbContatos.ItemByIndex(i).Tag)))
                );

        cod_grupo := DmGlobal.InserirGrupo(TSession.cod_usuario_logado, edtGrupo.Text, membros);

        DmGlobal.InserirMensagemGrupoMobile(0, TSession.cod_usuario_logado, cod_grupo, edtGrupo.Text,
                                           FormatDateTime('yyyy-mm-dd hh:nn:ss', now), 'Grupo criado',
                                           TSession.nome_usuario_logado, false);

        Close;

    except on ex:exception do
        begin
            showmessage(ex.Message);
        end;
    end;
end;

procedure TFrmNovoChat.btnGrupoClick(Sender: TObject);
begin
    TabControl.GotoVisibleTab(2);
end;

procedure TFrmNovoChat.edtGrupoTyping(Sender: TObject);
begin
    btnGrupo.Enabled := edtGrupo.Text.Length > 0;
end;

procedure TFrmNovoChat.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := TCloseAction.caFree;
    FrmNovoChat := nil;
end;

procedure TFrmNovoChat.FormCreate(Sender: TObject);
begin
    TabControl.ActiveTab := TabItem1;
end;

procedure TFrmNovoChat.HabilitarBotaoCriar;
var
    i: integer;
begin
    btnCriar.Visible := false;
    btnCriar.Enabled := false;

    if tipo = 'grupo' then
    begin
        btnCriar.Visible := true;

        for i := 0 to lbContatos.Count - 1 do
            if lbContatos.ItemByIndex(i).IsChecked then
            begin
                btnCriar.Enabled := true;
                break;
            end;
    end;
end;

procedure TFrmNovoChat.Image1Click(Sender: TObject);
begin
        TabControl.GotoVisibleTab(0);
end;

procedure TFrmNovoChat.imgContatoClick(Sender: TObject);
begin
    tipo := 'contato';
    btnGrupo.Enabled := false;
    HabilitarBotaoCriar;
    lblTitulo.Text := 'Selecione o contato';
    lbContatos.ShowCheckboxes := false;
    TabControl.GotoVisibleTab(2);
end;

procedure TFrmNovoChat.imgFecharClick(Sender: TObject);
begin
    close;
end;

procedure TFrmNovoChat.imgGrupoClick(Sender: TObject);
begin
    tipo := 'grupo';
    btnGrupo.Enabled := false;
    HabilitarBotaoCriar;
    lblTitulo.Text := 'Selecione os contatos';
    lbContatos.ShowCheckboxes := true;
    TabControl.GotoVisibleTab(1);
end;

procedure TFrmNovoChat.imgVoltarClick(Sender: TObject);
begin
    TabControl.GotoVisibleTab(0);
end;

procedure TFrmNovoChat.lbContatosChangeCheck(Sender: TObject);
begin
    HabilitarBotaoCriar;
end;

procedure TFrmNovoChat.lbContatosItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
    if tipo = 'contato' then
    begin
        if NOT Assigned(FrmChat) then
            Application.CreateForm(TFrmChat, FrmChat);

        FrmChat.cod_usuario_amigo := Item.Tag;
        FrmChat.nome_usuario_amigo := Item.Text;

        FrmChat.cod_grupo := 0;
        FrmChat.nome_grupo := '';

        FrmChat.Show;
    end;
end;

end.
