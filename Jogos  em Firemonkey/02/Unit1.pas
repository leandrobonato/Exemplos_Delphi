unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Math.Vectors, FMX.Types3D, FMX.Ani, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Objects3D, FMX.Controls3D, FMX.Viewport3D,
  FMX.MaterialSources;

type
  TForm1 = class(TForm)
    Viewport3D1: TViewport3D;
    Model3D1: TModel3D;
    Light1: TLight;
    Grid3D1: TGrid3D;
    FloatAnimation1: TFloatAnimation;
    lmColor: TLightMaterialSource;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
var
  vMesh: TMesh;
begin
  for vMesh in Model3D1.MeshCollection do
  begin
    vMesh.MaterialSource := LMColor;
  end;
end;

end.
