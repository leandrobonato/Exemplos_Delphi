unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, FMX.ListBox, uLoading;

type
  TFrmPrincipal = class(TForm)
    Rectangle1: TRectangle;
    Label1: TLabel;
    btnRefresh: TSpeedButton;
    lbClientes: TListBox;
    Rectangle2: TRectangle;
    btnExcluir: TSpeedButton;
    btnLimpar: TSpeedButton;
    imgCliente: TImage;
    procedure btnRefreshClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure lbClientesItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure FormResize(Sender: TObject);
  private
    procedure AddCliente(lb: TListBox; id_cliente: integer; nome,
      cidade: string);
    procedure ListarClientes;
    procedure ClickMenu(Sender: TObject);
    procedure TerminateThread(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses Frame.Cliente;

procedure TFrmPrincipal.ClickMenu(Sender: TObject); // btnMenu
var
    f: TFrameCliente;
    btn: TSpeedButton;
begin
    btn := Sender as TSpeedButton;
    //btn := TSpeedButton(Sender);


    // Capturar frame que contem o botao clicado...
    f := btn.Parent as TFrameCliente;
    //f := TFrameCliente(btn.Parent);

    f.lblNome.text := 'Teste de click...';
    //f.lblCidade.fontcolor := $FFC92721;
end;

procedure TFrmPrincipal.FormResize(Sender: TObject);
begin
    {
    if FrmPrincipal.Width > 600 then
        lbClientes.Columns := 2
    else
        lbClientes.Columns := 1;
    }

    lbClientes.Columns := Trunc(FrmPrincipal.Width / 300);
end;

procedure TFrmPrincipal.lbClientesItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
    showmessage('Clicou no cliente: ' + Item.Tag.ToString);
end;

procedure TFrmPrincipal.AddCliente(lb: TListBox;
                                   id_cliente: integer;
                                   nome, cidade: string);
var
    item: TListBoxItem;
    f: TFrameCliente;
begin
    // Item vazio na listbox...
    item := TListBoxItem.Create(nil);
    item.Text := '';
    item.Height := 65;
    item.Tag := id_cliente;
    item.Selectable := false;

    // Criar o frame...
    f := TFrameCliente.Create(item);
    f.Parent := item;
    f.Align := TAlignLayout.Client;
    f.lblNome.text := nome;
    f.lblCidade.text := cidade;
    f.btnMenu.onClick := ClickMenu;


    lb.AddObject(item);
end;

procedure TFrmPrincipal.btnExcluirClick(Sender: TObject);
begin
    lbClientes.Items.Delete(0);
end;

procedure TFrmPrincipal.btnLimparClick(Sender: TObject);
begin
    lbClientes.Items.Clear;
end;

procedure TFrmPrincipal.btnRefreshClick(Sender: TObject);
begin
    ListarClientes;
end;

procedure TFrmPrincipal.TerminateThread(Sender: TObject);
begin
    TLoading.Hide;
    lbClientes.EndUpdate;
    btnRefresh.Enabled := true;

    TThread.CreateAnonymousThread(procedure
    var
        i: integer;
        f: TFrameCliente;
    begin
        // Loop nos itens para baixar imagens...
        for i := 0 to lbClientes.Items.Count - 1 do
        begin
            // Busco a imagem no server... GET meuserver/clientes/foto
            sleep(500);

            TThread.Synchronize(TThread.CurrentThread, procedure
            begin
                //f := lbClientes.ItemByIndex(i).Children[0] as TFrameCliente;
                f := lbClientes.ItemByIndex(i).FindComponent('FrameCliente') as TFrameCliente;
                f.imgCliente.bitmap := imgCliente.Bitmap;
            end);

        end;
    end).Start;
end;

procedure TFrmPrincipal.ListarClientes;
var
    t: TThread;
begin
    TLoading.Show(FrmPrincipal, 'Buscando...');
    lbClientes.BeginUpdate;
    lbClientes.Items.Clear;
    btnRefresh.Enabled := false;

    t := TThread.CreateAnonymousThread(procedure
    begin
        // Select no banco... ou GET no servidor... (thread)
        sleep(500);


        TThread.Synchronize(TThread.CurrentThread, procedure
        var
            i: integer;
        begin
            for i := 1 to 5 do
            begin
                AddCliente(lbClientes, 1, '99 Coders', 'São Paulo');
                AddCliente(lbClientes, 2, 'Pão de Açúcar', 'São Paulo');
                AddCliente(lbClientes, 3, 'Walmart', 'Ribeirão Preto');
                AddCliente(lbClientes, 4, 'Supermercado Dia', 'Campinas');
            end;
        end);
    end);

    t.OnTerminate := TerminateThread;
    t.Start;
end;

end.
