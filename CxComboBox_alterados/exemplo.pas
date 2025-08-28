uses
  System.Generics.Collections;

type

  TcxComboBoxProperties_Alterados = class helper for TcxComboBoxProperties
  private
    class var FData: TObjectDictionary<TcxComboBoxProperties, TStrings>; // Armazena Valores e DisplayText
    class constructor Create;
    class destructor Destroy;

    function GetValores: TStrings;
    procedure SetValores(const Value: TStrings);
    function GetDisplayText: TStrings;
    procedure SetDisplayText(const Value: TStrings);

  public
    property Valores: TStrings read GetValores write SetValores;
    property DisplayText: TStrings read GetDisplayText write SetDisplayText;
  end;

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure DefinirListas;
  private
    FColunas: TDictionary<TcxGridDBColumn, TStrings>; // Armazena listas por coluna
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

constructor TForm1.Create(AOwner: TComponent);
begin
  inherited;
  FColunas := TDictionary<TcxGridDBColumn, TStrings>.Create;
end;

destructor TForm1.Destroy;
var
  Lista: TStrings;
begin
  for Lista in FColunas.Values do
    Lista.Free;
  FColunas.Free;
  inherited;
end;

procedure TForm1.DefinirListas;
var
  Descricoes, Valores: TStringList;
begin
  // Filtrar e obter as listas para ORIGEM_COMBUSTIVEL
  FiltrarListas('ORIGEM_COMBUSTIVEL');
  Descricoes := TStringList.Create;
  Valores := TStringList.Create;
  try
    Descricoes.Assign(RetornarDescricoesLista);
    Valores.Assign(RetornarValoresLista);

    // Armazenar as listas no dicionário
    FColunas.AddOrSetValue(cxColGridTVOrigemCombustivelColumn1, Descricoes);
    TcxComboBox(cxColGridTVOrigemCombustivelColumn1).DisplayText := Descricoes;
    TcxComboBox(cxColGridTVOrigemCombustivelColumn1).Valores := Valores;
  except
    Descricoes.Free;
    Valores.Free;
    raise;
  end;

  // Filtrar e obter as listas para TIPO_ARMAMENTOS
  FiltrarListas('TIPO_ARMAMENTOS');
  Descricoes := TStringList.Create;
  Valores := TStringList.Create;
  try
    Descricoes.Assign(RetornarDescricoesLista);
    Valores.Assign(RetornarValoresLista);

    // Armazenar as listas no dicionário
    FColunas.AddOrSetValue(cxGridDBColumn29, Descricoes);
    TcxComboBox(cxGridDBColumn29).DisplayText := Descricoes;
    TcxComboBox(cxGridDBColumn29).Valores := Valores;
  except
    Descricoes.Free;
    Valores.Free;
    raise;
  end;
end;

class constructor TcxComboBoxProperties_alterados.Create;
begin
  FData := TObjectDictionary<TcxComboBoxProperties, TStrings>.Create([doOwnsValues]);
end;

class destructor TcxComboBoxProperties_alterados.Destroy;
begin
  FData.Free;
end;

function TcxComboBoxProperties_alterados.GetValores: TStrings;
begin
  if not FData.ContainsKey(Self) then
    FData.Add(Self, TStringList.Create); // Cria uma nova lista se não existir
  Result := FData[Self];
end;

procedure TcxComboBoxProperties_alterados.SetValores(const Value: TStrings);
begin
  if not FData.ContainsKey(Self) then
    FData.Add(Self, TStringList.Create); // Cria uma nova lista se não existir
  FData[Self].Assign(Value);
end;

function TcxComboBoxProperties_alterados.GetDisplayText: TStrings;
begin
  if not FData.ContainsKey(Self) then
    FData.Add(Self, TStringList.Create); // Cria uma nova lista se não existir
  Result := FData[Self];
end;

procedure TcxComboBoxProperties_alterados.SetDisplayText(const Value: TStrings);
begin
  if not FData.ContainsKey(Self) then
    FData.Add(Self, TStringList.Create); // Cria uma nova lista se não existir
  FData[Self].Assign(Value);
end;