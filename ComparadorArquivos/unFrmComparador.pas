unit unFrmComparador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmComparadorArquivos = class(TForm)
    pnlCabecalho: TPanel;
    btnComparar: TButton;
    btnCarregarArquivos: TButton;
    btnSalvar: TButton;
    pnlArquivo1: TPanel;
    pnlArquivo2: TPanel;
    pnlDiferenca: TPanel;
    mmoArquivo1: TMemo;
    mmoArquivo2: TMemo;
    mmoDiferenca: TMemo;
    btnLimpar: TButton;
    procedure btnSalvarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnCarregarArquivosClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    { Private declarations }
    FArquivo1: String;
    FArquivo2: String;
  public
    { Public declarations }
  published
    { Published declarations }
    property Arquivo1: String read FArquivo1 write FArquivo1;
    property Arquivo2: String read FArquivo2 write FArquivo2;
  end;

var
  frmComparadorArquivos: TfrmComparadorArquivos;

implementation

{$R *.dfm}

procedure TfrmComparadorArquivos.btnCarregarArquivosClick(Sender: TObject);
var
  vIdx: Integer;
begin
  for vIdx := 0 to mmoArquivo1.Lines.Count - 1 do
  begin
    if mmoArquivo2.Lines.IndexOf(mmoArquivo1.Lines.Strings[vIdx]) < 0 then
      mmoDiferenca.Lines.Add(mmoArquivo1.Lines.Strings[vIdx]);
  end;
end;

procedure TfrmComparadorArquivos.btnLimparClick(Sender: TObject);
begin
  FArquivo1 := '';
  FArquivo2 := '';
  mmoArquivo1.Text := '';
  mmoArquivo2.Text := '';
  mmoDiferenca.Text := '';
end;

procedure TfrmComparadorArquivos.btnSalvarClick(Sender: TObject);
var
  vOpenDialog: TOpenDialog;
begin
  vOpenDialog := TOpenDialog.Create(Self);
  try
    if vOpenDialog.Execute then
    begin
      FArquivo1 := vOpenDialog.FileName;
      mmoArquivo1.Lines.LoadFromFile(FArquivo1);
      pnlArquivo1.Caption := ExtractFileName(FArquivo1);
    end;
    if vOpenDialog.Execute then
    begin
      FArquivo2 := vOpenDialog.FileName;
      mmoArquivo2.Lines.LoadFromFile(FArquivo2);
      pnlArquivo2.Caption := ExtractFileName(FArquivo2);
    end;
  finally
    FreeAndNil(vOpenDialog);
  end;
end;

procedure TfrmComparadorArquivos.FormActivate(Sender: TObject);
begin
  mmoArquivo1.Lines.Delimiter := #13;
  mmoArquivo1.Lines.LineBreak := #13;
  mmoArquivo2.Lines.Delimiter := #13;
  mmoArquivo2.Lines.LineBreak := #13;
end;

end.
