unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.TabControl;

type
  TForm1 = class(TForm)
    NetHTTPClient1: TNetHTTPClient;
    NetHTTPRequest1: TNetHTTPRequest;
    OpenDialog1: TOpenDialog;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    imgResponse: TImage;
    MemoResponse: TMemo;
    imgRequest: TImage;
    Button2: TButton;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  path: String;
  ColorizedImagePath: String;

implementation

uses
  System.Net.Mime, System.JSON, System.Threading;

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
//  Label2.Text := ColorizedImagePath;
  TTask.Run(
    procedure
    var
      LResponse: TMemoryStream;
    begin
      LResponse := TMemoryStream.Create;
      try
        NetHTTPClient1.Get(ColorizedImagePath, LResponse);
        TThread.Synchronize(nil,
          procedure
          begin
            imgResponse.Bitmap.LoadFromStream(LResponse);
          end);
      finally
        LResponse.Free;
        TabControl1.GotoVisibleTab(2)
      end;
    end);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  OpenDialog1.Execute;
  TTask.Run(
    procedure
    var
      LMultipartFormData: TMultipartFormData;
      LMS: TMemoryStream;
      header: TNameValuePair;
      Json: TJSONObject;
    begin
      LMultipartFormData := TMultipartFormData.Create;
      header := TNameValuePair.Create('api-key',
        '5a84f646-474f-4b86-ab69-a7a5ef0ad537');
        //'3dbda16f-ce35-44a4-8cdc-a74e72ae3358');
      path := OpenDialog1.FileName;
      LMultipartFormData.AddFile('image', path, 'application/octet-stream');
      imgRequest.Bitmap.LoadFromFile(path);
      LMS := TMemoryStream.Create;
      NetHTTPRequest1.Post('https://api.deepai.org/api/colorizer', LMultipartFormData, LMS, [header]);
      TThread.Synchronize(nil,
        procedure
        begin
          memoResponse.Lines.LoadFromStream(LMS);
          TabControl1.GotoVisibleTab(1)
        end);
      Json := TJSONObject.ParseJSONValue(memoResponse.Text) as TJSONObject;
      TThread.Synchronize(nil,
        procedure
        begin
          ColorizedImagePath := Json.GetValue('output_url').Value;
        end);
      LMS.Free;
      LMultipartFormData.Free;
    end);
end;

end.
