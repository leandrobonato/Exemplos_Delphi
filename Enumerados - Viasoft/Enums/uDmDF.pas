unit uDmDF;

interface

uses
  System.SysUtils, System.Classes, Data.DB, JvMemoryDataset;

type
  TdmDF = class(TDataModule)
    mdNF: TJvMemoryData;
    mdNFID: TAutoIncField;
    mdNFNUMERO: TIntegerField;
    mdNFSITUACAO: TStringField;
    mdNFDESC_SITUACAO: TStringField;
    procedure mdNFCalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmDF: TdmDF;

implementation

uses
  EnumHelper, EnumTypes;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmDF.DataModuleCreate(Sender: TObject);
begin
  mdNF.Active := True;
end;

procedure TdmDF.mdNFCalcFields(DataSet: TDataSet);
begin
  if mdNFSITUACAO.AsString <> '' then
    mdNFDESC_SITUACAO.AsString := TEnumUtils<TSituacaoDF>.GetByCod(mdNFSITUACAO.AsString).Descricao
  else
    mdNFDESC_SITUACAO.Clear;
end;

end.
