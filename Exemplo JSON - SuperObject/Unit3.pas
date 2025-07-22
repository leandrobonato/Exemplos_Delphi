unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.DBCtrls, SuperObject, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractConnection,
  ZConnection, DBXJSON, Datasnap.DBClient, System.Generics.Collections
  , UNotaFiscal, Vcl.ComCtrls;

type
  TForm3 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    ts1: TTabSheet;
    btnSerializar: TButton;
    Memo1: TMemo;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    DataSource1: TDataSource;
    cds1: TClientDataSet;
    btnDesserializar: TButton;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    procedure btnDesserializarClick(Sender: TObject);
    procedure btnSerializarClick(Sender: TObject);
  private
    class function Serialize(notaFiscal: TNotaFiscal): ISuperObject;
//    procedure Desserializar(const AJSON: string; var ANotaFiscal: TNotaFiscal);
    class function Desserializar<T>(AText: string; AData: T): Boolean; static;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  vNotaFiscal: TNotaFiscal;

implementation

{$R *.dfm}

procedure TForm3.btnDesserializarClick(Sender: TObject);
var
  jsonString: string;
  jsonObj: ISuperObject;
  vnotaFiscal: TNotaFiscal;
  vItemNota: TItem;
  Pagamentos: TPagamento;
  ResponsavelTecnico: TResponsavelTecnico;
  ctx: TSuperRttiContext;
begin
  // Sua string JSON aqui
  jsonString := Memo1.Lines.Text;

  // Analisar a string JSON
  jsonObj := TSuperObject.ParseString(PWideChar(jsonString), True);

  // Verificar se o parsing foi bem-sucedido
  if Assigned(jsonObj) then
  begin
    // Criar um contexto Rtti
    ctx := TSuperRttiContext.Create;
    try
      // Criar uma instância de TNotaFiscal
      vNotaFiscal := TNotaFiscal.Create;   {
      vNotaFiscal.itens := TList<TItem>.Create();
      vNotaFiscal.pagamentos := TList<TPagamento>.Create();
      vNotaFiscal.responsavelTecnico  := TResponsavelTecnico.Create;
      vNotaFiscal.responsavelTecnico.telefone := TTelefone.Create;
      vNotaFiscal.destinatarioEndereco :=  TEndereco.Create;
      vItemNota := TItem.Create;
      vItemNota.tributos := TTributos.Create;
      vItemNota.tributos.icms := TICMS.Create;
      vItemNota.tributos.icms.baseCalculo := TBaseCalculo.Create;
      vItemNota.tributos.pis := TPISCOFINS.Create;
      vItemNota.tributos.pis.baseCalculo := TBaseCalculo.Create;
      vItemNota.tributos.cofins := TPISCOFINS.Create;
      vItemNota.tributos.cofins.baseCalculo := TBaseCalculo.Create;
      vItemNota.valorUnitario := TValorUnitario.Create;    }


      // Usar o construtor FromJson para preencher a instância com os dados do JSON
      vnotaFiscal.FromJson(jsonObj, ctx);

      // Agora você pode acessar os valores do objeto Delphi
      Memo2.Lines.Add('idIntegracao: ' + vnotaFiscal.idIntegracao);
      Memo2.Lines.Add('natureza: ' + vnotaFiscal.natureza);
      Memo2.Lines.Add('cpfCnpj: ' + vnotaFiscal.emitenteCpfCnpj);
    finally
      // Liberar o contexto Rtti
      ctx.Free;
    end;
  end;
end;

