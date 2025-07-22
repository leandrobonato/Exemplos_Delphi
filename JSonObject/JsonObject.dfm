object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 300
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TSpeedButton
    Left = 312
    Top = 104
    Width = 145
    Height = 78
    OnClick = btn1Click
  end
  object rest: TRESTClient
    Params = <>
    Left = 176
    Top = 32
  end
  object request: TRESTRequest
    Client = rest
    Method = rmPOST
    Params = <>
    Response = response
    SynchronizedEvents = False
    Left = 287
    Top = 32
  end
  object response: TRESTResponse
    Left = 231
    Top = 32
  end
end
