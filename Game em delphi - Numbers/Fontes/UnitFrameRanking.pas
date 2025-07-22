unit UnitFrameRanking;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts;

type
  TFrameRanking = class(TFrame)
    imgMedalha: TImage;
    lbl_posicao: TLabel;
    lbl_nome: TLabel;
    lbl_pontuacao: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