{procedure TForm3.btnDesserializarClick<T>(Sender: TObject);
var
  vNotaFiscal: TNotaFiscal;
  ItemNota: TItem;
  Pagamento: TPagamento;
  ctx      : TSuperRttiContext; //TSerialContext;
  I: Integer;
  Data: T;
begin
  ctx := SuperObject.TSuperRttiContext.Create;
  Data := ctx.AsType<T>(SO(Memo1.Lines.Text));

  vNotaFiscal.FromJson(Memo1.Lines.Text);

{  Desserializar(Memo1.Lines.Text, vNotaFiscal);
  Memo2.Lines.Add(vNotaFiscal.emitenteCpfCnpj);

  for ItemNota in vNotaFiscal.Itens do
  begin
    Memo2.Lines.Add('---------------------------------------');
    Memo2.Lines.Add('Código: ' + ItemNota.Codigo);
    Memo2.Lines.Add('Descrição: ' + ItemNota.Descricao);
    Memo2.Lines.Add('NCM: ' + ItemNota.NCM);
    Memo2.Lines.Add('CEST: ' + ItemNota.CEST);
    Memo2.Lines.Add('Valor Comercial: ' + FloatToStr(ItemNota.ValorUnitario.Comercial));
    Memo2.Lines.Add('Valor Tributável: ' + FloatToStr(ItemNota.ValorUnitario.Tributavel));
  end;

  for Pagamento in vNotaFiscal.Pagamentos do
  begin
    Memo2.Lines.Add('---------------------------------------');
    Memo2.Lines.Add('À vista: ' + BoolToStr(Pagamento.aVista, true));
    Memo2.Lines.Add('Meio: ' + Pagamento.meio);
    Memo2.Lines.Add('Valor: ' + FloatToStr(Pagamento.valor));
  end;
  Memo2.Lines.Add('=======================================');
end;  }

procedure TForm3.btnSerializarClick(Sender: TObject);
var
  vNotaFiscal: TNotaFiscal;
  vItemNota: TItem;
  vPagamento: TPagamento;
begin
  vNotaFiscal := TNotaFiscal.Create;
  vNotaFiscal.itens := TList<TItem>.Create();
  vNotaFiscal.pagamentos := TList<TPagamento>.Create();
  vNotaFiscal.responsavelTecnico  := TResponsavelTecnico.Create;
  vNotaFiscal.responsavelTecnico.telefone := TTelefone.Create;
  vNotaFiscal.destinatarioEndereco :=  TEndereco.Create;
  vItemNota := TItem.Create;
  vItemNota.tributos := TTributos.Create;
  vItemNota.tributos.icms := TICMS.Create;
  vItemNota.tributos.icms.baseCalculo := TBaseCalculoICMS.Create;
  vItemNota.tributos.pis := TPIS.Create;
  vItemNota.tributos.pis.baseCalculo := TBaseCalculoPIS.Create;
  vItemNota.tributos.cofins := TCOFINS.Create;
  vItemNota.tributos.cofins.baseCalculo := TBaseCalculoCOFINS.Create;
  vItemNota.valorUnitario := TValorUnitario.Create;

  vNotaFiscal.emitenteCpfCnpj := '08187168000160';

  vItemNota.codigo := '1';
  vItemNota.descricao := 'Teste 1';
  vItemNota.ncm := 'T1232312313';

  vItemNota.valorUnitario.comercial := 100.00;

  vItemNota.valor := 100.00;
  vNotaFiscal.itens.Add(vItemNota);

  vItemNota := TItem.Create;
  vItemNota.tributos := TTributos.Create;
  vItemNota.tributos.icms := TICMS.Create;
  vItemNota.tributos.icms.baseCalculo := TBaseCalculoICMS.Create;
  vItemNota.tributos.pis := TPIS.Create;
  vItemNota.tributos.pis.baseCalculo := TBaseCalculoPIS.Create;
  vItemNota.tributos.cofins := TCOFINS.Create;
  vItemNota.tributos.cofins.baseCalculo := TBaseCalculoCOFINS.Create;
  vItemNota.valorUnitario := TValorUnitario.Create;

  vItemNota.codigo := '2';
  vItemNota.descricao := 'Teste 2';
  vItemNota.ncm := 'T1232312313';

  vItemNota.valorUnitario := TValorUnitario.Create;
  vItemNota.valorUnitario.comercial := 200.00;

  vItemNota.valor := 200.00;
  vNotaFiscal.itens.Add(vItemNota);

  vPagamento := TPagamento.Create;
  vPagamento.aVista := true;
  vPagamento.meio := 'Dinheiro';
  vNotaFiscal.pagamentos.Add(vPagamento);

  Memo4.Lines.Add(vNotaFiscal.ToJson().AsJSon(True, false));

//  Memo4.Lines.Add(Serialize(vNotaFiscal).AsJSon(true, false));
end;
                  {
procedure TForm3.Desserializar(const AJSON: string; var ANotaFiscal: TNotaFiscal);
var
  JsonArray: TSuperArray;
  JsonObject: ISuperObject;
  JsonObjectAux: ISuperObject;
  ItemNota: TItem;
  Pagamento: TPagamento;
  vIdx: Integer;
  vIdxAux: Integer;
begin
  JsonArray := SO(AJson).AsArray;// TSuperArray.Parse(AJSON);

  try
    for vIdx := 0 to JsonArray.Length - 1 do
    begin
      JsonObject := JsonArray.O[vIdx];

      ANotaFiscal := TNotaFiscal.Create;
      ANotaFiscal.itens := TList<TItem>.Create();
      ANotaFiscal.pagamentos := TList<TPagamento>.Create();

      ANotaFiscal.idIntegracao := JsonObject.S['idIntegracao'];
      ANotaFiscal.presencial := JsonObject.B['presencial'];
      ANotaFiscal.consumidorFinal := JsonObject.B['consumidorFinal'];
      ANotaFiscal.natureza := JsonObject.S['natureza'];

      // Preencher dados do emitente
      ANotaFiscal.emitenteCpfCnpj := JsonObject.O['emitente'].S['cpfCnpj'];

      // Preencher dados do destinatário
      ANotaFiscal.destinatarioCpfCnpj := JsonObject.O['destinatario'].S['cpfCnpj'];
      ANotaFiscal.destinatarioRazaoSocial := JsonObject.O['destinatario'].S['razaoSocial'];
      ANotaFiscal.destinatarioEmail := JsonObject.O['destinatario'].S['email'];

      // Preencher dados do endereço do destinatário
      ANotaFiscal.destinatarioEndereco := TEndereco.Create;
      ANotaFiscal.destinatarioEndereco.tipoLogradouro := JsonObject.O['destinatario'].O['endereco'].S['tipoLogradouro'];
      ANotaFiscal.destinatarioEndereco.logradouro := JsonObject.O['destinatario'].O['endereco'].S['logradouro'];
      ANotaFiscal.destinatarioEndereco.numero := JsonObject.O['destinatario'].O['endereco'].S['numero'];
      ANotaFiscal.destinatarioEndereco.bairro := JsonObject.O['destinatario'].O['endereco'].S['bairro'];
      ANotaFiscal.destinatarioEndereco.codigoCidade := JsonObject.O['destinatario'].O['endereco'].S['codigoCidade'];
      ANotaFiscal.destinatarioEndereco.descricaoCidade := JsonObject.O['destinatario'].O['endereco'].S['descricaoCidade'];
      ANotaFiscal.destinatarioEndereco.estado := JsonObject.O['destinatario'].O['endereco'].S['estado'];
      ANotaFiscal.destinatarioEndereco.cep := JsonObject.O['destinatario'].O['endereco'].S['cep'];

      // Preencher itens
      for vIdxAux := 0 to JsonObject.A['itens'].Length -1 do
      begin
        JsonObjectAux := JsonObject.A['itens'].O[vIdxAux];
        ItemNota := TItem.Create;

        ItemNota.codigo := JsonObjectAux.S['codigo'];
        ItemNota.descricao := JsonObjectAux.S['descricao'];
        ItemNota.ncm := JsonObjectAux.S['ncm'];
        ItemNota.cest := JsonObjectAux.S['cest'];
        ItemNota.cfop := JsonObjectAux.S['cfop'];

        ItemNota.valorUnitario := TValorUnitario.Create;
        ItemNota.valorUnitario.comercial := JsonObjectAux.O['valorUnitario'].D['comercial'];
        ItemNota.valorUnitario.tributavel := JsonObjectAux.O['valorUnitario'].D['tributavel'];

        ItemNota.valor := JsonObjectAux.D['valor'];

        ItemNota.tributos := TTributos.Create;
        ItemNota.tributos.icms := TICMS.Create;
        ItemNota.tributos.icms.origem := JsonObjectAux.O['tributos'].O['icms'].S['origem'];
        ItemNota.tributos.icms.cst := JsonObjectAux.O['tributos'].O['icms'].S['cst'];
        ItemNota.tributos.icms.baseCalculo := TBaseCalculo.Create;
        ItemNota.tributos.icms.baseCalculo.modalidadeDeterminacao := JsonObjectAux.O['tributos'].O['icms'].O['baseCalculo'].I['modalidadeDeterminacao'];
        ItemNota.tributos.icms.baseCalculo.valor := JsonObjectAux.O['tributos'].O['icms'].O['baseCalculo'].D['valor'];
        ItemNota.tributos.icms.aliquota := JsonObjectAux.O['tributos'].O['icms'].D['aliquota'];
        ItemNota.tributos.icms.valor := JsonObjectAux.O['tributos'].O['icms'].D['valor'];

        ItemNota.tributos.pis := TPISCOFINS.Create;
        ItemNota.tributos.pis.cst := JsonObjectAux.O['tributos'].O['pis'].S['cst'];
        ItemNota.tributos.pis.baseCalculo := TBaseCalculo.Create;
        ItemNota.tributos.pis.baseCalculo.modalidadeDeterminacao := JsonObjectAux.O['tributos'].O['pis'].O['baseCalculo'].I['modalidadeDeterminacao'];
        ItemNota.tributos.pis.baseCalculo.valor := JsonObjectAux.O['tributos'].O['pis'].O['baseCalculo'].D['valor'];
        ItemNota.tributos.pis.aliquota := JsonObjectAux.O['tributos'].O['pis'].D['aliquota'];
        ItemNota.tributos.pis.valor := JsonObjectAux.O['tributos'].O['pis'].D['valor'];

        ItemNota.tributos.cofins := TPISCOFINS.Create;
        ItemNota.tributos.cofins.cst := JsonObjectAux.O['tributos'].O['cofins'].S['cst'];
        ItemNota.tributos.cofins.baseCalculo := TBaseCalculo.Create;
        ItemNota.tributos.cofins.baseCalculo.modalidadeDeterminacao := JsonObjectAux.O['tributos'].O['cofins'].O['baseCalculo'].I['modalidadeDeterminacao'];
        ItemNota.tributos.cofins.baseCalculo.valor := JsonObjectAux.O['tributos'].O['cofins'].O['baseCalculo'].D['valor'];
        ItemNota.tributos.cofins.aliquota := JsonObjectAux.O['tributos'].O['cofins'].D['aliquota'];
        ItemNota.tributos.cofins.valor := JsonObjectAux.O['tributos'].O['cofins'].D['valor'];
        ANotaFiscal.itens.Add(ItemNota);
      end;

      // Preencher pagamentos
      for vIdxAux := 0 to JsonObject.A['pagamentos'].Length -1 do
      begin
        JsonObjectAux := JsonObject.A['pagamentos'].O[vIdxAux];
        Pagamento := TPagamento.Create;
        Pagamento.aVista := JsonObjectAux.B['aVista'];
        Pagamento.meio := JsonObjectAux.S['meio'];
        Pagamento.valor := JsonObjectAux.D['valor'];
        ANotaFiscal.pagamentos.Add(Pagamento);
      end;

      // Preencher dados do responsável técnico
      ANotaFiscal.responsavelTecnico := TResponsavelTecnico.Create;
      ANotaFiscal.responsavelTecnico.cpfCnpj := JsonObject.O['responsavelTecnico'].S['cpfCnpj'];
      ANotaFiscal.responsavelTecnico.nome := JsonObject.O['responsavelTecnico'].S['nome'];
      ANotaFiscal.responsavelTecnico.email := JsonObject.O['responsavelTecnico'].S['email'];

      // Preencher dados do telefone do responsável técnico
      ANotaFiscal.responsavelTecnico.telefone := TTelefone.Create;
      ANotaFiscal.responsavelTecnico.telefone.ddd := JsonObject.O['responsavelTecnico'].O['telefone'].S['ddd'];
      ANotaFiscal.responsavelTecnico.telefone.numero := JsonObject.O['responsavelTecnico'].O['telefone'].S['numero'];
    end;
  finally
//    JsonArray.Free;
  end;
end;
      }

class function TForm3.Desserializar<T>(AText: string; AData: T): Boolean;
var
  ctx      : TSuperRttiContext;
  vSuperObject: ISuperObject;
begin

  ctx := SuperObject.TSuperRttiContext.Create;
  vNotaFiscal := TNotaFiscal.Create;
  Result := false;
  try
    vSuperObject := ctx.AsJson(AData, SO(AText));
    vNotaFiscal.FromJson(vSuperObject, ctx);
    Result := true;
  except on E: Exception do
    raise Exception.Create('Error Message' + #13#10 + E.Message);
  end;


end;


class function TForm3.Serialize(notaFiscal: TNotaFiscal): ISuperObject;
var
  ItemArray: ISuperObject;
  PagamentoArray: ISuperObject;
  Item: TItem;
  Pagamento: TPagamento;
  TributosObj: ISuperObject;
begin
  Result := SO;
  Result.S['idIntegracao'] := NotaFiscal.idIntegracao;
  Result.B['presencial'] := NotaFiscal.presencial;
  Result.B['consumidorFinal'] := NotaFiscal.consumidorFinal;
  Result.S['natureza'] := NotaFiscal.natureza;
  Result.S['emitenteCpfCnpj'] := NotaFiscal.emitenteCpfCnpj;
  Result.S['destinatarioCpfCnpj'] := NotaFiscal.destinatarioCpfCnpj;
  Result.S['destinatarioRazaoSocial'] := NotaFiscal.destinatarioRazaoSocial;
  Result.S['destinatarioEmail'] := NotaFiscal.destinatarioEmail;

  // Serializa o endereço
  Result.O['destinatarioEndereco'] := SO;
  Result.O['destinatarioEndereco'].S['tipoLogradouro'] := NotaFiscal.destinatarioEndereco.tipoLogradouro;
  Result.O['destinatarioEndereco'].S['logradouro'] := NotaFiscal.destinatarioEndereco.logradouro;
  Result.O['destinatarioEndereco'].S['numero'] := NotaFiscal.destinatarioEndereco.numero;
  Result.O['destinatarioEndereco'].S['bairro'] := NotaFiscal.destinatarioEndereco.bairro;
  Result.O['destinatarioEndereco'].S['codigoCidade'] := NotaFiscal.destinatarioEndereco.codigoCidade;
  Result.O['destinatarioEndereco'].S['descricaoCidade'] := NotaFiscal.destinatarioEndereco.descricaoCidade;
  Result.O['destinatarioEndereco'].S['estado'] := NotaFiscal.destinatarioEndereco.estado;
  Result.O['destinatarioEndereco'].S['cep'] := NotaFiscal.destinatarioEndereco.cep;

  // Serializa os itens
  ItemArray := SA([]);
  for Item in NotaFiscal.itens do
  begin
    TributosObj:= SO([
      'icms', SO([
        'origem', Item.tributos.icms.origem,
        'cst', Item.tributos.icms.cst,
        'baseCalculo', SO([
          'modalidadeDeterminacao', Item.tributos.icms.baseCalculo.modalidadeDeterminacao,
          'valor', Item.tributos.icms.baseCalculo.valor
        ]),
        'aliquota', Item.tributos.icms.aliquota,
        'valor', Item.tributos.icms.valor
      ]),
      'pis', SO([
        'cst', Item.tributos.pis.cst,
        'baseCalculo', SO([
          'valor', Item.tributos.pis.baseCalculo.valor,
          'quantidade', Item.tributos.pis.baseCalculo.quantidade
        ]),
        'aliquota', Item.tributos.pis.aliquota,
        'valor', Item.tributos.pis.valor
      ]),
      'cofins', SO([
        'cst', Item.tributos.cofins.cst,
        'baseCalculo', SO([
          'valor', Item.tributos.cofins.baseCalculo.valor
        ]),
        'aliquota', Item.tributos.cofins.aliquota,
        'valor', Item.tributos.cofins.valor
      ])
    ]);

    ItemArray.AsArray.Add(SO([
      'codigo', Item.codigo,
      'descricao', Item.descricao,
      'ncm', Item.ncm,
      'cest', Item.cest,
      'cfop', Item.cfop,
      'valorUnitario', SO([
        'comercial', Item.valorUnitario.comercial,
        'tributavel', Item.valorUnitario.tributavel
      ]),
      'valor', Item.valor,
      'tributos', TributosObj
    ]));
  end;
  Result.O['itens'] := ItemArray;

  // Serializa os pagamentos
  PagamentoArray := SA([]);
  for Pagamento in NotaFiscal.pagamentos do
  begin
    PagamentoArray.AsArray.Add(So([
      'aVista', Pagamento.aVista,
      'meio', Pagamento.meio,
      'valor', Pagamento.valor
    ]));
  end;
  Result.O['pagamentos'] := PagamentoArray;

  // Serializa o responsável técnico
  Result.O['responsavelTecnico'] := SO([
    'cpfCnpj', NotaFiscal.responsavelTecnico.cpfCnpj,
    'nome', NotaFiscal.responsavelTecnico.nome,
    'email', NotaFiscal.responsavelTecnico.email,
    'telefone', SO([
      'ddd', NotaFiscal.responsavelTecnico.telefone.ddd,
      'numero', NotaFiscal.responsavelTecnico.telefone.numero
    ])
  ]);


end;
end.
