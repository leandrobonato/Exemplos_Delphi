unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Graphics;

type
  TFrmPrincipal = class(TForm)
    Rectangle1: TRectangle;
    Label1: TLabel;
    lv: TListView;
    Rectangle2: TRectangle;
    lblTotal: TLabel;
    imgUncheck: TImage;
    imgCheck: TImage;
    lblQtd: TLabel;
    btnExcluir: TSpeedButton;
    imgFundoAzul: TImage;
    imgFundoBranco: TImage;
    procedure FormShow(Sender: TObject);
    procedure lvItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure btnExcluirClick(Sender: TObject);
    procedure lvUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
  private
    procedure AddItem(cod_produto, descricao: string;
                                valor: double;
                                img: TBitmap);
    procedure ListarProdutos;
    procedure SetupItem(item: TListViewItem);
    procedure SelecionarItem(item: TListViewItem);
    procedure CalcularTotal;
    procedure ExcluirSelecionados;
    procedure SetupItem2(item: TListViewItem);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

procedure TFrmPrincipal.SetupItem(item: TListViewItem);
begin
    if item.Tag = 0 then
        TListItemImage(item.Objects.FindDrawable('imgCheckbox')).Bitmap := imgUncheck.Bitmap
    else
        TListItemImage(item.Objects.FindDrawable('imgCheckbox')).Bitmap := imgCheck.Bitmap;
end;

procedure TFrmPrincipal.SetupItem2(item: TListViewItem);
begin
    if item.Tag = 0 then
        TListItemImage(item.Objects.FindDrawable('imgCheckbox')).Bitmap := imgFundoBranco.Bitmap
    else
        TListItemImage(item.Objects.FindDrawable('imgCheckbox')).Bitmap := imgFundoAzul.Bitmap;

    TListItemImage(item.Objects.FindDrawable('imgCheckbox')).PlaceOffset.X := 0;
    TListItemImage(item.Objects.FindDrawable('imgCheckbox')).PlaceOffset.Y := 0;
    TListItemImage(item.Objects.FindDrawable('imgCheckbox')).Width := lv.Width;
    TListItemImage(item.Objects.FindDrawable('imgCheckbox')).Height := 60;
    TListItemImage(item.Objects.FindDrawable('imgCheckbox')).Opacity := 0.2;
end;

procedure TFrmPrincipal.ExcluirSelecionados;
var
    i: integer;
begin
    for i := lv.ItemCount - 1 downto 0 do
        if lv.Items[i].Tag > 0 then  // item selecionado...
        begin
            // Delete no banco...
            showmessage('Excluir o produto do banco: ' + lv.Items[i].TagString);

            lv.Items.Delete(i);
        end;
end;

procedure TFrmPrincipal.btnExcluirClick(Sender: TObject);
begin
    ExcluirSelecionados;
end;

procedure TFrmPrincipal.CalcularTotal;
var
    i, qtd: integer;
    total: double;
begin
    total := 0;
    qtd := 0;

    for i := 0 to lv.ItemCount - 1 do
        if lv.Items[i].Tag > 0 then  // item selecionado...
        begin
            total := total + TListItemText(lv.Items[i].Objects.FindDrawable('txtValor')).TagFloat;
            Inc(qtd);
        end;

    lblTotal.Text := FormatFloat('Total: R$ #,##0.00', total);

    if qtd > 1 then
        lblQtd.Text := FormatFloat('0 itens', qtd)
    else
        lblQtd.Text := FormatFloat('0 item', qtd);
end;

procedure TFrmPrincipal.SelecionarItem(item: TListViewItem);
begin
    if item.Tag = 0 then
        item.Tag := 1
    else
        item.Tag := 0;

    //SetupItem(item);
    SetupItem2(item);
    CalcularTotal;
end;

procedure TFrmPrincipal.AddItem(cod_produto, descricao: string;
                                valor: double;
                                img: TBitmap);
begin
    with lv.Items.Add do
    begin
        TagString := cod_produto;
        Tag := 0; // nao marcado...
        Height := 60;

        TListItemText(Objects.FindDrawable('txtDescricao')).Text := descricao;

        TListItemText(Objects.FindDrawable('txtValor')).Text := FormatFloat('#,##0.00', valor);
        TListItemText(Objects.FindDrawable('txtValor')).TagFloat := valor;

        TListItemImage(Objects.FindDrawable('imgCheckbox')).Bitmap := img;
    end;
end;

procedure TFrmPrincipal.ListarProdutos;
begin
    lv.BeginUpdate;
    lv.Items.Clear;

    {
    AddItem('001', 'Monitor Dell 22"', 550, imgUncheck.Bitmap);
    AddItem('002', 'Monitor LG', 620, imgUncheck.Bitmap);
    AddItem('003', 'Notebook Samsung', 3181, imgUncheck.Bitmap);
    AddItem('004', 'Notebook Acer', 2706, imgUncheck.Bitmap);
    AddItem('005', 'Notebook Lenovo', 1899, imgUncheck.Bitmap);
    AddItem('006', 'Impressora Epson', 975, imgUncheck.Bitmap);
    AddItem('007', 'Impressora HP', 325, imgUncheck.Bitmap);
    AddItem('008', 'Multifuncional Canon', 809, imgUncheck.Bitmap);
    AddItem('009', 'Gabinete Gamer', 195, imgUncheck.Bitmap);
    AddItem('010', 'HD SSD Kingston', 215, imgUncheck.Bitmap);
    AddItem('011', 'HD SSD Ceamere', 190, imgUncheck.Bitmap);
    AddItem('012', 'Teclado Gamer', 110, imgUncheck.Bitmap);
    AddItem('013', 'Haedset Bluetooth', 838, imgUncheck.Bitmap);
    AddItem('014', 'Mouse Movitec', 49.90, imgUncheck.Bitmap);
    AddItem('015', 'Mochila Notebook', 99.90, imgUncheck.Bitmap);
    }

    AddItem('001', 'Monitor Dell 22"', 550, imgFundoBranco.Bitmap);
    AddItem('002', 'Monitor LG', 620, imgFundoBranco.Bitmap);
    AddItem('003', 'Notebook Samsung', 3181, imgFundoBranco.Bitmap);
    AddItem('004', 'Notebook Acer', 2706, imgFundoBranco.Bitmap);
    AddItem('005', 'Notebook Lenovo', 1899, imgFundoBranco.Bitmap);
    AddItem('006', 'Impressora Epson', 975, imgFundoBranco.Bitmap);
    AddItem('007', 'Impressora HP', 325, imgFundoBranco.Bitmap);
    AddItem('008', 'Multifuncional Canon', 809, imgFundoBranco.Bitmap);
    AddItem('009', 'Gabinete Gamer', 195, imgFundoBranco.Bitmap);
    AddItem('010', 'HD SSD Kingston', 215, imgFundoBranco.Bitmap);
    AddItem('011', 'HD SSD Ceamere', 190, imgFundoBranco.Bitmap);
    AddItem('012', 'Teclado Gamer', 110, imgFundoBranco.Bitmap);
    AddItem('013', 'Haedset Bluetooth', 838, imgFundoBranco.Bitmap);
    AddItem('014', 'Mouse Movitec', 49.90, imgFundoBranco.Bitmap);
    AddItem('015', 'Mochila Notebook', 99.90, imgFundoBranco.Bitmap);


    lv.EndUpdate;
end;

procedure TFrmPrincipal.lvItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
    SelecionarItem(AItem);
end;

procedure TFrmPrincipal.lvUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
begin
    SetupItem2(AItem);
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
    ListarProdutos;
end;




end.
