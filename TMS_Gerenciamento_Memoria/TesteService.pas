unit TesteService;

interface

uses
  System.Generics.Collections,
  XData.Server.Module,
  XData.Service.Common,
	Aurelius.Mapping.Attributes, Aurelius.Types.Proxy,
	Aurelius.Types.Blob, Aurelius.Types.Nullable,
  Aurelius.Validation,
  Aurelius.Validation.Attributes,
  Bcl.Json.Attributes;

type

  TCidade = class;

  TDtoSimples = class
  private
    FId: Integer;
    FNome: string;
  public
    property Id: Integer read FId write FId;
    property Nome: string read FNome write FNome;
  end;

  TDtoComposto = class
  private
    FId: Integer;
    FDtoSimples: TDtoSimples;
  public
    property Id: Integer read FId write FId;
    property DtoSimples: TDtoSimples read FDtoSimples write FDtoSimples;
  end;

  TDtoComLista = class
  private
    FNome: string;
    [JsonManaged]
    FLista: TList<TDtoSimples>;
    [JsonManaged]
    FLista2: TList<Integer>;
  public
    destructor Destroy; override;
    property Nome: string read FNome write FNome;
    property Lista: TList<TDtoSimples> read FLista write FLista;
    property Lista2: TList<Integer> read FLista2 write FLista2;
  end;

  [Entity, Automapping]
  [Table('uf')]
  [Id('FId', TIdGenerator.None)]
  TUf = class
  private
    [Column('id')]
    FId: Integer;
    [Column('Nome')]
    FNome: string;
    [ManyValuedAssociation([], CascadeTypeAllRemoveOrphan, 'FUf')]
    FCidades: Proxy<TList<TCidade>>;
  public
    constructor Create;
    destructor Destroy; override;
    property Id: Integer read FId write FId;
    property Nome: string read FNome write FNome;
    property Cidades: Proxy<TList<TCidade>> read FCidades write FCidades;
  end;

  [Entity, Automapping]
  [Table('cidade')]
  [Id('FId', TIdGenerator.None)]
  TCidade = class
  private
    [Column('id')]
    FId: Integer;
    [Column('nome')]
    FNome: string;
    [Association([TAssociationProp.Required], [])]
    [JoinColumn('uf_id', [])]
    FUf: TUf;
  public
    property Id: Integer read FId write FId;
    property Nome: string read FNome write FNome;
    property Uf: TUf read FUf write FUf;
  end;


  [ServiceContract]
  ITesteService = interface(IInvokable)
    ['{0F60E3BD-5E58-4F7A-95E5-D5E8ABF2071B}']

    [HttpGet]
    function DtoSimples: TDtoSimples;

    [HttpGet]
    function DtoSimplesList: TList<TDtoSimples>;

    [HttpGet]
    function DtoComposto: TDtoComposto;

    [HttpGet]
    function DtoComLista: TDtoComLista;

    [HttpGet]
    function Uf: TUf;

    procedure Salvar(Dto: TDtoSimples);
  end;

  [ServiceImplementation]
  TTesteService = class(TInterfacedObject, ITesteService)
  private
    function DtoSimples: TDtoSimples;
    function DtoComposto: TDtoComposto;
    function DtoSimplesList: TList<TDtoSimples>;
    function DtoComLista: TDtoComLista;
    function Uf: TUf;
    procedure Salvar(Dto: TDtoSimples);
  end;

implementation


function TTesteService.DtoComLista: TDtoComLista;
begin
  Result := TDtoComLista.Create;

  Result.Nome := 'DtoComLista';
  Result.Lista := TList<TDtoSimples>.Create;
  Result.Lista.Add(TDtoSimples.Create);
  Result.Lista.Add(TDtoSimples.Create);

  Result.Lista2 := TList<Integer>.Create;
  Result.Lista2.Add(1);
  Result.Lista2.Add(2);
end;

function TTesteService.DtoComposto: TDtoComposto;
begin
  Result := TDtoComposto.Create;
  Result.Id := 2;
  Result.DtoSimples := TDtoSimples.Create;
  Result.DtoSimples.Id := 1;
  Result.DtoSimples.Nome := 'Juca Bala';
end;

function TTesteService.DtoSimples: TDtoSimples;
begin
  Result := TDtoSimples.Create;
  Result.Id := 1;
  Result.Nome := 'Juca Bala';
end;

function TTesteService.DtoSimplesList: TList<TDtoSimples>;
begin
  Result := TList<TDtoSimples>.Create;
  Result.Add(TDtoSimples.Create);
  Result.Add(TDtoSimples.Create);
  Result.Add(TDtoSimples.Create);
end;

procedure TTesteService.Salvar(Dto: TDtoSimples);
begin
//
end;

function TTesteService.Uf: TUf;
begin
  Result := TXDataOperationContext.Current.GetManager.Find<TUf>(1);
end;

{ TUf }

constructor TUf.Create;
begin
  inherited;
  FCidades.SetInitialValue(TList<TCidade>.Create);
end;

destructor TUf.Destroy;
begin
  FCidades.DestroyValue;
  inherited;
end;

{ TDtoComLista }

destructor TDtoComLista.Destroy;
begin
  FLista.Free;
  FLista2.Free;
  inherited;
end;

initialization
  RegisterServiceType(TypeInfo(ITesteService));
  RegisterServiceType(TTesteService);

end.
