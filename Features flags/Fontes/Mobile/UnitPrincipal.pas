unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FMX.TabControl, FMX.Edit,
  FMX.Layouts, System.JSON, System.UIConsts;

type
  TFrmPrincipal = class(TForm)
    rectBtn: TRectangle;
    lblBtn: TLabel;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    Rectangle1: TRectangle;
    Label2: TLabel;
    Layout1: TLayout;
    edtUsuario: TEdit;
    btnVoltar: TImage;
    procedure Rectangle1Click(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure rectBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

procedure TFrmPrincipal.btnVoltarClick(Sender: TObject);
begin
    TabControl1.GotoVisibleTab(0);
end;

procedure TFrmPrincipal.Rectangle1Click(Sender: TObject);
var
    jsonStr : string;
    jsonObj : TJSONObject;
begin
    RESTRequest.Params.ParameterByName('usuario').Value := edtUsuario.Text;
    RESTRequest.Execute;

    if RESTRequest.Response.StatusCode <> 200 then
    begin
        showmessage('Ocorreu um erro na requisição');
        exit;
    end;

    jsonStr := RESTRequest.Response.JSONText;
    jsonObj := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(jsonStr), 0) as TJSONObject;

    // Montar as caracteristicas dos meus app em funcao do JSON retornado...
    rectBtn.Fill.Color := StringToAlphaColor(jsonObj.GetValue('buttomColor').Value);
    lblBtn.Text := jsonObj.GetValue('buttomText').Value;
    rectBtn.Tag := jsonObj.GetValue('buttomTag').Value.ToInteger;

    TabControl1.GotoVisibleTab(1);
end;

procedure TFrmPrincipal.rectBtnClick(Sender: TObject);
begin
    ShowMessage('Usou parametro: ' + rectBtn.Tag.ToString);
end;

end.
