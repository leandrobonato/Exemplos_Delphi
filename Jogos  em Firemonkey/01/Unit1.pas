unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics, 
  FMX.Dialogs, System.Math.Vectors, FMX.Objects3D, FMX.Controls3D,
  FMX.MaterialSources, FMX.Media, FMX.Viewport3D, FMX.Ani;

type
  TForm1 = class(TForm3D)
    Viewport3D1: TViewport3D;
    FloatAnimation1: TFloatAnimation;
    Cube1: TCube;
    TextureMaterialSource1: TTextureMaterialSource;
    Light1: TLight;
    procedure tmr1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.iPhone.fmx IOS}

procedure TForm1.tmr1Timer(Sender: TObject);
begin
//  Camera1.Position.X := Camera1.Position.X + 10;
//  Camera1.Position.z := Camera1.Position.z + 1;
//  Camera1.RotationAngle.X := Camera1.RotationAngle.x + 10;
end;

end.
