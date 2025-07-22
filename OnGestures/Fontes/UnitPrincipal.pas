unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Gestures,
  FMX.Objects, FMX.TabControl, FMX.Controls.Presentation, FMX.StdCtrls,
  System.Actions, FMX.ActnList, FMX.ListBox, FMX.Layouts;

type
  TFrmPrincipal = class(TForm)
    GestureManager1: TGestureManager;
    Rectangle1: TRectangle;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ActionList1: TActionList;
    ActTab2: TChangeTabAction;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure Rectangle1Click(Sender: TObject);
    procedure TabControl1Gesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure ListBox1Gesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

procedure TFrmPrincipal.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
    if EventInfo.GestureID = igiLongTap then
        Rectangle1.Visible := true;

    if EventInfo.GestureID = sgiUp then
        showmessage('UP');

    if EventInfo.GestureID = sgiDown then
        showmessage('DOWN');
end;

procedure TFrmPrincipal.ListBox1Gesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
    if EventInfo.GestureID = igiLongTap then
        showmessage(ListBox1.Selected.Text);

end;

procedure TFrmPrincipal.Rectangle1Click(Sender: TObject);
begin
    Rectangle1.Visible := false;
end;

procedure TFrmPrincipal.TabControl1Gesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
    if EventInfo.GestureID = sgiRight then
    begin
        if TabControl1.ActiveTab = TabItem2 then
            TabControl1.GotoVisibleTab(0)
        else if TabControl1.ActiveTab = TabItem3 then
            TabControl1.GotoVisibleTab(1)
    end;

    if EventInfo.GestureID = sgiLeft then
    begin
        if TabControl1.ActiveTab = TabItem1 then
            TabControl1.GotoVisibleTab(1)
        else if TabControl1.ActiveTab = TabItem2 then
            TabControl1.GotoVisibleTab(2);
    end;
end;

end.
