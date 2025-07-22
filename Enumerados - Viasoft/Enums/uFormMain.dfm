object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'FormMain'
  ClientHeight = 435
  ClientWidth = 709
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 304
    Top = 8
    Width = 92
    Height = 13
    Caption = 'cxImageCombobox'
  end
  object Label2: TLabel
    Left = 304
    Top = 50
    Width = 92
    Height = 13
    Caption = 'cxImageCombobox'
  end
  object Label3: TLabel
    Left = 8
    Top = 8
    Width = 51
    Height = 13
    Caption = 'Combobox'
  end
  object Label4: TLabel
    Left = 8
    Top = 52
    Width = 63
    Height = 13
    Caption = 'CheckListBox'
  end
  object Button1: TButton
    Left = 159
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Fill'
    TabOrder = 0
    OnClick = Button1Click
  end
  object cbSituacao: TComboBox
    Left = 8
    Top = 24
    Width = 145
    Height = 22
    Style = csOwnerDrawFixed
    TabOrder = 1
    OnChange = cbSituacaoChange
  end
  object clbSituacao: TCheckListBox
    Left = 8
    Top = 68
    Width = 145
    Height = 69
    OnClickCheck = clbSituacaoClickCheck
    ItemHeight = 13
    TabOrder = 2
  end
  object rgSituacao: TRadioGroup
    Left = 8
    Top = 152
    Width = 145
    Height = 81
    Caption = 'RadioGroup'
    TabOrder = 3
    OnClick = rgSituacaoClick
  end
  object Button2: TButton
    Left = 159
    Top = 68
    Width = 75
    Height = 25
    Caption = 'Fill'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 159
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Fill'
    TabOrder = 5
    OnClick = Button3Click
  end
  object cxImageComboBox1: TcxImageComboBox
    Left = 304
    Top = 23
    RepositoryItem = dmRepos.ercbSituacaoCadastro
    Properties.Alignment.Horz = taLeftJustify
    Properties.Items = <>
    TabOrder = 6
    Width = 201
  end
  object cxImageComboBox2: TcxImageComboBox
    Left = 304
    Top = 64
    RepositoryItem = dmRepos.ercbSituacaoDF
    Properties.Items = <>
    TabOrder = 7
    Width = 201
  end
  object Button4: TButton
    Left = 159
    Top = 296
    Width = 75
    Height = 25
    Caption = 'DF'
    TabOrder = 8
    OnClick = Button4Click
  end
  object cxRadioGroup1: TcxRadioGroup
    Left = 304
    Top = 112
    RepositoryItem = dmRepos.errgSituacaoDF
    Caption = 'cxRadioGroup (SituacaoDF)'
    Properties.Items = <>
    TabOrder = 9
    Height = 121
    Width = 201
  end
end
