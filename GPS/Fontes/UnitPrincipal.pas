unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Maps,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects;

type
  TFrmPrincipal = class(TForm)
    MapView: TMapView;
    SpeedButton1: TSpeedButton;
    Panel1: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    imgMoto: TImage;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure MapViewMarkerDragEnd(Marker: TMapMarker);
    procedure MapViewMarkerClick(Marker: TMapMarker);
  private
    marker: TMapMarkerDescriptor;
    procedure AddMarker(latitude, longitude: double; titulo, descricao: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

procedure TFrmPrincipal.AddMarker(latitude, longitude: double;
                                  titulo, descricao: string);
var
    posicao: TMapCoordinate;
    //marker: TMapMarkerDescriptor;
begin
    posicao.Latitude := latitude;
    posicao.Longitude := longitude;

    marker := TMapMarkerDescriptor.Create(posicao, titulo);
    marker.Snippet := descricao;
    marker.Visible := true;
    //marker.Icon := imgMoto.Bitmap;
    marker.Draggable := true;

    MapView.AddMarker(marker);
end;


procedure TFrmPrincipal.FormCreate(Sender: TObject);
var
    posicao: TMapCoordinate;
begin
    // Posicao inicial...
    posicao.Latitude := -23.542557;
    posicao.Longitude := -46.630918;
    MapView.Location := posicao;

    // Zoom...
    MapView.Zoom := 11;
end;

procedure TFrmPrincipal.MapViewMarkerClick(Marker: TMapMarker);
begin
    showmessage('Mostrar detalhes do técnico: ' + Marker.Descriptor.Title);
end;

procedure TFrmPrincipal.MapViewMarkerDragEnd(Marker: TMapMarker);
begin
    showmessage(Marker.Descriptor.Position.Latitude.ToString + ' - ' +
                Marker.Descriptor.Position.Longitude.ToString);
end;

procedure TFrmPrincipal.SpeedButton1Click(Sender: TObject);
begin
    AddMarker(-23.542557, -46.630918, 'Heber', 'OS: 5425');
end;

procedure TFrmPrincipal.SpeedButton2Click(Sender: TObject);
begin
    MapView.MapType := TMapType.Normal;
end;

procedure TFrmPrincipal.SpeedButton3Click(Sender: TObject);
begin
    MapView.MapType := TMapType.Satellite;
end;

procedure TFrmPrincipal.SpeedButton4Click(Sender: TObject);
begin
    MapView.Zoom := MapView.Zoom + 1;
end;

procedure TFrmPrincipal.SpeedButton5Click(Sender: TObject);
begin
    MapView.Zoom := MapView.Zoom - 1;
end;

end.
