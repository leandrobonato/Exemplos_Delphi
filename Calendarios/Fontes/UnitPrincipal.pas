unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, FMX.ListBox,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, uLoading, System.DateUtils;

type
  TFrmPrincipal = class(TForm)
    rectToolbar: TRectangle;
    Label2: TLabel;
    btn_menu: TSpeedButton;
    lbDias: TListBox;
    rect_data: TRectangle;
    lblData: TLabel;
    lvDados: TListView;
    imgDia: TImage;
    imgDiaSelecao: TImage;
    procedure FormShow(Sender: TObject);
    procedure lbDiasItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
  private
    procedure MontarCalendario;
    procedure AddDia(lb: TListBox; dt: Tdate; ind_destaque: boolean);
    function DiaSemana(dt: TDate): string;
    procedure ThreadTerminate(Sender: TObject);
    procedure SelecionarDia(item: TlistboxItem);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses Frame.Dia;

function TFrmPrincipal.DiaSemana(dt: TDate): string;
begin

    case DayOfTheWeek(dt) of
        1: Result := 'Seg';
        2: Result := 'Ter';
        3: Result := 'Qua';
        4: Result := 'Qui';
        5: Result := 'Sex';
        6: Result := 'Sáb';
        7: Result := 'Dom';
    end;
end;

procedure TFrmPrincipal.AddDia(lb: TListBox;
                               dt: Tdate;
                               ind_destaque: boolean);
var
    item: TListBoxItem;
    f: TFrameDia;
begin
    // Inserir um item vazio na listbox...
    item := TListBoxItem.Create(nil);
    item.Text := '';
    item.Width := 70;
    item.TagString := FormatDateTime('dd', dt);
    item.Selectable := false;

    // Criar frame...
    f := TFrameDia.Create(item);
    f.Parent := item;
    f.lblTitulo.text := DiaSemana(dt);
    f.lblTexto.Text := FormatDateTime('dd', dt);
    f.imgDestaque.visible := ind_destaque;
    f.tagstring := FormatDateTime('dd/mm', dt) + ' - ' + DiaSemana(dt);

    f.imgSelecao.bitmap := imgDia.Bitmap;

    lb.AddObject(item);
end;

procedure TFrmPrincipal.ThreadTerminate(Sender: TObject);
begin
    lbDias.EndUpdate;
    TLoading.Hide;

    SelecionarDia(lbDias.ItemByIndex(0));
end;

procedure TFrmPrincipal.MontarCalendario;
var
    t: TThread;
begin
    TLoading.Show(FrmPrincipal, '');

    lbDias.Items.Clear;
    lbDias.BeginUpdate;

    t := TThread.CreateAnonymousThread(procedure
    begin
        // GET no servidor para pegar os
        // dados a serem montados no calendario...
        sleep(1000);
        //----------------------------------------

        TThread.Synchronize(TThread.CurrentThread, procedure
        var
            i: integer;
        begin
            for i := 0 to 7 do
                AddDia(lbDias, IncDay(now, i), true);
        end);
    end);

    t.OnTerminate := ThreadTerminate;
    t.Start;



end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
    MontarCalendario;
end;

procedure TFrmPrincipal.SelecionarDia(item: TListboxItem);
var
    f: TFrameDia;
    i: integer;
begin
    // Reset nos dias...
    for i := 0 to lbDias.Count - 1 do
    begin
        f := lbDias.ItemByIndex(i).FindComponent('FrameDia') as TFrameDia;
        f.imgSelecao.bitmap := imgDia.Bitmap;
    end;

    f := Item.FindComponent('FrameDia') as TFrameDia;
    f.imgSelecao.bitmap := imgDiaSelecao.Bitmap;

    lblData.Text := f.tagstring;


    // Popula Dados da lista inferior...
    lvDados.Items.Clear;
    lvDados.Items.Add.Text := 'Microsoft Brasil';
    lvDados.Items.Add.Text := 'Oracle Solutions';
    lvDados.Items.Add.Text := 'MasterPlus Informática';
    lvDados.Items.Add.Text := 'GigaTech Serviços';
    lvDados.Items.Add.Text := 'Network System';
    lvDados.Items.Add.Text := 'Kouda Brasil';
end;

procedure TFrmPrincipal.lbDiasItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
    SelecionarDia(Item);
end;

end.
