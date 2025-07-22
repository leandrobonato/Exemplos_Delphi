unit UnitChat;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FMX.TextLayout, FMX.Edit, DataSet.Serialize.Config, RESTRequest4D,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.JSON, uSession,
  uFunctions;

type
  TFrmChat = class(TForm)
    Layout1: TLayout;
    imgVoltar: TImage;
    lblNome: TLabel;
    lvChat: TListView;
    lytMensagem: TLayout;
    imgFundo: TImage;
    StyleBook1: TStyleBook;
    edtTexto: TEdit;
    btnEnviar: TSpeedButton;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure lvChatUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btnEnviarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure imgVoltarClick(Sender: TObject);
  private
    cod_ult_msg_recebida: integer;
    ThreadChat: TThread;
    FCod_usuario_amigo: integer;
    FCod_usuario_logado: integer;
    FNome_usuario_amigo: string;
    Fcod_grupo: integer;
    Fnome_grupo: string;
    procedure AddMessage(id_msg: integer; texto, dt: string;
      ind_proprio: boolean);
    procedure LayoutLv(item: TListViewItem);
    procedure LayoutLvProprio(item: TListViewItem);
    function GetTextHeight(const D: TListItemText; const Width: single;
      const Text: string): Integer;
    procedure ListarMensagens(ind_clear: boolean);
    procedure IniciarThread;
    procedure ThreadTerminate(Sender: TObject);
    procedure ScrollChatToEnd;
    { Private declarations }
  public
    { Public declarations }
    property cod_usuario_amigo: integer read FCod_usuario_amigo write FCod_usuario_amigo;
    property nome_usuario_amigo: string read FNome_usuario_amigo write FNome_usuario_amigo;
    property cod_grupo: integer read Fcod_grupo write Fcod_grupo;
    property nome_grupo: string read Fnome_grupo write Fnome_grupo;
  end;

var
  FrmChat: TFrmChat;

Const
  SEGUNDOS_REFRESH = 5;
  BASE_URL = 'http://localhost:9000';
  //BASE_URL = 'http://ip-do-seu-pc:9000';

implementation

{$R *.fmx}

uses DataModule.Global;

function TFrmChat.GetTextHeight(const D: TListItemText; const Width: single; const Text: string): Integer;
var
  Layout: TTextLayout;
begin
  Layout := TTextLayoutManager.DefaultTextLayout.Create;
  try
    Layout.BeginUpdate;
    try
      Layout.Font.Assign(D.Font);
      Layout.VerticalAlign := D.TextVertAlign;
      Layout.HorizontalAlign := D.TextAlign;
      Layout.WordWrap := D.WordWrap;
      Layout.Trimming := D.Trimming;
      Layout.MaxSize := TPointF.Create(Width, TTextLayout.MaxLayoutSize.Y);
      Layout.Text := Text;
    finally
      Layout.EndUpdate;
    end;

    Result := Round(Layout.Height);

    Layout.Text := 'm';
    Result := Result + Round(Layout.Height);
  finally
    Layout.Free;
  end;
end;

procedure TFrmChat.imgVoltarClick(Sender: TObject);
begin
    close;
end;

procedure TFrmChat.LayoutLv(item: TListViewItem);
var
    img: TListItemImage;
    txt: TListItemText;
begin
    // Posiciona o texto...
    txt := TListItemText(item.Objects.FindDrawable('txtMsg'));
    txt.Width := lvChat.Width / 2 - 16;
    txt.PlaceOffset.X := 20;
    txt.PlaceOffset.Y := 10;
    txt.Height := GetTextHeight(txt, txt.Width, txt.Text);
    txt.TextColor := $FF000000;

    // Balao msg...
    img := TListItemImage(item.Objects.FindDrawable('imgFundo'));
    img.Width := lvChat.Width / 2;
    img.PlaceOffset.X := 10;
    img.PlaceOffset.Y := 10;
    img.Height := txt.Height;
    img.Opacity := 0.1;

    if txt.Height < 40 then
        img.Width := Trunc(txt.Text.Length * 8);

    if img.Width < 105 then
        img.Width := 105;

    // Data...
    txt := TListItemText(item.Objects.FindDrawable('txtData'));
    txt.PlaceOffset.X := img.PlaceOffset.X + img.Width - 100;
    txt.PlaceOffset.Y := img.PlaceOffset.Y + img.Height + 2;

    // Altura do item da Lv...
    item.Height := Trunc(img.PlaceOffset.Y + img.Height + 30);
