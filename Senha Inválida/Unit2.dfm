object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 109
  ClientWidth = 242
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 8
    Top = 64
    Width = 105
    Height = 25
    Caption = 'Senha Inv'#225'lida'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 119
    Top = 64
    Width = 106
    Height = 25
    Caption = 'Senha V'#225'lida'
    TabOrder = 1
  end
  object MaskEdit1: TMaskEdit
    Left = 48
    Top = 24
    Width = 121
    Height = 21
    Color = clWhite
    TabOrder = 2
    Text = 'MaskEdit1'
  end
end
