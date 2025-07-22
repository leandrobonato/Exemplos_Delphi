unit UnitPedido;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects;

type
  TFrmPedido = class(TForm)
    rectToolbar: TRectangle;
    Label2: TLabel;
    rectCliente: TRectangle;
    Label1: TLabel;
    lblCliente: TLabel;
    Image1: TImage;
    Rectangle1: TRectangle;
    Label4: TLabel;
    Label5: TLabel;
    Image2: TImage;
    Rectangle2: TRectangle;
    Label6: TLabel;
    Label7: TLabel;
    Image3: TImage;
    procedure rectClienteClick(Sender: TObject);
  private
    procedure SelecionarCliente(id_cliente: integer; nome: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPedido: TFrmPedido;

implementation

{$R *.fmx}

uses UnitBuscaCliente, UnitDM;

procedure TFrmPedido.SelecionarCliente(id_cliente: integer; nome: string);
begin
    lblCliente.Text := nome;
    lblCliente.Tag := id_cliente;
end;

procedure TFrmPedido.rectClienteClick(Sender: TObject);
begin
    if NOT Assigned(FrmBuscaCliente) then
        Application.CreateForm(TFrmBuscaCliente, FrmBuscaCliente);

    //FrmBuscaCliente.BuscaCliente := Dm.ListarClientes;
    FrmBuscaCliente.Qry := Dm.qryCliente;
    FrmBuscaCliente.ExecuteOnClose := SelecionarCliente;
    FrmBuscaCliente.show;
end;

end.
