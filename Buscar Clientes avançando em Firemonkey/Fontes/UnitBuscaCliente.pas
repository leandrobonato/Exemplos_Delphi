unit UnitBuscaCliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView, FMX.Edit,
  FireDAC.Comp.Client;

type
  TExecuteOnClose = procedure(id_cliente: integer; nome: string) of Object;
  //TBuscaCliente = procedure(busca: string) of Object;

  TFrmBuscaCliente = class(TForm)
    rectToolbar: TRectangle;
    Label2: TLabel;
    rectBusca: TRectangle;
    lvCliente: TListView;
    edtBusca: TEdit;
    btnBuscar: TSpeedButton;
    procedure btnBuscarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvClienteItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    FExecuteOnClose: TExecuteOnClose;
    procedure AddCliente(id_cliente: integer; nome: string);
    procedure ListarClientes(busca: string);
    procedure ListarBanco(busca: string);
    { Private declarations }
  public
    ExecuteOnClose: TExecuteOnClose;
    //BuscaCliente: TBuscaCliente;
    Qry: TFDQuery;
    //property ExecuteOnClose: TExecuteOnClose read FExecuteOnClose write FExecuteOnClose;
  end;

var
  FrmBuscaCliente: TFrmBuscaCliente;

implementation

{$R *.fmx}

procedure TFrmBuscaCliente.ListarBanco(busca: string);
begin
    with Qry do
    begin
        Active := false;
        SQL.Clear;
        SQL.Add('select id_cliente, nome from tab_cliente');
        SQL.Add('where id_cliente > 0');

        if busca <> '' then
        begin
            SQL.Add('and nome like :nome');
            ParamByName('nome').Value := '%' + busca + '%';
        end;

        SQL.Add('order by nome');
        Active := true;
    end;
end;

procedure TFrmBuscaCliente.AddCliente(id_cliente: integer; nome: string);
var
    item: TListViewItem;
begin
    try
        item := lvCliente.Items.Add;

        with item do
        begin
            Height := 50;
            Tag := id_cliente;
            TagString := nome;

            // Cliente...
            TListItemText(Objects.FindDrawable('txtCliente')).Text := nome;
        end;

    except on ex:exception do
        showmessage('Erro ao inserir cliente na lista: ' + ex.Message);
    end;
end;

procedure TFrmBuscaCliente.ListarClientes(busca: string);
begin
    try
        //Dm.ListarClientes(busca);
        //BuscaCliente(busca);
        ListarBanco(busca);

        lvCliente.BeginUpdate;
        lvCliente.Items.Clear;

        while NOT Qry.eof do
        begin
            AddCliente(Qry.fieldbyname('id_cliente').asinteger,
                       Qry.fieldbyname('nome').asstring);

            Qry.Next;
        end;

    except on ex:exception do
        showmessage('Erro ao buscar clientes: ' + ex.Message);
    end;

    lvCliente.EndUpdate;
end;

procedure TFrmBuscaCliente.lvClienteItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
    ExecuteOnClose(AItem.Tag, AItem.TagString);
    close;
end;

procedure TFrmBuscaCliente.btnBuscarClick(Sender: TObject);
begin
    ListarClientes(edtBusca.Text);
end;

procedure TFrmBuscaCliente.FormShow(Sender: TObject);
begin
    ListarClientes(edtBusca.Text);
end;

end.
