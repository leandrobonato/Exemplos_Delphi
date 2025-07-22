unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs;

type
  TFrmPrincipal = class(TForm)
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
     Controllers.Usuario;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
    THorse.Use(Jhonson());
    THorse.Use(CORS);

    // Registrar as rotas...
    Controllers.Usuario.RegistrarRotas;

    THorse.Listen(3001);
end;

end.
