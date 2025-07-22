object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 672
  ClientWidth = 1096
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1096
    Height = 672
    ActivePage = ts1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Serializar'
      object btnSerializar: TButton
        Left = 0
        Top = 0
        Width = 1088
        Height = 24
        Align = alTop
        Caption = 'Serializar'
        TabOrder = 0
        OnClick = btnSerializarClick
      end
      object Memo3: TMemo
        Left = 0
        Top = 24
        Width = 521
        Height = 620
        Align = alLeft
        TabOrder = 1
      end
      object Memo4: TMemo
        Left = 521
        Top = 24
        Width = 567
        Height = 620
        Align = alClient
        Lines.Strings = (
          'Memo2')
        TabOrder = 2
      end
    end
    object ts1: TTabSheet
      Caption = 'Desserializar'
      ImageIndex = 1
      object Memo1: TMemo
        Left = 0
        Top = 24
        Width = 593
        Height = 620
        Align = alLeft
        TabOrder = 0
      end
      object btnDesserializar: TButton
        Left = 0
        Top = 0
        Width = 1088
        Height = 24
        Align = alTop
        Caption = 'Desserializar'
        TabOrder = 1
        OnClick = btnDesserializarClick
      end
      object Memo2: TMemo
        Left = 593
        Top = 24
        Width = 495
        Height = 620
        Align = alClient
        Lines.Strings = (
          'Memo2')
        TabOrder = 2
      end
    end
  end
  object ZConnection1: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    Properties.Strings = (
      'RawStringEncoding=DB_CP')
    Connected = True
    HostName = 'localhost'
    Port = 0
    Database = 'C:\SoftSig\Banco\DADOS.GDB'
    User = 'sysdba'
    Password = 'masterkey'
    Protocol = 'firebird'
    Left = 592
    Top = 64
  end
  object ZQuery1: TZQuery
    Connection = ZConnection1
    Params = <
      item
        DataType = ftString
        Name = 'dados'
        SQLType = stString
      end>
    Left = 584
    Top = 144
    ParamData = <
      item
        DataType = ftString
        Name = 'dados'
        SQLType = stString
      end>
  end
  object DataSource1: TDataSource
    DataSet = ZQuery1
    Left = 592
    Top = 208
  end
  object cds1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 712
    Top = 120
  end
end
