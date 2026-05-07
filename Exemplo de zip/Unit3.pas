unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TForm3 = class(TForm)
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses
  System.IOUtils, System.Zip, System.Types;

procedure AdicionarPastaAoZip(ZipFile: TZipFile; const PastaRaiz, PastaAtual: string);
var
  Arquivos: TStringDynArray;
  SubPastas: TStringDynArray;
  NomeRelativo: string;
  s: string;
begin
  // Adiciona arquivos da pasta atual
  Arquivos := TDirectory.GetFiles(PastaAtual);
  for s in Arquivos do
  begin
    // Cria nome relativo dentro do ZIP
    NomeRelativo := ExtractRelativePath(PastaRaiz, s);
    ZipFile.Add(s, NomeRelativo);
  end;

  // Processa subpastas recursivamente
  SubPastas := TDirectory.GetDirectories(PastaAtual);
  for s in SubPastas do
    AdicionarPastaAoZip(ZipFile, PastaRaiz, s);
end;

procedure TForm3.BitBtn1Click(Sender: TObject);
var
  ZipFile: TZipFile;
  PastaOrigem: string;
begin
  PastaOrigem := 'C:\Users\DELPHI\Downloads\exportar\';

  if not DirectoryExists(PastaOrigem) then
  begin
    ShowMessage('Pasta não encontrada: ' + PastaOrigem);
    Exit;
  end;

  ZipFile := TZipFile.Create;
  try
    ZipFile.Open('C:\Users\DELPHI\Downloads\exportar.zip', TZipMode.zmWrite);
    AdicionarPastaAoZip(ZipFile, PastaOrigem, PastaOrigem);
    ShowMessage('Pasta compactada com sucesso!');
  finally
    ZipFile.Free;
  end;
end;

end.
