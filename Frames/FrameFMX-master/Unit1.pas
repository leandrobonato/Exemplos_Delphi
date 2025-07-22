unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, System.Actions, FMX.ActnList, FMX.StdActns,
  FMX.MediaLibrary.Actions, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.ListView, FMX.Effects,
  FMX.ListBox;

type
  TForm1 = class(TForm)
    Layout1: TLayout;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    Circle1: TCircle;
    Layout2: TLayout;
    ListBox1: TListBox;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses Unit2;

procedure TForm1.FormShow(Sender: TObject);
var
  item: TListBoxItem;
  FFrame: TFrameTeste;

begin

  try
    ListBox1.BeginUpdate;

    for var i := 0 to 20 do
    begin

      item := TListBoxItem.Create(self);
      FFrame := TFrameTeste.Create(self);
      FFrame.Name:= 'Frame'+i.ToString;

      FFrame.Parent := item;
      FFrame.Align := TAlignLayout.Client;
      item.Height := 102;
      item.Margins.Left:= 8;
      item.Margins.Right:= 8;
      item.Margins.Top:= 8;
      item.Margins.Bottom:= 8;

      FFrame.lblNome.Text := ' Usuário de Teste ' + i.ToString;
      FFrame.lblCPF.Text := ' 123.321.456-87 (' + i.ToString + ')';
      FFrame.lblIdade.Text := ' 35 (' + i.ToString + ')';
      FFrame.lblDataDeNascimento.Text := ' 01/01/1990 (' + i.ToString + ')';

      item.Parent := ListBox1;

    end;

  finally
    ListBox1.EndUpdate;
  end;

end;

end.
