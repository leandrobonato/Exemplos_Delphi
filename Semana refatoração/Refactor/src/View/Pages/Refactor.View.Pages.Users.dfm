object PageUsers: TPageUsers
  Left = 0
  Top = 0
  Caption = 'PageUsers'
  ClientHeight = 383
  ClientWidth = 521
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 24
  object Edit1: TEdit
    Left = 16
    Top = 24
    Width = 457
    Height = 32
    TabOrder = 0
    Text = 'Edit1'
  end
  object Button2: TButton
    Left = 261
    Top = 308
    Width = 89
    Height = 39
    Caption = 'Inserir'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button1: TButton
    Left = 13
    Top = 308
    Width = 90
    Height = 39
    Caption = 'Listar'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 102
    Top = 308
    Width = 81
    Height = 39
    Caption = 'Update'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 183
    Top = 308
    Width = 80
    Height = 39
    Caption = 'Delete'
    TabOrder = 4
    OnClick = Button4Click
  end
  object DBGrid1: TDBGrid
    Left = 16
    Top = 62
    Width = 457
    Height = 240
    DataSource = DataSource1
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -20
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DataSource1: TDataSource
    Left = 408
    Top = 80
  end
end
