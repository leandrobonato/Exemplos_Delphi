unit EnumHelper;

interface

uses
  System.SysUtils, System.Rtti, Vcl.Dialogs, System.TypInfo, System.SysConst,
  System.Classes, System.Math, Generics.Collections, System.Generics.Defaults;

type

  TSearchType = (stCod, stDesc, stEnum);

  EEnumResultException = class(Exception);
  EEnumHelperException = class(Exception);

  TEnumResult<T> = record
  private
    FEnum: Integer;
  public
    Codigo: String;
    Descricao: String;
    Arg: Integer;
    ImageIndex: Integer;
    function Enum: T;
    function ArgAsType<U>: U;
  end;

  TEnumAttribute = class(TCustomAttribute)
  protected
    Codigo: String;
    Descricao: String;
    Arg: Integer;
    ImageIndex: Integer;
  public
    constructor Create(pCodigo: string; pDescricao: string; pArg: Integer = -1;
      pImageIndex: Integer = -1); overload;
  end;

  TEnumUtils<T> = class
  private
    class function Get(pSearchType: TSearchType; pValue: TValue): TEnumResult<T>;
    class function EnumTypeInfo: PTypeInfo;
    class function EnumTypeData: PTypeData;
  public
    class function GetByCod(pCodigo: string): TEnumResult<T>;
    class function GetByDescricao(pDescricao: string): TEnumResult<T>;
    class function GetByEnum(pEnum: T): TEnumResult<T>;

    class procedure Fill(pComponent: TStrings); overload;
    class procedure Fill(pComponent: TStrings; const pSet: array of T); overload;

    class procedure Fill(pComponent: TCollection); overload;
    class procedure Fill(pComponent: TCollection; const pSet: array of T); overload;

  end;

implementation

uses
  cxCheckBox, cxRadioGroup, cxImageComboBox;

{ TEnumAttribute }

constructor TEnumAttribute.Create(pCodigo: string; pDescricao: string; pArg: Integer;
  pImageIndex: Integer);
begin
  Codigo := pCodigo;
  Descricao := pDescricao;
  Arg := pArg;
  ImageIndex := pImageIndex;
end;

{ TEnumUtils }

class procedure TEnumUtils<T>.Fill(pComponent: TStrings);
begin
  Fill(pComponent, []);
end;

class procedure TEnumUtils<T>.Fill(pComponent: TCollection);
begin
  Fill(pComponent, []);
end;

class procedure TEnumUtils<T>.Fill(pComponent: TStrings; const pSet: array of T);
var
  LData: PTypeData;
  Idx, I: Integer;
  bAdd: Boolean;
  aValue: T;
begin
  pComponent.Clear;
  LData := GetTypeData(EnumTypeInfo);

  for I := LData.MinValue to LData.MaxValue do
  begin
    bAdd := True;
    Move(I, aValue, SizeOf(aValue));
    if Length(pSet) > 0 then
      bAdd := TArray.BinarySearch<T>(pSet, aValue, Idx);
    if bAdd then
      pComponent.Add(TEnumUtils<T>.GetByEnum(aValue).Descricao);
  end;

end;

class procedure TEnumUtils<T>.Fill(pComponent: TCollection;
  const pSet: array of T);
var
  LData: PTypeData;
  Idx, I: Integer;
  bAdd: Boolean;
  aValue: T;
  Result: TEnumResult<T>;
