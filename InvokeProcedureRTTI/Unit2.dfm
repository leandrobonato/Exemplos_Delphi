object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 545
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TButton
    Left = 344
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Value 1'
    TabOrder = 0
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 344
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Value 2'
    TabOrder = 1
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 344
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Value 3'
    TabOrder = 2
    OnClick = btn3Click
  end
  object edt1: TEdit
    Left = 112
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'edt1'
  end
  object edt2: TEdit
    Left = 112
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'edt2'
  end
  object edt3: TEdit
    Left = 112
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 5
    Text = 'edt3'
  end
  object btnTesteLeandro: TBitBtn
    Left = 344
    Top = 120
    Width = 75
    Height = 25
    Caption = 'btnTesteLeandro'
    TabOrder = 6
    OnClick = btnTesteLeandroClick
  end
  object cxGrid1: TcxGrid
    Left = 32
    Top = 176
    Width = 545
    Height = 337
    TabOrder = 7
    object GridTVGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = ds1
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      object cxColumnTeste: TcxGridDBColumn
        DataBinding.FieldName = 'TESTE'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = cxGridTVGrid1DBTableView1Column1PropertiesButtonClick
        Width = 108
      end
    end
    object gridLVGrid1Level1: TcxGridLevel
      GridView = GridTVGrid1DBTableView1
    end
  end
  object ds1: TDataSource
    DataSet = cds1
    Left = 496
    Top = 144
  end
  object cds1: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 496
    Top = 88
    Data = {
      340000009619E0BD010000001800000001000000000003000000340005544553
      544501004900000001000557494454480200020078000000}
    object strngfldcds1TESTE: TStringField
      FieldName = 'TESTE'
      Size = 120
    end
  end
  object prtypbndsrc1: TPrototypeBindSource
    AutoActivate = True
    RecordCount = 100
    FieldDefs = <
      item
        Name = 'ColorsName1'
        Generator = 'ColorsNames'
        ReadOnly = False
      end>
    ScopeMappings = <>
    Left = 496
    Top = 16
  end
end
