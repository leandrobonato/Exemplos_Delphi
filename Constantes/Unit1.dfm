object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 259
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
  object pgc1: TPageControl
    Left = 0
    Top = 0
    Width = 635
    Height = 259
    ActivePage = ts2
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 32
    ExplicitTop = 80
    ExplicitWidth = 289
    ExplicitHeight = 193
    object ts1: TTabSheet
      Caption = 'ts1'
      ExplicitLeft = 0
      ExplicitWidth = 281
      ExplicitHeight = 165
      object btn1: TButton
        Left = 0
        Top = 0
        Width = 627
        Height = 25
        Align = alTop
        Caption = 'btn1'
        TabOrder = 0
        OnClick = btn1Click
        ExplicitTop = 8
      end
      object mmo1: TMemo
        Left = 0
        Top = 25
        Width = 627
        Height = 206
        Align = alClient
        Lines.Strings = (
          'mmo1')
        TabOrder = 1
        ExplicitWidth = 635
        ExplicitHeight = 234
      end
    end
    object ts2: TTabSheet
      Caption = 'ts2'
      ImageIndex = 1
      ExplicitWidth = 281
      ExplicitHeight = 165
      object btn2: TButton
        Left = 112
        Top = 56
        Width = 75
        Height = 25
        Caption = 'btn2'
        TabOrder = 0
        OnClick = btn2Click
      end
    end
  end
end
