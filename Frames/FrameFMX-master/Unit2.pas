unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts;

type
  TFrameTeste = class(TFrame)
    Layout1: TLayout;
    Image1: TImage;
    lblNome: TLabel;
    lblCPF: TLabel;
    lblIdade: TLabel;
    lblDataDeNascimento: TLabel;
    Rectangle1: TRectangle;
    Layout2: TLayout;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
