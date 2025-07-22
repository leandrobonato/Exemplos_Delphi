unit Refactor.View.Pages.Users;

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
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Refactor.Controller.Interfaces;

type
  TPageUsers = class(TForm)
    Edit1: TEdit;
    Button2: TButton;
    Button1: TButton;
    Button3: TButton;
    Button4: TButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FController : iController;
  public
    { Public declarations }
  end;

var
  PageUsers: TPageUsers;

implementation

uses
  Refactor.Controller;

{$R *.dfm}

procedure TPageUsers.Button1Click(Sender: TObject);
begin
  FController.Entities.Users.Get;
end;

procedure TPageUsers.Button2Click(Sender: TObject);
begin
  FController
    .Entities
      .Users
        .This
          .NAME(Edit1.Text)
        .&End
      .Insert
    .Get;
end;

procedure TPageUsers.Button3Click(Sender: TObject);
begin
  FController
    .Entities
      .Users
        .This
          .NAME(Edit1.Text)
          .ID(DataSource1.DataSet.FieldByName('ID').AsInteger)
        .&End
      .Update
    .Get;
end;

procedure TPageUsers.Button4Click(Sender: TObject);
begin
  FController
    .Entities
      .Users
        .This
          .ID(DataSource1.DataSet.FieldByName('ID').AsInteger)
        .&End
      .Delete
    .Get;
end;

procedure TPageUsers.FormCreate(Sender: TObject);
begin
  FController :=  TController.New;
  FController.Entities.Users.DataSet(DataSource1);
end;

end.
