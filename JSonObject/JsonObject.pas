unit JsonObject;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSON, Vcl.StdCtrls;


type
  TNullableString = class
  private
    FValue: string;
  public
    constructor Create(const AValue: string);
    property Value: string read FValue write FValue;
    function IsNull: Boolean;
  end;


type

  TTributacao = class
  private
    Fncm: string;
    Funidade: string;
    Fcst: string;
    Faliqpis: Integer;
    Faliqcofins: Integer;
    Fcsosn: string;
  public
    property ncm: string read Fncm write Fncm;
    property unidade: string read Funidade write Funidade;
    property csosn: string read Fcsosn write Fcsosn;
    property cst: string read Fcst write Fcst;
    property aliqpis: Integer read Faliqpis write Faliqpis;
    property aliqcofins: Integer read Faliqcofins write Faliqcofins;
  end;

  TCaracteristicas = class

  end;

  TGravacao = class

  end;

  TItemPedido = class
  private
    Fid_variacao: string;
    Fdescricao_curta: string;
    Fpeso: string;
    Fvalor: string;
    Fqtde: string;
    Fvar2: string;
    Fvar3: string;
    Fvar1: string;
    Ftributacao: TArray<TTributacao>;
    Fvar4: string;
    Fvar5: string;
    Freferencia: string;
    Fean: string;
    Fcusto: string;
    Fobservacoes: string;
    FGravacao: TArray<TGravacao>;
    Fcaracteristicas: TArray<TCaracteristicas>;
  public
    property id_variacao: string read Fid_variacao write Fid_variacao;
    property referencia: string read Freferencia write Freferencia;
    property var1: string read Fvar1 write Fvar1;
    property var2: string read Fvar2 write Fvar2;
    property var3: string read Fvar3 write Fvar3;
    property var4: string read Fvar4 write Fvar4;
    property var5: string read Fvar5 write Fvar5;
    property qtde: string read Fqtde write Fqtde;
    property observacoes: string read Fobservacoes write Fobservacoes;
    property valor: string read Fvalor write Fvalor;
    property custo: string read Fcusto write Fcusto;
    property peso: string read Fpeso write Fpeso;
    property ean: string read Fean write Fean;
    property descricao_curta: string read Fdescricao_curta write Fdescricao_curta;
    property tributacao: TArray<TTributacao> read Ftributacao write Ftributacao;
    property caracteristicas: TArray<TCaracteristicas> read Fcaracteristicas write Fcaracteristicas;
    property gravacao: TArray<TGravacao> read FGravacao write FGravacao;
  end;

  TPagamento = class
  private
    Fvalor_a_pagar: string;
    Fdata_do_pagamento: string;
    Fvalor_pago: string;
    Fsituacao: string;
    Fparcelas: string;
    Ftipo: string;
    Fvalor_desconto: string;
  public
    property data_do_pagamento: string read Fdata_do_pagamento write Fdata_do_pagamento;
    property valor_a_pagar: string read Fvalor_a_pagar write Fvalor_a_pagar;
    property valor_pago: string read Fvalor_pago write Fvalor_pago;
    property valor_desconto: string read Fvalor_desconto write Fvalor_desconto;
    property parcelas: string read Fparcelas write Fparcelas;
    property situacao: string read Fsituacao write Fsituacao;
    property tipo: string read Ftipo write Ftipo;
  end;

  TDistribuidor = class
  private
    Femail: String;
    Fcodigo: Integer;
    Fid: String;
    Fcomissao: REal;
    Fnome: String;
  published
    property id: String read Fid write Fid;
    property nome: String read Fnome write Fnome;
    property codigo: Integer read Fcodigo write Fcodigo;
    property email: String read Femail write Femail;
    property comissao: REal read Fcomissao write Fcomissao;
  end;

  TPedido = class
  private
    Fcodigo_ibge: string;
    Fcs_numero: string;
    Fbairro: string;
    Femail: string;
    Fvalor_desconto_progressivo: string;
    Fvalor_a_pagar: string;
    Festado_sigla: string;
    Frazao_social: string;
    Fitens: TArray<TItemPedido>;
    Fpagamentos: TArray<TPagamento>;
    Fid_pedido: string;
    Ffrete_tipo: string;
    Fdistribuidor: TArray<TDistribuidor>;
    Fcep: string;
    Fnumero: string;
    Fie: string;
    Fcs_tipo: string;
    Fvalor_produtos: string;
    Fnome_fantasia: string;
    Fvalor_descontos: string;
    Fvalor_frete: string;
    Fid_publico: string;
    Fsituacao: string;
    Fcomplemento: string;
    Fdata_atualizacao: string;
    Ffrete_descricao: string;
    Fdata_pedido: string;
    Fnome: string;
    Fcidade: string;
    Fendereco: string;
    Festado: string;
    Ftelefone: string;
    Fobservacoes: string;
    Fcelular: string;
  public
    property id_pedido: string read Fid_pedido write Fid_pedido;
    property id_publico: string read Fid_publico write Fid_publico;
    property nome: string read Fnome write Fnome;
    property nome_fantasia: string read Fnome_fantasia write Fnome_fantasia;
    property razao_social: string read Frazao_social write Frazao_social;
    property email: string read Femail write Femail;
    property cs_tipo: string read Fcs_tipo write Fcs_tipo;
    property cs_numero: string read Fcs_numero write Fcs_numero;
    property ie: string read Fie write Fie;
    property telefone: string read Ftelefone write Ftelefone;
    property celular: string read Fcelular write Fcelular;
    property endereco: string read Fendereco write Fendereco;
    property numero: string read Fnumero write Fnumero;
    property bairro: string read Fbairro write Fbairro;
    property complemento: string read Fcomplemento write Fcomplemento;
    property cep: string read Fcep write Fcep;
    property cidade: string read Fcidade write Fcidade;
    property codigo_ibge: string read Fcodigo_ibge write Fcodigo_ibge;
    property estado: string read Festado write Festado;
    property estado_sigla: string read Festado_sigla write Festado_sigla;
    property data_pedido: string read Fdata_pedido write Fdata_pedido;
    property valor_produtos: string read Fvalor_produtos write Fvalor_produtos;
    property valor_frete: string read Fvalor_frete write Fvalor_frete;
    property valor_descontos: string read Fvalor_descontos write Fvalor_descontos;
    property valor_desconto_progressivo: string read Fvalor_desconto_progressivo write Fvalor_desconto_progressivo;
    property frete_tipo: string read Ffrete_tipo write Ffrete_tipo;
    property frete_descricao: string read Ffrete_descricao write Ffrete_descricao;
    property situacao: string read Fsituacao write Fsituacao;
    property observacoes: string read Fobservacoes write Fobservacoes;
    property data_atualizacao: string read Fdata_atualizacao write Fdata_atualizacao;
    property distribuidor: TArray<TDistribuidor> read Fdistribuidor write Fdistribuidor;
    property itens: TArray<TItemPedido> read Fitens write Fitens;
    property valor_a_pagar: string read Fvalor_a_pagar write Fvalor_a_pagar;
    property pagamentos: TArray<TPagamento> read Fpagamentos write Fpagamentos;
  end;

  TDados = class
  private
    FDados: TArray<TPedido>;
    FData: TDateTime;
  public
    property Data: TDateTime read FData write FData;
    property Dados: TArray<TPedido> read FDados write FDados;
  end;


