unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uCombobox,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.ListBox, FMX.Layouts;

type
  TForm1 = class(TForm)
    Button1: TButton;
    RoundRect1: TRoundRect;
    Image5: TImage;
    lblPais2: TLabel;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    Image7: TImage;
    Image8: TImage;
    lblPais: TLabel;
    Line1: TLine;
    Line2: TLine;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RoundRect1Click(Sender: TObject);
    procedure ListBoxItem1Click(Sender: TObject);
  private
    c: TCustomCombo;
    {$IFDEF MSWINDOWS}
    procedure ItemClick(Sender: TObject);
    {$ELSE}
    procedure ItemClick(Sender: TObject; const Point: TPointF);
    {$ENDIF}
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

{$IFDEF MSWINDOWS}
procedure TForm1.ItemClick(Sender: TObject);
begin
    c.HideMenu;
    //showmessage(c.CodItem + ' - ' + c.DescrItem);
    lblPais.Text := c.DescrItem;
end;
{$ELSE}
procedure TForm1.ItemClick(Sender: TObject; const Point: TPointF);
begin
    c.HideMenu;
    //showmessage(c.CodItem + ' - ' + c.DescrItem);
    lblPais.Text := c.DescrItem;
end;
{$ENDIF}

procedure TForm1.ListBoxItem1Click(Sender: TObject);
begin
    c.ShowMenu;
end;

procedure TForm1.RoundRect1Click(Sender: TObject);
begin
    c.ShowMenu;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    c.ShowMenu;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    c := TCustomCombo.Create(Form1);

    //c.ItemBackgroundColor := $FFFFFFFF;
    //c.ItemFontSize := 15;
    //c.ItemFontColor := $FF1F2035;

    c.TitleMenuText := 'Escolha o país que pretende fazer sua próxima viagem';
    //c.TitleFontSize := 17;
    //c.TitleFontColor := $FF1F2035;

    c.SubTitleMenuText := 'Você pode mudar sua escolha no futuro';
    //c.SubTitleFontSize := 13;
    //c.SubTitleFontColor := $FF9E9EB4;

    c.BackgroundColor := $FFF2F2F8;
    c.OnClick := ItemClick;

    c.AddItem('000', 'Argentina');
    c.AddItem('001', 'Bélgica');
    c.AddItem('002', 'Brasil');
    c.AddItem('003', 'Canadá');
    c.AddItem('004', 'Chile');
    c.AddItem('005', 'Espanha');
    c.AddItem('006', 'Estados Unidos');
    c.AddItem('007', 'Itália');
    c.AddItem('008', 'Inglaterra');
    c.AddItem('009', 'México');
    c.AddItem('010', 'Portugal');
    c.AddItem('011', 'Suíça');

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    c.DisposeOf;
end;

end.
