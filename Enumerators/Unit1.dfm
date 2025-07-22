object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 267
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 80
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Ord'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 296
    Top = 120
    Width = 75
    Height = 25
    Caption = 'GetEnum'
    TabOrder = 1
  end
  object ComboBox1: TComboBox
    Left = 136
    Top = 24
    Width = 145
    Height = 21
    TabOrder = 2
    Text = 'ComboBox1'
  end
end
