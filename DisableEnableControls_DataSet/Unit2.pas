unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Bind.GenData, Data.Bind.GenData,
  Data.Bind.Controls, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Vcl.Bind.Grid,
  System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Vcl.Grids, Vcl.Buttons, Vcl.Bind.Navigator,
  Data.Bind.ObjectScope, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient,
  Vcl.DBGrids, Datasnap.Provider, Data.Bind.DBScope, System.TypInfo;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    PrototypeBindSource1: TPrototypeBindSource;
    NavigatorPrototypeBindSource1: TBindNavigator;
    ClientDataSet1: TClientDataSet;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ClientDataSet1Color_Int: TIntegerField;
    ClientDataSet1Color_Name: TStringField;
    ClientDataSet1Bitmap_Name: TStringField;
    BindSourceDB1: TBindSourceDB;
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure NavigatorPrototypeBindSource1Click(Sender: TObject;
      Button: TNavigateButton);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
  if ClientDataSet1.ControlsDisabled then
    showMessage('Controles desabilitados!')
  else
    showMessage('Controles habilitados!');
end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
  ClientDataSet1.DisableControls;
end;

procedure TForm2.BitBtn3Click(Sender: TObject);
begin
  while ClientDataSet1.ControlsDisabled do
  begin
    ClientDataSet1.EnableControls;
  end;
end;

procedure TForm2.BitBtn4Click(Sender: TObject);
begin
  PrototypeBindSource1.AutoActivate := false;
  if ClientDataSet1.Active then
    ClientDataSet1.EmptyDataSet;
end;

procedure TForm2.BitBtn5Click(Sender: TObject);
begin
  PrototypeBindSource1.AutoActivate := true;
  if PrototypeBindSource1.Active then
  begin
    if ClientDataSet1.Active then
      ClientDataSet1.EmptyDataSet;
    ClientDataSet1.Close;
    ClientDataSet1.CreateDataSet;
    ClientDataSet1.Open;
    PrototypeBindSource1.First;
    while not PrototypeBindSource1.Eof do
    begin
      ClientDataSet1.Insert;
      ClientDataSet1.FieldByName('Bitmap_Name').Value := PrototypeBindSource1.DataGenerator.FindField('Bitmap_Name').GetTValue.AsVariant;
      ClientDataSet1.FieldByName('Color_Int').Value := PrototypeBindSource1.DataGenerator.FindField('Color_Int').GetTValue.AsVariant;
      ClientDataSet1.FieldByName('Color_Name').Value := PrototypeBindSource1.DataGenerator.FindField('Colors_Name').GetTValue.AsVariant;
      ClientDataSet1.Post;
      PrototypeBindSource1.Next;
    end;
  end;
end;

procedure TForm2.NavigatorPrototypeBindSource1Click(Sender: TObject;
  Button: TNavigateButton);
begin
  case button of
    nbFirst: showMessage(ClientDataSet1.Fields[0].Value);
    nbPrior: showMessage(ClientDataSet1.Fields[0].Value);
    nbNext: showMessage(ClientDataSet1.Fields[0].Value);
    nbLast: showMessage(ClientDataSet1.Fields[0].Value);
    nbInsert: showMessage(ClientDataSet1.Fields[0].Value);
    nbDelete: showMessage(ClientDataSet1.Fields[0].Value);
    nbEdit: showMessage(ClientDataSet1.Fields[0].Value);
    nbPost: showMessage(ClientDataSet1.Fields[0].Value);
    nbCancel: showMessage(ClientDataSet1.Fields[0].Value);
    nbRefresh: showMessage(ClientDataSet1.Fields[0].Value);
    nbApplyUpdates: showMessage(ClientDataSet1.Fields[0].Value);
    nbCancelUpdates: showMessage(ClientDataSet1.Fields[0].Value);
  end;
end;

end.
