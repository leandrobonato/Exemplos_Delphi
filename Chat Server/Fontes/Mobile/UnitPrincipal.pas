unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  DataSet.Serialize.Config, uSession, FMX.Objects;

type
  TFrmPrincipal = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    lvConversa: TListView;
    btnAdd: TSpeedButton;
    imgContato: TImage;
    imgGrupo: TImage;
    procedure FormShow(Sender: TObject);
    procedure lvConversaItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
  private
    ThreadChat: TThread;
    procedure AddConversa(cod_usuario, cod_grupo: integer;
                                    nome_grupo, nome_usuario, texto_ult_msg, dt_ult_msg: string);
    procedure CarregarConversas;
    procedure ThreadConversasTerminate(Sender: TObject);
    procedure BuscarNovasMensagens;
    procedure ListarConversas;
    procedure IniciarThread;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses UnitChat, DataModule.Global, UnitNovoChat;

procedure TFrmPrincipal.IniciarThread;
begin
    ThreadChat := TThread.CreateAnonymousThread(procedure
    var
        cont : integer;
    begin
        cont := 0;

        while NOT ThreadChat.CheckTerminated do
        begin
            sleep(1000);
            inc(cont);

            if cont >= SEGUNDOS_REFRESH then
            begin
                BuscarNovasMensagens;
                cont := 0;

                ListarConversas;
            end;

        end;
    end);

    ThreadChat.FreeOnTerminate := false;
    //ThreadChat.OnTerminate := ThreadTerminate;
    ThreadChat.Start;
end;

procedure TFrmPrincipal.AddConversa(cod_usuario, cod_grupo: integer;
                                    nome_grupo, nome_usuario, texto_ult_msg, dt_ult_msg: string);
var
    item: TListViewItem;
begin
    item := lvConversa.Items.Add;

    with item do
    begin
        Height := 60;

        if cod_grupo > 0 then
        begin
            Tag := 0;
            TagString := nome_grupo;
            TListItemImage(Objects.FindDrawable('imgIcone')).Bitmap := imgGrupo.Bitmap;
            TListItemText(Objects.FindDrawable('txtNome')).Text := nome_grupo;
        end
        else
        begin
            Tag := cod_usuario; // Codigo do meu amigo...
            TagString := nome_usuario;
            TListItemImage(Objects.FindDrawable('imgIcone')).Bitmap := imgContato.Bitmap;
            TListItemText(Objects.FindDrawable('txtNome')).Text := nome_usuario;
        end;

        TListItemImage(Objects.FindDrawable('imgIcone')).TagFloat := cod_grupo;
        TListItemText(Objects.FindDrawable('txtMsg')).Text := texto_ult_msg;
        TListItemText(Objects.FindDrawable('txtData')).Text := dt_ult_msg;
    end;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
    TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
    TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
    TSession.cod_usuario_logado := 1;
    TSession.nome_usuario_logado := 'Heber Stein Mazutti';
    //TSession.nome_usuario_logado := 'Tony Stark';
    //TSession.nome_usuario_logado := 'João Alves';

    CarregarConversas;
end;

procedure TFrmPrincipal.btnAddClick(Sender: TObject);
begin
    if NOT Assigned(FrmNovoChat) then
        Application.CreateForm(TFrmNovoChat, FrmNovoChat);

    FrmNovoChat.Show;
end;

procedure TFrmPrincipal.BuscarNovasMensagens;
begin
    // listar todas as novas mensagens para mim (no server)...
    DmGlobal.ListarHistoricoMensagens(TSession.cod_usuario_logado);

    with DmGlobal do
    begin
        while NOT TabMensagem.EOF do
        begin
            if TabMensagem.FieldByName('cod_grupo').AsInteger = 0 then
            begin
                InserirMensagemMobile(TabMensagem.FieldByName('cod_mensagem').AsInteger,
                                      TabMensagem.FieldByName('cod_usuario_de').AsInteger,
                                      TabMensagem.FieldByName('cod_usuario_para').AsInteger,
                                      Copy(TabMensagem.FieldByName('dt_geracao').AsString, 1, 19), // 2020-10-15 08:15:27.000
                                      TabMensagem.FieldByName('texto').asstring,
                                      TabMensagem.FieldByName('nome').asstring,
                                      '',
                                      false);
            end
            else
            begin
                InserirMensagemGrupoMobile(TabMensagem.FieldByName('cod_mensagem').AsInteger,
                                           TabMensagem.FieldByName('cod_usuario_de').AsInteger,
                                          TabMensagem.FieldByName('cod_grupo').AsInteger,
                                          TabMensagem.FieldByName('nome_grupo').AsString,
                                          Copy(TabMensagem.FieldByName('dt_geracao').AsString, 1, 19), // 2020-10-15 08:15:27.000
                                          TabMensagem.FieldByName('texto').asstring,
                                          TabMensagem.FieldByName('nome').asstring,
                                          false);
            end;

            TabMensagem.Next;
        end;
    end;
end;

procedure TFrmPrincipal.ListarConversas;
begin
    lvConversa.Items.Clear;
    DmGlobal.ListarConversasMobile;

    with DmGlobal.qryConversa do
    begin
        while NOt EOF do
        begin
            TThread.Synchronize(TThread.CurrentThread, procedure
            begin
                AddConversa(FieldByName('cod_usuario').AsInteger,
                            FieldByName('cod_grupo').AsInteger,
                            FieldByName('nome_grupo').AsString,
                            FieldByName('nome').AsString,
                            FieldByName('texto_ult_mensagem').AsString,
                            FormatDateTime('dd/mm/yy hh:nn', FieldByName('dt_ult_mensagem').AsDateTime));
            end);

            Next;
        end;
    end;
end;

procedure TFrmPrincipal.ThreadConversasTerminate(Sender: TObject);
begin
    if Sender is TThread then
        if Assigned(TThread(Sender).FatalException) then
            showmessage(Exception(TThread(sender).FatalException).Message);

    IniciarThread;
end;

procedure TFrmPrincipal.CarregarConversas;
var
    t: TThread;
begin
    t := TThread.CreateAnonymousThread(procedure
    begin
        BuscarNovasMensagens; // Baixar as msg do server
        ListarConversas; // Exibe as conversas na lista
    end);

    t.OnTerminate := ThreadConversasTerminate;
    t.Start;
end;

procedure TFrmPrincipal.lvConversaItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
    if NOT Assigned(FrmChat) then
        Application.CreateForm(TFrmChat, FrmChat);

    FrmChat.cod_usuario_amigo := AItem.Tag;
    FrmChat.nome_usuario_amigo := AItem.TagString;

    FrmChat.cod_grupo := Trunc(TListItemImage(AItem.Objects.FindDrawable('imgIcone')).TagFloat);
    FrmChat.nome_grupo := AItem.TagString;

    FrmChat.Show;
end;

end.
