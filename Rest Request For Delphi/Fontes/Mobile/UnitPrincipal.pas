unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, FMX.Objects,

  RESTRequest4D, DataSet.Serialize.Adapter.RESTRequest4D, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFrmPrincipal = class(TForm)
    edtCodigo: TEdit;
    EdtCidade: TEdit;
    EdtNome: TEdit;
    EdtUF: TEdit;
    Rectangle1: TRectangle;
    btnConsultar: TSpeedButton;
    TbCliente: TFDMemTable;
    procedure btnConsultarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

procedure TFrmPrincipal.btnConsultarClick(Sender: TObject);
var
    response: IResponse;
begin
    try
        response := TRequest.New.BaseURL('http://localhost:3001')
                    .Resource('/clientes')
                    .Accept('application/json')
                    .Adapters(TDataSetSerializeAdapter.New(TbCliente))
                    //.DataSetAdapter(TbCliente) --> versao antiga do RestRequest4D
                    .Get;

        if response.StatusCode <> 200 then
            showmessage('Erro ao consultar dados: ' + response.Content)
        else
        begin
            edtCodigo.Text := TbCliente.FieldByName('idcliente').AsString;
            edtNome.Text := TbCliente.FieldByName('nome').AsString;
            edtCidade.Text := TbCliente.FieldByName('cidade').AsString;
            edtUF.Text := TbCliente.FieldByName('uf').AsString;
        end;
    except
        showmessage('API não disponível no momento');
    end;
end;

end.
