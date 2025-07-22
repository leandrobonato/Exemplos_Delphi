unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo;

type
  TFrmPrincipal = class(TForm)
    memo: TMemo;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses Horse,
     Horse.Jhonson,
     Horse.CORS,
     Horse.BasicAuthentication,
     Controllers.Mensagem;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
    THorse.Use(Jhonson());
    THorse.Use(CORS);

    THorse.Use(HorseBasicAuthentication(
    function(const AUsername, APassword: string): Boolean
    begin
        Result := AUsername.Equals('testserver') and APassword.Equals('testserver');
    end));

    // Registrar as rotas (/messages)
    Controllers.Mensagem.RegistrarRotas;

    THorse.Listen(9000, procedure(Horse: THorse)
    begin
        memo.Lines.Add('Servidor executando na porta: ' + Horse.Port.ToString);
    end);
end;

end.
