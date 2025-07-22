object Form1: TForm1
  Left = 0
  Top = 0
  ClientHeight = 654
  ClientWidth = 520
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 0
    Top = 629
    Width = 520
    Height = 25
    Align = alBottom
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 75
  end
  object lstEstacoes: TListView
    Left = 0
    Top = 273
    Width = 520
    Height = 356
    Align = alClient
    Columns = <
      item
        Caption = 'Nome do usu'#225'rio'
      end
      item
        Caption = 'Endere'#231'o de IP'
      end>
    TabOrder = 1
    ViewStyle = vsReport
    ExplicitTop = 281
    ExplicitWidth = 716
    ExplicitHeight = 348
  end
  object listaUsuarios: TListBox
    Left = 0
    Top = 0
    Width = 520
    Height = 273
    Align = alTop
    ItemHeight = 13
    TabOrder = 2
  end
end