end;

procedure TFrmChat.LayoutLvProprio(item: TListViewItem);
var
    img: TListItemImage;
    txt: TListItemText;
    margem: integer;
begin
    {$IFDEF MSWINDOWS}
    margem := 5;
    {$ELSE}
    margem := 0;
    {$ENDIF}

    // Posiciona o texto...
    txt := TListItemText(item.Objects.FindDrawable('txtMsg'));
    txt.Width := lvChat.Width / 2 - 16;
    txt.PlaceOffset.Y := 10;
    txt.Height := GetTextHeight(txt, txt.Width, txt.Text);
    txt.TextColor := $FFFFFFFF;

    // Balao msg...
    img := TListItemImage(item.Objects.FindDrawable('imgFundo'));

    if txt.Height < 40 then // Msg com apenas uma linha...
        img.Width := Trunc(txt.Text.Length * 8)
    else
        img.Width := lvChat.Width / 2;

    if img.Width < 105 then
        img.Width := 105;

    img.PlaceOffset.X := lvChat.Width - 10 - img.Width - margem;
    img.PlaceOffset.Y := 10;
    img.Height := txt.Height;
    img.Opacity := 1;

    txt.PlaceOffset.X := lvChat.Width - img.Width;


    // Data...
    txt := TListItemText(item.Objects.FindDrawable('txtData'));
    txt.PlaceOffset.X := img.PlaceOffset.X + img.Width - 100 - margem;
    txt.PlaceOffset.Y := img.PlaceOffset.Y + img.Height + 2;

    // Altura do item da Lv...
    item.Height := Trunc(img.PlaceOffset.Y + img.Height + 30);
end;

procedure TFrmChat.ThreadTerminate(Sender: TObject);
begin
    if Sender is TThread then
        if Assigned(TThread(Sender).FatalException) then
            showmessage(Exception(TThread(sender).FatalException).Message);
end;

procedure TFrmChat.IniciarThread;
begin
    ThreadChat := TThread.CreateAnonymousThread(procedure
    var
        cont : integer;
    begin
        cont := 0;
        ListarMensagens(true);

        while NOT ThreadChat.CheckTerminated do
        begin
            sleep(1000);
            inc(cont);

            if cont >= SEGUNDOS_REFRESH then
            begin
                ListarMensagens(false);
                ScrollChatToEnd;
                cont := 0;
            end;

        end;
    end);

    ThreadChat.FreeOnTerminate := false;
    ThreadChat.OnTerminate := ThreadTerminate;
    ThreadChat.Start;
end;

procedure TFrmChat.AddMessage(id_msg: integer;
                                   texto, dt: string;
                                   ind_proprio: boolean);
var
    item: TListViewItem;
begin
    item := lvChat.Items.Add;

    with item do
    begin
        Height := 100;
        Tag := id_msg;

        if ind_proprio then
            TagString := 'S'
        else
            TagString := 'N';

        // Fundo...
        TListItemImage(Objects.FindDrawable('imgFundo')).Bitmap := imgFundo.Bitmap;

        // Texto...
        TListItemText(Objects.FindDrawable('txtMsg')).Text := texto;

        // Data...
        TListItemText(Objects.FindDrawable('txtData')).Text := dt;
    end;

    if ind_proprio then
        LayoutLvProprio(item)
    else
        LayoutLv(item);
end;


procedure TFrmChat.ListarMensagens(ind_clear: boolean);
var
    resp: IResponse;
    ind_proprio: boolean;
    nome: string;
