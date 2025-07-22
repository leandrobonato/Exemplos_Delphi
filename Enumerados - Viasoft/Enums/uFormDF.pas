unit uFormDF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, Vcl.Grids, Vcl.DBGrids, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, Vcl.ComCtrls, cxContainer, Vcl.StdCtrls,
  cxMaskEdit, cxDropDownEdit, cxImageComboBox, cxDBEdit, cxTextEdit,
  cxDBNavigator, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Vcl.Bind.Grid,
  System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, dxDateRanges, dxScrollbarAnnotations;

type
  TFormDF = class(TForm)
    dsNF: TDataSource;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    DBGrid1: TDBGrid;
    cxGrid1DBTableView1ID: TcxGridDBColumn;
    cxGrid1DBTableView1NUMERO: TcxGridDBColumn;
    cxGrid1DBTableView1SITUACAO: TcxGridDBColumn;
    cxDBNavigator1: TcxDBNavigator;
    cxDBTextEdit1: TcxDBTextEdit;
    cxDBTextEdit2: TcxDBTextEdit;
    cxDBImageComboBox1: TcxDBImageComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    TabSheet4: TTabSheet;
    sgNF: TStringGrid;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDF: TFormDF;

implementation

uses
  uDmDF, uDmRepos;

{$R *.dfm}

end.
