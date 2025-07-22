unit uFormPrincipal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  Vcl.StdCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ExtCtrls,
  System.UITypes,
  Refactor.Controller.Interfaces;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Button1: TButton;
    Edit1: TEdit;
    Image1: TImage;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
    FController : iController;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Refactor.Controller, Refactor.View.Pages.Users;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  FController.Entities.Categorias.Get;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  FController
    .Entities
      .Categorias
        .This
          .DESCRICAO(Edit1.Text)
          .ICONE(Image1.Picture.Bitmap)
          .INDICE_ICONE(1)
        .&End
      .Insert
    .Get;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  FController
    .Entities
      .Categorias
        .This
          .ID_CATEGORIA(DataSource1.DataSet.FieldByName('ID_CATEGORIA').AsInteger)
          .DESCRICAO(Edit1.Text)
          .ICONE(Image1.Picture.Bitmap)
          .INDICE_ICONE(1)
        .&End
      .Update
    .Get;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  FController
    .Entities
      .Categorias
        .This
          .ID_CATEGORIA(DataSource1.DataSet.FieldByName('ID_CATEGORIA').AsInteger)
        .&End
      .Delete
    .Get;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  PageUsers.Show;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FController := TController.New;
  FController.Entities.Categorias.DataSet(DataSource1);
end;

end.