begin
    if ind_clear then
    begin
        cod_ult_msg_recebida := 0;
        lvChat.Items.Clear;
    end;

    // Listar as mensagens de ou para meu amigo / grupo...
    if cod_grupo > 0 then
        DmGlobal.ListarMensagensGrupoMobile(cod_grupo, cod_ult_msg_recebida)
    else
        DmGlobal.ListarMensagensMobile(cod_usuario_amigo, cod_ult_msg_recebida);

    with DmGlobal.qryMensagem do
    begin
        while NOT Eof do
        begin
            if fieldbyname('cod_usuario_de').AsInteger = TSession.cod_usuario_logado then
            begin
                ind_proprio := true;
                nome := '';
            end
            else
            begin
                ind_proprio := false;
                nome := 'Usuário ' + fieldbyname('cod_usuario_de').AsString + ':' + sLineBreak;
            end;

            if cod_grupo = 0 then
                nome := '';

            TThread.Synchronize(TThread.CurrentThread, procedure
            begin
                AddMessage(fieldbyname('cod_mensagem').AsInteger,
                           nome +  fieldbyname('texto').AsString,
                           FormatdateTime('dd/mm/yyyy hh:nn', DmGlobal.qryMensagem.fieldbyname('dt_geracao').AsDateTime),
                           ind_proprio);
            end);

            cod_ult_msg_recebida := fieldbyname('cod_mensagem').AsInteger;
            Next;
        end;
    end;

    if ind_clear then
        lvChat.ScrollTo(lvChat.Items.Count - 1); // Scroll para o fim...
end;

procedure TFrmChat.ScrollChatToEnd;
begin
    if lvChat.GetItemRect(lvChat.Items.Count - 1).Top <= lvChat.Height then
        lvChat.ScrollTo(lvChat.Items.Count - 1);
end;

procedure TFrmChat.lvChatUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
begin
    if AItem.TagString = 'S' then
        LayoutLvProprio(AItem)
    else
        LayoutLv(AItem);
end;

procedure TFrmChat.btnEnviarClick(Sender: TObject);
var
    cod_mensagem: integer;
    dt_geracao: string;
begin
    try
        cod_mensagem := DmGlobal.EnviarMensagem(TSession.cod_usuario_logado, cod_usuario_amigo, cod_grupo, edtTexto.text);
        dt_geracao := FormatDateTime('yyyy-mm-dd hh:nn:ss', now);

        if cod_mensagem > cod_ult_msg_recebida then
            cod_ult_msg_recebida := cod_mensagem;

        if cod_grupo > 0 then
            DmGlobal.InserirMensagemGrupoMobile(cod_mensagem, TSession.cod_usuario_logado, cod_grupo,
                                                nome_grupo, dt_geracao, edtTexto.Text, '', true)
        else
            DmGlobal.InserirMensagemMobile(cod_mensagem, TSession.cod_usuario_logado, cod_usuario_amigo,
                                           dt_geracao, edtTexto.Text, '', nome_usuario_amigo, true);

        AddMessage(cod_mensagem, edtTexto.Text, FormataData(dt_geracao), true);
        lvChat.ScrollTo(lvChat.Items.Count - 1);
        edtTexto.Text := '';

    except on ex:exception do
        showmessage(ex.Message);
    end;
end;

procedure TFrmChat.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    ThreadChat.Terminate;
    FreeAndNil(ThreadChat);
end;

procedure TFrmChat.FormShow(Sender: TObject);
begin
    if cod_grupo > 0 then
        lblNome.Text := nome_grupo + ' (' + cod_grupo.ToString + ')'
    else
        lblNome.Text := nome_usuario_amigo + ' (' + cod_usuario_amigo.ToString + ')';

    IniciarThread;
end;

procedure TFrmChat.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
    lytMensagem.Margins.Bottom := 0;
end;

procedure TFrmChat.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
    lytMensagem.Margins.Bottom := 330;
end;

end.