type
  TForm2 = class(TForm)
    btn1: TSpeedButton;
    rest: TRESTClient;
    request: TRESTRequest;
    response: TRESTResponse;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses
  REST.JSON, Winapi.Windows;

{$R *.dfm}

procedure TForm2.btn1Click(Sender: TObject);
var
  lJSONObject: TJSONObject;
  lJSONSituacoes: TJSONArray;
  i, i2: Integer;
  memo: TMemo;
  Pedidos: TDados;
begin
  lJSONObject := TJSONObject.Create;
  lJSONSituacoes := TJSONArray.Create;
  memo:= TMemo.Create(self);
  try
    lJSONObject.AddPair('versao', '1.0');
    lJSONObject.AddPair('chave', '32ad2043c967917e7a765b7e96bef126');///'ba5e476d0d49ef12358be860d5d32946'
    lJSONSituacoes.Add('pagamento_confirmado');
    lJSONObject.AddPair('situacoes', lJSONSituacoes);
    lJSONObject.AddPair('data', FormatDateTime('yyyy-mm-dd hh:mm:ss', Trunc(now) - 1));

    rest.BaseURL := 'https://api.emacro.com.br/nfe/listar';
    request.AddBody(lJSONObject);
    request.Execute;

    memo.Text := response.JSONText;
    memo.Lines.SaveToFile(ExtractFileDir(Application.ExeName) + '\JSON.txt');

    Pedidos := TJson.JsonToObject<TDados>(response.JSONText,
      [joIgnoreEmptyStrings, joIgnoreEmptyArrays]);

    for I := Low(Pedidos.Dados) to High(Pedidos.Dados) -1 do
    begin
      ShowMessage(Pedidos.Dados[I].Fid_pedido);
    end;

//    retorno:= TJson.JsonToObject<TRootClass>(response.JSONText);
  finally

  end;
end;

{ TNullableString }

constructor TNullableString.Create(const AValue: string);
begin
  FValue := AValue;

end;

function TNullableString.IsNull: Boolean;
begin
  Result := FValue = '';

end;

end.
