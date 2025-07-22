unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox,
  System.DateUtils;

type
  TFrmPrincipal = class(TForm)
    Rectangle1: TRectangle;
    lblData: TLabel;
    lbCalendario: TListBox;
    lblDataSelecao: TLabel;
    Line1: TLine;
    procedure FormShow(Sender: TObject);
    procedure lbCalendarioItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
  private
    procedure AddDia(dt: TDateTime; ind_destaque: boolean);
    procedure Calendario;
    procedure SelectDay(Item: TListBoxItem);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses Frame.Calendario;

function TranslateDay(d: integer): string;
begin
    case d of
        1: Result := 'DOM';
        2: Result := 'SEG';
        3: Result := 'TER';
        4: Result := 'QUA';
        5: Result := 'QUI';
        6: Result := 'SEX';
        else Result := 'SAB';
    end;
end;

procedure TFrmPrincipal.AddDia(dt: TDateTime; ind_destaque: boolean);
var
    item: TListBoxItem;
    frame: TFrameCalendario;
begin
    item := TListBoxItem.Create(lbCalendario);
    item.Selectable := false;
    item.Text := '';
    item.Width := 60;
    item.Margins.Left := 5;
    item.Tag := FormatDateTime('dd', dt).ToInteger;
    item.TagString := FormatDateTime('dd/MM/yyyy', dt);

    // Frame...
    frame := TFrameCalendario.Create(item);
    frame.lblDia.Text := FormatDateTime('d', dt);
    frame.lblSemana.Text := TranslateDay(DayOfWeek(dt));
    frame.cDia.Fill.Kind := TBrushKind.None;
    frame.cDestaque.visible := ind_destaque;
    item.AddObject(frame);

    lbCalendario.AddObject(item);
end;

procedure TFrmPrincipal.SelectDay(Item: TListBoxItem);
var
    frame: TFrameCalendario;
    i: integer;
begin
    {
    for i := 0 to lbCalendario.Items.Count - 1 do
    begin
        frame := TFrameCalendario(lbCalendario.ItemByIndex(i).Components[0]);
        frame.cDia.Fill.Kind := TBrushKind.None;
    end;
    }

    for i := 0 to lbCalendario.Items.Count - 1 do
        TFrameCalendario(lbCalendario.ItemByIndex(i).Components[0]).cDia.Fill.Kind := TBrushKind.None;


    TFrameCalendario(Item.Components[0]).cDia.Fill.Kind := TBrushKind.Solid;


    // Popula sua lista de dados, etc...
    lblDataSelecao.Text := Item.TagString;
end;

procedure TFrmPrincipal.Calendario;
var
    i: integer;
begin
    for i := 0 to 6 do
        if i = 1 then
            AddDia(IncDay(date, i), true)
        else
            AddDia(IncDay(date, i), false);

    SelectDay(lbCalendario.ItemByIndex(0));
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
    Calendario;
end;

procedure TFrmPrincipal.lbCalendarioItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
    SelectDay(Item);
end;

end.
