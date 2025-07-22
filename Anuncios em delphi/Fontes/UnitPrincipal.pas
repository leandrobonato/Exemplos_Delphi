unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Advertising;

type
  TFrmPrincipal = class(TForm)
    Memo1: TMemo;
    BannerAd1: TBannerAd;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BannerAd1ActionCanBegin(Sender: TObject;
      var WillLeaveApplication: Boolean);
    procedure BannerAd1ActionDidFinish(Sender: TObject);
    procedure BannerAd1DidLoad(Sender: TObject);
    procedure BannerAd1DidFail(Sender: TObject; const Error: string);
    procedure BannerAd1WillLoad(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

procedure TFrmPrincipal.BannerAd1ActionCanBegin(Sender: TObject;
  var WillLeaveApplication: Boolean);
begin
    Memo1.Lines.Add('ActionCanBegin');
end;

procedure TFrmPrincipal.BannerAd1ActionDidFinish(Sender: TObject);
begin
    Memo1.Lines.Add('ActionDidFinish');
end;

procedure TFrmPrincipal.BannerAd1DidFail(Sender: TObject; const Error: string);
begin
    Memo1.Lines.Add('DidFail');
end;

procedure TFrmPrincipal.BannerAd1DidLoad(Sender: TObject);
begin
    Memo1.Lines.Add('DidLoad');
end;

procedure TFrmPrincipal.BannerAd1WillLoad(Sender: TObject);
begin
    Memo1.Lines.Add('WillLoad');
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
    BannerAd1.AdUnitID := 'ca-app-pub-????????????/??????????';
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
    BannerAd1.LoadAd;
end;

end.
