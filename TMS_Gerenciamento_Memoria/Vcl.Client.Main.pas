unit Vcl.Client.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  XData.Client, Vcl.StdCtrls,
  System.Generics.Collections;

type
  TForm13 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form13: TForm13;

implementation

uses
  TesteService,
  Bcl.Json;

{$R *.dfm}

procedure TForm13.Button1Click(Sender: TObject);
var
  Client: TXDataClient;
  Dto: TDtoSimples;
begin
  Client := TXDataClient.Create;
  try
    Client.Uri := 'http://localhost:2001/tms/xdata';
    Dto := Client.Service<ITesteService>.DtoSimples;
    ShowMessage(TJson.Serialize(Dto));
  finally
    Client.Free;
  end;
end;

procedure TForm13.Button2Click(Sender: TObject);
var
  Client: TXDataClient;
  Dto: TDtoComposto;
begin
  Client := TXDataClient.Create;
  try
    Client.Uri := 'http://localhost:2001/tms/xdata';
    Dto := Client.Service<ITesteService>.DtoComposto;
    ShowMessage(TJson.Serialize(Dto));
  finally
    Client.Free;
  end;
end;

procedure TForm13.Button3Click(Sender: TObject);
var
  Client: TXDataClient;
  List: TList<TDtoSimples>;
begin
  Client := TXDataClient.Create;
  try
    Client.Uri := 'http://localhost:2001/tms/xdata';
    List := Client.Service<ITesteService>.DtoSimplesList;
    ShowMessage(TJson.Serialize(List));
  finally
    List.Free;
    Client.Free;

  end;
end;

procedure TForm13.Button4Click(Sender: TObject);
var
  Client: TXDataClient;
  Dto: TDtoComLista;
begin
  Client := TXDataClient.Create;
  try
    Client.Uri := 'http://localhost:2001/tms/xdata';
    Dto := Client.Service<ITesteService>.DtoComLista;
    ShowMessage(TJson.Serialize(Dto));
  finally
    Client.Free;
  end;
end;

procedure TForm13.Button5Click(Sender: TObject);
var
  Client: TXDataClient;
  Uf: TUf;
begin
  Client := TXDataClient.Create;
  try
    Client.Uri := 'http://localhost:2001/tms/xdata';
    Uf := Client.Service<ITesteService>.Uf;
    Uf.Cidades.Load;
    ShowMessage(Uf.ToString + ' Total Cidades = '+Uf.Cidades.Value.Count.ToString);
  finally
    Client.Free;
  end;
end;

procedure TForm13.Button6Click(Sender: TObject);
var
  Client: TXDataClient;
  Dto: TDtoSimples;
begin
  Client := TXDataClient.Create;
  Dto := TDtoSimples.Create;
  Dto.Nome := 'teste salvar';
  try
    Client.Uri := 'http://localhost:2001/tms/xdata';
    Client.Service<ITesteService>.Salvar(Dto);
  finally
    Client.Free;
   // Dto.Free;
  end;
end;

end.
