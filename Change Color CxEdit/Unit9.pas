unit Unit9;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxCustomTileControl, cxClasses, dxTileControl, dxSkinsForm, Vcl.Menus,
  Vcl.StdCtrls, cxButtons, dxSkinsdxBarPainter, dxBar, Vcl.ComCtrls;

type
  TForm9 = class(TForm)
    dxTileControl1: TdxTileControl;
    dxTileControl1Item1: TdxTileControlItem;
    dxTileControl1Group1: TdxTileControlGroup;
    dxSkinController1: TdxSkinController;
    cxLookAndFeelController1: TcxLookAndFeelController;
    dxTileControl1Group2: TdxTileControlGroup;
    dxTileControl1Item2: TdxTileControlItem;
    dxTileControl1Item3: TdxTileControlItem;
    dxTileControl1Item4: TdxTileControlItem;
    dxTileControl1Item5: TdxTileControlItem;
    dxTileControl1Item6: TdxTileControlItem;
    dxTileControl1Item7: TdxTileControlItem;
    dxTileControl1Item8: TdxTileControlItem;
    dxTileControl1Item9: TdxTileControlItem;
    dxTileControl1Item10: TdxTileControlItem;
    dxTileControl1Item11: TdxTileControlItem;
    dxTileControl1Item12: TdxTileControlItem;
    dxTileControl1Item13: TdxTileControlItem;
    dxTileControl1Item14: TdxTileControlItem;
    dxTileControl1Group3: TdxTileControlGroup;
    dxTileControl1Item15: TdxTileControlItem;
    dxTileControl1Item16: TdxTileControlItem;
    dxTileControl1Item17: TdxTileControlItem;
    cxButton1: TcxButton;
    dxBarManager1: TdxBarManager;
    dxBarPopupMenu4: TdxBarPopupMenu;
    dxBarLargeButton1: TdxBarLargeButton;
    dxBarLargeButton2: TdxBarLargeButton;
    procedure FormCreate(Sender: TObject);
    procedure ListView1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EasyListview1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

{$R *.dfm}

procedure TForm9.EasyListview1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var mouse: tpoint;
x1,y1: integer;
begin
   if GetCursorPos(Mouse) then begin x1:=mouse.x; y1:=mouse.y; end;

dxBarPopupMenu4.Popup(x1,y1);

end;

procedure TForm9.FormCreate(Sender: TObject);
begin
    dxSkinsUserSkinLoadFromFile('win8-black.skinres');
  dxSkinController1.SkinName := 'UserSkin';

    cxLookAndFeelController1.BeginUpdate;
  try
    cxLookAndFeelController1.SkinName := 'UserSkin';
    cxLookAndFeelController1.NativeStyle := cxLookAndFeelPaintersManager.GetPainter('UserSkin') = nil;
  finally
    cxLookAndFeelController1.EndUpdate;
  end;

  CXBUTTON1.Font.Size := 11;
  CXBUTTON1.Font.Style:=[fsbold];
  CXBUTTON1.Colors.Default := $00B98711;
  CXBUTTON1.Colors.Normal := $00B98711;
  CXBUTTON1.Colors.DefaultText := $00FFFFFF;
  CXBUTTON1.Colors.Hot := $00B98711;
  CXBUTTON1.Colors.HotText := $00FFFFFF;
  CXBUTTON1.Colors.Pressed := $00B98711;
  CXBUTTON1.Colors.PressedText := $00FFFFFF;

end;

procedure TForm9.ListView1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
//begin
var mouse: tpoint;
x1,y1: integer;
begin
   if GetCursorPos(Mouse) then begin x1:=mouse.x; y1:=mouse.y; end;

dxBarPopupMenu4.Popup(x1,y1);

end;

end.
