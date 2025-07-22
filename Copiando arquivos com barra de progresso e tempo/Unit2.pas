unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, MMSystem,
  DateUtils, dxGDIPlusClasses;

type
  TfrmProgressoCopiaArquivo = class(TForm)

  private
    { Private declarations }
    procedure CopyFileWithProgressBar(Source, Destination: string);

  public
    { Public declarations }

  published
    ProgressBar: TProgressBar read FProgressBar write FProgressBar;
    LabelTempoEstimado: String read GetTempoEstimado write SetTempoEstimado;
    LabelTempoDecorrido: String read GetLabelTempoDecorrido write SetLabelTempoDecorrido;
    LabelVelocidadeMedia: String read GetVelocidadeMedia write SetVelocidadeMedia;
    LabelTamanhoTotal: String read GetTamanhoTotal write SetTamanhoTotal;
    LabelTamanhoRestante: String read GetTamanhoRestante write SetTamanhoRestante;
    LabelTamanhoProcessado: String read GetTamanhoProcessado write SetTamanhoProcessado;
  end;

var
  frmProgressoCopiaArquivo: TfrmProgressoCopiaArquivo;

implementation

{$R *.dfm}

procedure TfrmProgressoCopiaArquivo.CopyFileWithProgressBar(Source, Destination: string);
var
  FromF, ToF: file of byte;
  Buffer: array[0..49152] of char;
  NumRead: integer;
  FileLength: longint;
  FileLengthFinal: LongInt;
  tIni: TTime;
  vTempoEstimado: LongInt;
  vVelocidadeMbps: Integer;

  procedure ConfiguraArquivo;
  begin
    BlockRead(FromF, Buffer[0], SizeOf(Buffer), NumRead);
    FileLength := FileLength - NumRead;
    BlockWrite(ToF, Buffer[0], NumRead);
  end;

  function RetornarMegaBytes(AValor: LongInt): Integer;
  begin
    Result := (AValor div 1024) div 1024;
  end;

  Procedure ConfiguracaoInicial;
  begin
    AssignFile(FromF, Source);
    reset(FromF);
    AssignFile(ToF, Destination);
    rewrite(ToF);
    FileLength := FileSize(FromF);
    FileLengthFinal := RetornarMegaBytes(FileLength);
//    AProgressBar.Min  := 0;
//    AProgressBar.Max  := FileLength;
    tIni:= now;
    vTempoEstimado := 0;
    vVelocidadeMbps := 0;
  end;

begin
  ConfiguracaoInicial;
  while FileLength > 0 do
  begin
    ConfiguraArquivo;

    if SecondsBetween(Now, tIni) > 0 then
      vVelocidadeMbps := (FileLengthFinal - RetornarMegaBytes(FileLength)) div SecondsBetween(Now, tIni);

    if vVelocidadeMbps > 0 then
      vTempoEstimado := RetornarMegaBytes(FileLength) div vVelocidadeMbps;
   {
    ALabelTempoDecorrido.Caption := 'Tempo decorrido: ' + formatfloat(',#0 segundos', SecondsBetween(Now, tIni));
    ALabelTempoEstimado.Caption := 'Tempo estimado: ' + formatfloat(',#0 segundos', vTempoEstimado);
    ALabelTamanhoTotal.Caption := 'Tamanho total: ' + FormatFloat('###,###,###', FileLengthFinal);
    ALabelTamanhoProcessado.Caption := 'Tamanho processado: ' + FormatFloat('###,###,###', RetornarMegaBytes(FileLength));
    ALabelTamanhoRestante.Caption := 'Tamanho restante: ' + FormatFloat('###,###,###', FileLengthFinal - RetornarMegaBytes(FileLength));
    ALabelVelocidadeMedia.Caption := 'Velocidade (mbps): ' + FormatFloat('###,###,###', vVelocidadeMbps);
                       }
    Application.ProcessMessages;
//    AProgressBar.Position := AProgressBar.Position + NumRead;
  end;
  CloseFile(FromF);
  CloseFile(ToF);
end;

end.
