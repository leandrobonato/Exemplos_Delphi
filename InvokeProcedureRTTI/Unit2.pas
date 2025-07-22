unit Unit2;

interface

uses

  System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, System.Rtti, Vcl.Buttons, System.SysUtils, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxButtonEdit,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, Data.Bind.GenData, Data.Bind.Components,
  Data.Bind.ObjectScope, Datasnap.DBClient;

type
  TProcedures = record
    vArrValues: Array of TValue;
    procedure Valor1(AValor: String);
    procedure Valor2(AValor: String; AValor2: String);
    procedure Valor3(AValor: String; AValor2: String; AValor3: String);
    function Soma(AValor1: Integer; AValor2: Integer): Integer;
  end;

  TForm2 = class(TForm)
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    btnTesteLeandro: TBitBtn;
    GridTVGrid1DBTableView1: TcxGridDBTableView;
    gridLVGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxColumnTeste: TcxGridDBColumn;
    ds1: TDataSource;
    cds1: TClientDataSet;
    strngfldcds1TESTE: TStringField;
    prtypbndsrc1: TPrototypeBindSource;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btnTesteLeandroClick(Sender: TObject);
    procedure cxGridTVGrid1DBTableView1Column1PropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function retorarValoresParametros(ASender: TObject): TProcedures.vArrValues;
  public
    { Public declarations }
    procedure ExecuteProcedures(AProcedureName: String; AArrParamValues: System.TArray<TValue>);
    function ExecutaFunctions(AProcedureName: String; AArrParamValues: System.TArray<TValue>): Variant;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

function TProcedures.Soma(AValor1, AValor2: Integer): Integer;
begin
  Result := AValor1 + AValor2;
end;

procedure TProcedures.Valor1(AValor: String);
begin
  ShowMessage('Procedure Valor 1: ' + AValor);
end;

procedure TProcedures.Valor2(AValor: String; AValor2: String);
begin
  ShowMessage('Procedure Valor 2: ' + AValor + ' Valor 2: ' + AValor2);
end;

procedure TProcedures.Valor3(AValor: String; AValor2: String; AValor3: String);
begin
  ShowMessage('Procedure Valor 3: ' + AValor + ' Valor 2: ' + AValor2 + ' Valor 3: ' + AValor3);
end;

procedure TForm2.btn1Click(Sender: TObject);
var
  vRecord: TArray<TValue>;
begin
  SetLength(vRecord, 1);
  vRecord[0] := edt1.Text;
  ExecutaFunctions('Valor1', vRecord);
end;

procedure TForm2.btn2Click(Sender: TObject);
var
  vRecord: TArray<TValue>;
begin
  SetLength(vRecord, 2);
  vRecord[0] := edt1.Text;
  vRecord[1] := edt2.Text;
  ExecutaFunctions('Valor2', vRecord);
end;

procedure TForm2.btn3Click(Sender: TObject);
var
  vRecord: TArray<TValue>;
begin
  SetLength(vRecord, 3);
  vRecord[0] := edt1.Text;
  vRecord[1] := edt2.Text;
  vRecord[2] := edt3.Text;
  ExecutaFunctions('Valor3', vRecord);
end;

function TForm2.retorarValoresParametros(ASender: TObject): TProcedures.vArrValues;
var
  vTexto1: String;
  vTexto2: String;
  vTexto3: String;
begin
  case Sender.name of

  end;
  SetLength(Result, 1);
  SetLength(Result, 2);
  SetLength(Result, 3);
  SetLength(Result, 2);
end;

procedure TForm2.btnTesteLeandroClick(Sender: TObject);

  function PreencheRecord: TArray<TValue>;
  var
    I: Integer;
  begin

    for I := 0 to Length(vProcedures.vArrValues) - 1 do
      Result[I] := vProcedures.vArrValues[I];
  end;
begin
  ShowMessage(StringReplace(TComponent(Sender).name, 'btn', '', [rfReplaceAll]));
  ShowMessage(ExecutaFunctions('Soma', PreencheRecord([StrToInt(edt1.Text), StrToInt(edt2.Text)])));
end;

procedure TForm2.cxGridTVGrid1DBTableView1Column1PropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  ShowMessage(TCxGridDBColumn(TcxGridDBTableView(TCxButtonEdit(Sender).Owner).Controller.FocusedColumn).Name);
end;

procedure TForm2.ExecuteProcedures(AProcedureName: String; AArrParamValues: System.TArray<TValue>);
var
  vContext: TRttiContext;
  vType: TRttiType;
  vMethod: TRttiMethod;
  vProcedures: TProcedures;
begin
  vContext := TRttiContext.Create;
  vType := vContext.GetType(TypeInfo(TProcedures));
  vMethod := vType.GetMethod(AProcedureName);
  vMethod.Invoke(TValue.From<Pointer>(@vProcedures), AArrParamValues);
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  cds1.Close;
  cds1.Open;

  prtypbndsrc1.First;
  while not prtypbndsrc1.Eof do
  begin
    cds1.Insert;
    strngfldcds1TESTE.AsString := prtypbndsrc1.FieldDefs[0].DisplayName;
    cds1.Post;
    prtypbndsrc1.Next;
  end;
end;

Function TForm2.ExecutaFunctions(AProcedureName: String; AArrParamValues: System.TArray<TValue>): Variant;
var
  vContext: TRttiContext;
  vType: TRttiType;
  vMethod: TRttiMethod;
  vProcedures: TProcedures;
begin
  vContext := TRttiContext.Create;
  vType := vContext.GetType(TypeInfo(TProcedures));
  vMethod := vType.GetMethod(AProcedureName);
  Result := vMethod.Invoke(TValue.From<Pointer>(@vProcedures), AArrParamValues).AsVariant;
end;

end.
