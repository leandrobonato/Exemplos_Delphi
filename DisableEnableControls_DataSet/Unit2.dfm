object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 299
  ClientWidth = 827
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 821
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtn1: TBitBtn
      AlignWithMargins = True
      Left = 479
      Top = 3
      Width = 113
      Height = 35
      Align = alLeft
      Caption = 'Status dos controles'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      AlignWithMargins = True
      Left = 360
      Top = 3
      Width = 113
      Height = 35
      Align = alLeft
      Caption = 'Desabilitar controles'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      AlignWithMargins = True
      Left = 241
      Top = 3
      Width = 113
      Height = 35
      Align = alLeft
      Caption = 'Habilitar controles'
      TabOrder = 2
      OnClick = BitBtn3Click
    end
    object BitBtn4: TBitBtn
      AlignWithMargins = True
      Left = 122
      Top = 3
      Width = 113
      Height = 35
      Align = alLeft
      Caption = 'Fechar consulta'
      TabOrder = 3
      OnClick = BitBtn4Click
    end
    object BitBtn5: TBitBtn
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 113
      Height = 35
      Align = alLeft
      Caption = 'Abrir consulta'
      TabOrder = 4
      OnClick = BitBtn5Click
    end
  end
  object NavigatorPrototypeBindSource1: TBindNavigator
    AlignWithMargins = True
    Left = 3
    Top = 253
    Width = 821
    Height = 43
    DataSource = BindSourceDB1
    Align = alBottom
    Orientation = orHorizontal
    TabOrder = 1
    OnClick = NavigatorPrototypeBindSource1Click
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 47
    Width = 827
    Height = 203
    Align = alClient
    DataSource = DataSource1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Bitmap_Name'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Color_Name'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Color_Int'
        Visible = True
      end>
  end
  object PrototypeBindSource1: TPrototypeBindSource
    AutoActivate = True
    AutoEdit = False
    AutoPost = False
    FieldDefs = <
      item
        Name = 'Bitmap_Name'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'Color_Int'
        FieldType = ftUInteger
        Generator = 'Colors'
        ReadOnly = False
      end
      item
        Name = 'Colors_Name'
        Generator = 'ColorsNames'
        ReadOnly = False
      end>
    ScopeMappings = <>
    Left = 539
    Top = 75
  end
  object ClientDataSet1: TClientDataSet
    PersistDataPacket.Data = {
      6B0000009619E0BD0100000018000000030000000000030000006B000B426974
      6D61705F4E616D65010049000000010005574944544802000200780009436F6C
      6F725F496E7404000100000000000A436F6C6F725F4E616D6501004900000001
      000557494454480200020078000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 440
    Top = 72
    object ClientDataSet1Bitmap_Name: TStringField
      DisplayWidth = 42
      FieldName = 'Bitmap_Name'
      Size = 120
    end
    object ClientDataSet1Color_Int: TIntegerField
      DisplayWidth = 10
      FieldName = 'Color_Int'
    end
    object ClientDataSet1Color_Name: TStringField
      DisplayWidth = 69
      FieldName = 'Color_Name'
      Size = 120
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 440
    Top = 144
  end
  object BindSourceDB1: TBindSourceDB
    DataSource = DataSource1
    ScopeMappings = <>
    Left = 440
    Top = 192
  end
end