begin
  LData := GetTypeData(EnumTypeInfo);

  if pComponent is TcxImageComboBoxItems then
    (pComponent as TcxImageComboBoxItems).Clear
  else if pComponent is TcxRadioGroupItems then
    (pComponent as TcxRadioGroupItems).Clear
  else
    raise EEnumHelperException.Create(Format('Classe %s não suportada!',[pComponent.ClassType.ClassName]));

  for I := LData.MinValue to LData.MaxValue do
  begin
    bAdd := True;
    Move(I, aValue, SizeOf(aValue));
    if Length(pSet) > 0 then
      bAdd := TArray.BinarySearch<T>(pSet, aValue, Idx);
    if bAdd then
    begin
      Result := TEnumUtils<T>.GetByEnum(aValue);

      if pComponent is TcxImageComboBoxItems then
        with (pComponent as TcxImageComboBoxItems).Add do
        begin
          Description := Result.Descricao;
          Value := Result.Codigo;
          if Result.ImageIndex > -1 then
            ImageIndex := Result.ImageIndex;
        end
      else if pComponent is TcxCaptionItems then
        with (pComponent as TcxRadioGroupItems).Add do
        begin
          Caption := Result.Descricao;
          Value := Result.Codigo;
        end;
    end;
  end;
end;

class function TEnumUtils<T>.Get(pSearchType: TSearchType; pValue: TValue): TEnumResult<T>;
var
  C: TRttiContext;
  LType: TRttiType;
  LAttr: TCustomAttribute;
  LData: PTypeData;
  sCompare: string;
  I: Integer;
  aValue: T;
begin
  Result := Default(TEnumResult<T>);
  Result.FEnum := -1;
  I := -1;
  C := TRttiContext.Create;
  try
    LType := C.GetType(EnumTypeInfo);
    LData := GetTypeData(EnumTypeInfo);
//    for I := LData.MinValue to LData.MaxValue do
//    begin
//      Move(I, aValue, SizeOf(aValue));

    for LAttr in LType.GetAttributes() do
    begin
      Inc(I);
      if LAttr is TEnumAttribute then
      begin
        case pSearchType of
          stCod: sCompare := TEnumAttribute(LAttr).Codigo;
          stDesc: sCompare := TEnumAttribute(LAttr).Descricao;
          stEnum: sCompare := GetEnumName(EnumTypeInfo, I);
        end;
        if pValue.AsString = sCompare then
        begin
          Result.Codigo := TEnumAttribute(LAttr).Codigo;
          Result.Descricao := TEnumAttribute(LAttr).Descricao;
          Result.Arg := TEnumAttribute(LAttr).Arg;
          Result.ImageIndex := TEnumAttribute(LAttr).ImageIndex;
          Result.FEnum := I;
          Break;
        end;
      end;
    end;
    if not InRange(Result.FEnum, LData.MinValue, LData.MaxValue) then
      raise EEnumHelperException.Create('Valor não suportado para o tipo enumerado!');
  finally
    C.Free;
  end;
end;

class function TEnumUtils<T>.GetByCod(pCodigo: string): TEnumResult<T>;
begin
  Result := Get(stCod, TValue.FromVariant(pCodigo));
end;

class function TEnumUtils<T>.GetByDescricao(pDescricao: string): TEnumResult<T>;
begin
  Result := Get(stDesc, TValue.FromVariant(pDescricao));
end;

class function TEnumUtils<T>.GetByEnum(pEnum: T): TEnumResult<T>;
begin
  Result := Get(stEnum, TRttiEnumerationType.GetName<T>(pEnum));
end;

class function TEnumUtils<T>.EnumTypeData: PTypeData;
begin
  Result := System.TypInfo.GetTypeData(EnumTypeInfo);
end;

class function TEnumUtils<T>.EnumTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(T);
end;

{ TEnumResult }

function TEnumResult<T>.ArgAsType<U>: U;
var
  typeInf: PTypeInfo;
begin
  typeInf := PTypeInfo(TypeInfo(U));

  if typeInf^.Kind <> tkEnumeration then
    raise EEnumResultException.CreateRes(@SInvalidCast);

  case GetTypeData(typeInf)^.OrdType of
    otUByte, otSByte:
      PByte(@Result)^ := Arg;
    otUWord, otSWord:
      PWord(@Result)^ := Arg;
    otULong, otSLong:
      PInteger(@Result)^ := Arg;
  else
    raise EEnumResultException.CreateRes(@SInvalidCast);
  end;
end;

function TEnumResult<T>.Enum: T;
begin
  Move(FEnum, Result, SizeOf(Result));
end;

end.
