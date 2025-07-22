unit UNotaFiscal;

interface

uses
  System.Generics.Collections;

type
  TEndereco = class
  public
    tipoLogradouro: string;
    logradouro: string;
    numero: string;
    bairro: string;
    codigoCidade: string;
    descricaoCidade: string;
    estado: string;
    cep: string;
  end;

  TValorUnitario = class
  public
    comercial: Double;
    tributavel: Double;
  end;

  TBaseCalculoICMS = class
  public
    modalidadeDeterminacao: Integer;
    valor: Double;
  end;

  TBaseCalculoPIS = class
  public
    valor: Double;
    quantidade: Double;
  end;

  TBaseCalculoCOFINS = class
  public
    valor: Double;
  end;

  TICMS = class
  public
    origem: string;
    cst: string;
    baseCalculo: TBaseCalculoICMS;
    aliquota: Double;
    valor: Double;
  end;

  TPIS = class
  public
    cst: string;
    baseCalculo: TBaseCalculoPIS;
    aliquota: Double;
    valor: Double;
  end;

  TCOFINS = class
  public
    cst: string;
    baseCalculo: TBaseCalculoCOFINS;
    aliquota: Double;
    valor: Double;
  end;

  TTributos = class
  public
    icms: TICMS;
    pis: TPIS;
    cofins: TCOFINS;
  end;

  TItem = class
  public
    codigo: string;
    descricao: string;
    ncm: string;
    cest: string;
    cfop: string;
    valorUnitario: TValorUnitario;
    valor: Double;
    tributos: TTributos;
  end;

  TTelefone = class
  public
    ddd: string;
    numero: string;
  end;

  TResponsavelTecnico = class
  public
    cpfCnpj: string;
    nome: string;
    email: string;
    telefone: TTelefone;
  end;

  TPagamento = class
  public
    aVista: Boolean;
    meio: string;
    valor: Double;
  end;

  TNotaFiscal = class
  public
    idIntegracao: string;
    presencial: Boolean;
    consumidorFinal: Boolean;
    natureza: string;
    emitenteCpfCnpj: string;
    destinatarioCpfCnpj: string;
    destinatarioRazaoSocial: string;
    destinatarioEmail: string;
    destinatarioEndereco: TEndereco;
    itens: TList<TItem>;
    pagamentos: TList<TPagamento>;
    responsavelTecnico: TResponsavelTecnico;
  end;

implementation

end.

