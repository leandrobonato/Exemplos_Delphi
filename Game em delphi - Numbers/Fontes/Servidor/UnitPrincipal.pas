unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,

  Horse,
  Horse.Jhonson,
  Horse.BasicAuthentication,
  Controller.Ranking;

type
  TFrmPrincipal = class(TForm)
    memo: TMemo;
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

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
    THorse.Use(Jhonson());

    THorse.Use(HorseBasicAuthentication(
    function(const AUsername, APassword: string): Boolean
    begin
        Result := AUsername.Equals('numbers') and APassword.Equals('numbers');
    end));

    Controller.Ranking.RegistrarRotas;

    THorse.Listen(9000);
end;

end.
