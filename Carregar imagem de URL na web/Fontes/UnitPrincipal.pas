unit UnitPrincipal;

interface

uses
  System.SysUtils, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  FMX.BitmapHelper, FMX.ListBox, System.Generics.Collections;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Circle1: TCircle;
    ListBox: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure ListBoxItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
  private
    procedure CarregarListbox;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation


{$R *.fmx}

procedure TForm1.CarregarListbox;
var
    url : TList<String>;
    textos : TList<String>;
    item : TListBoxItem;
    x : integer;
    lbl : TLabel;
    img : TImage;
begin
    try
        ListBox.Items.Clear;
        ListBox.BeginUpdate;

        url := TList<String>.create;
        url.AddRange(['https://d4p17acsd5wyj.cloudfront.net/shortcuts/cuisines/pizza.png',
                      'https://d4p17acsd5wyj.cloudfront.net/shortcuts/cuisines/burger.png',
                      'https://d4p17acsd5wyj.cloudfront.net/shortcuts/grocery.png',
                      'https://d4p17acsd5wyj.cloudfront.net/shortcuts/cuisines/fastfood.png',
                      'https://d4p17acsd5wyj.cloudfront.net/shortcuts/alcohol.png',
                      'https://d4p17acsd5wyj.cloudfront.net/shortcuts/cuisines/sushi.png',
                      'https://d4p17acsd5wyj.cloudfront.net/shortcuts/cuisines/bakery.png',
                      'https://d4p17acsd5wyj.cloudfront.net/shortcuts/cuisines/bbq.png']);

        textos := TList<String>.create;
        textos.AddRange(['Pizza', 'Burguer', 'Mercado', 'Fast Food',
                         'Bebidas', 'Sushi', 'Padaria', 'Churrasco']);

        for x := 0 to url.Count - 1 do
        begin
            item := TListBoxItem.Create(Listbox);
            item.Text := '';
            item.TagString := x.ToString; // Cod Categoria...
            item.Width := 100;
            item.Selectable := false;

            // Texto...
            lbl := TLabel.Create(item);
            lbl.Text := textos.Items[x];
            lbl.StyledSettings := lbl.StyledSettings - [TStyledSetting.Size,
                                                        TStyledSetting.FontColor,
                                                        TStyledSetting.Other];
            lbl.FontColor := $FF6b6b6b;
            lbl.font.Size := 12;
            lbl.Height := 20;
            lbl.Align := TAlignLayout.Bottom;
            lbl.TextSettings.HorzAlign := TTextAlign.Center;
            item.AddObject(lbl);

            // Icones...
            img := TImage.Create(item);
            img.Bitmap.LoadFromUrl(url.Items[x]);
            img.Align := TAlignLayout.Client;
            img.WrapMode := TImageWrapMode.Stretch;
            img.Margins.Left := 10;
            img.HitTest := false;
            item.AddObject(img);

            ListBox.AddObject(Item);
        end;
    finally
        ListBox.EndUpdate;
        textos.DisposeOf;
        url.DisposeOf;
    end;
end;


procedure TForm1.ListBoxItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
    ShowMessage('Categoria: ' + Item.TagString);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    Circle1.Fill.Bitmap.Bitmap.LoadFromUrl('https://d4p17acsd5wyj.cloudfront.net/shortcuts/cuisines/pizza.png');

    CarregarListbox;
end;

end.
