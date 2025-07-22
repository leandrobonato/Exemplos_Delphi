unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FMX.Layouts, FMX.Ani, FMX.Edit, FMX.DateTimeCtrls;

type
  TFrmPrincipal = class(TForm)
    Rectangle1: TRectangle;
    Label2: TLabel;
    btnFiltro: TSpeedButton;
    Image3: TImage;
    lvPedido: TListView;
    lytFiltro: TLayout;
    rectFundo: TRectangle;
    rectMenu: TRectangle;
    imgFechar: TImage;
    Rectangle2: TRectangle;
    btnFiltrar: TSpeedButton;
    edtPedido: TEdit;
    edtCliente: TEdit;
    Layout1: TLayout;
    dtDe: TDateEdit;
    dtAte: TDateEdit;
    Layout2: TLayout;
    edtValorDe: TEdit;
    edtValorAte: TEdit;
    btnClear: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnFiltroClick(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    procedure AddPedido(id_pedido, cliente, dt_pedido: string; valor: double);
    procedure ListarPedido;
    procedure OpenMenu;
    procedure CloseMenu;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses UnitDM;

procedure TFrmPrincipal.AddPedido(id_pedido, cliente, dt_pedido: string;
                                  valor: double);
var
    item: TListViewItem;
begin
    try
        item := lvPedido.Items.Add;

        with item do
        begin
            Height := 90;
            TagString := id_pedido;

            // Num. Pedido...
            TListItemText(Objects.FindDrawable('txtPedido')).Text := id_pedido;

            // Cliente...
            TListItemText(Objects.FindDrawable('txtCliente')).Text := cliente;

            // Data Pedido...
            TListItemText(Objects.FindDrawable('txtData')).Text := dt_pedido;

            // Valor Pedido...
            TListItemText(Objects.FindDrawable('txtValor')).Text := FormatFloat('R$#,##0.00', valor);

        end;

    except on ex:exception do
        showmessage('Erro ao inserir pedido na lista: ' + ex.Message);
    end;
end;

procedure TFrmPrincipal.btnClearClick(Sender: TObject);
begin
    edtPedido.Text := '';
    edtCliente.Text := '';
    dtDe.IsEmpty := true;
    dtAte.IsEmpty := true;
    edtValorDe.Text := '';
    edtValorAte.Text := '';

    CloseMenu;
    ListarPedido;
end;

procedure TFrmPrincipal.btnFiltrarClick(Sender: TObject);
begin
    CloseMenu;
    ListarPedido;
end;

procedure TFrmPrincipal.btnFiltroClick(Sender: TObject);
begin
    OpenMenu;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
    lytFiltro.Visible := false;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
    ListarPedido;
end;

procedure TFrmPrincipal.imgFecharClick(Sender: TObject);
begin
    CloseMenu;
end;

procedure TFrmPrincipal.OpenMenu;
begin
    rectMenu.Margins.Bottom := -300;
    lytFiltro.Visible := true;

    TAnimator.AnimateFloat(rectMenu, 'Margins.Bottom', 0, 0.5,
                           TAnimationType.InOut,
                           TInterpolationType.Circular);
end;

procedure TFrmPrincipal.CloseMenu;
begin
    rectMenu.Margins.Bottom := 0;

    TAnimator.AnimateFloat(rectMenu, 'Margins.Bottom', -300, 0.5,
                           TAnimationType.InOut,
                           TInterpolationType.Circular);

    TThread.CreateAnonymousThread(procedure
    begin
        sleep(500);

        TThread.Synchronize(TThread.CurrentThread, procedure
        begin
            lytFiltro.Visible := false;
        end);

    end).Start;
end;

procedure TFrmPrincipal.ListarPedido;
var
    data_de, data_ate: TDate;
    vl_de, vl_ate: double;
begin
    try
        if dtDe.IsEmpty then
            data_de := 0
        else
            data_de := dtDe.Date;

        if dtAte.IsEmpty then
            data_ate := 0
        else
            data_ate := dtAte.Date;

        try
            vl_de := edtValorDe.Text.ToDouble;
        except
            vl_de := 0;
        end;

        try
            vl_ate := edtValorAte.Text.ToDouble;
        except
            vl_ate := 0;
        end;


        Dm.ListarPedidos(edtPedido.Text,
                         edtCliente.Text,
                         data_de,
                         data_ate,
                         vl_de,
                         vl_ate);

        lvPedido.BeginUpdate;
        lvPedido.Items.Clear;

        while NOT Dm.qryPedido.eof do
        begin
            AddPedido(Dm.qryPedido.fieldbyname('id_pedido').asstring,
                      Dm.qryPedido.fieldbyname('cliente').asstring,
                      FormatDateTime('dd/mm/yyyy', Dm.qryPedido.fieldbyname('dt_pedido').asdatetime),
                      Dm.qryPedido.fieldbyname('vl_total').asfloat);

            Dm.qryPedido.Next;
        end;

    except on ex:exception do
        showmessage('Erro ao consultar pedidos: ' + ex.Message);
    end;

    lvPedido.EndUpdate;
end;

end.
