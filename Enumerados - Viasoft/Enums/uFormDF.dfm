object FormDF: TFormDF
  Left = 0
  Top = 0
  Caption = 'FormDF'
  ClientHeight = 449
  ClientWidth = 732
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 732
    Height = 449
    ActivePage = TabSheet4
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Cadastro'
      object Label1: TLabel
        Left = 3
        Top = 56
        Width = 11
        Height = 13
        Caption = 'ID'
      end
      object Label2: TLabel
        Left = 130
        Top = 56
        Width = 37
        Height = 13
        Caption = 'N'#250'mero'
      end
      object Label3: TLabel
        Left = 257
        Top = 56
        Width = 41
        Height = 13
        Caption = 'Situa'#231#227'o'
      end
      object cxDBNavigator1: TcxDBNavigator
        Left = 0
        Top = 0
        Width = 720
        Height = 30
        Buttons.CustomButtons = <>
        DataSource = dsNF
        Align = alTop
        TabOrder = 0
      end
      object cxDBTextEdit1: TcxDBTextEdit
        Left = 3
        Top = 72
        DataBinding.DataField = 'ID'
        DataBinding.DataSource = dsNF
        TabOrder = 1
        Width = 121
      end
      object cxDBTextEdit2: TcxDBTextEdit
        Left = 130
        Top = 72
        DataBinding.DataField = 'NUMERO'
        DataBinding.DataSource = dsNF
        TabOrder = 2
        Width = 121
      end
      object cxDBImageComboBox1: TcxDBImageComboBox
        Left = 257
        Top = 72
        RepositoryItem = dmRepos.ercbSituacaoDF
        DataBinding.DataField = 'SITUACAO'
        DataBinding.DataSource = dsNF
        Properties.Items = <>
        TabOrder = 3
        Width = 182
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'cxGrid DevExpress'
      ImageIndex = 1
      object cxGrid1: TcxGrid
        Left = 0
        Top = 0
        Width = 724
        Height = 421
        Align = alClient
        TabOrder = 0
        object cxGrid1DBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = dsNF
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsView.GroupByBox = False
          object cxGrid1DBTableView1ID: TcxGridDBColumn
            DataBinding.FieldName = 'ID'
            DataBinding.IsNullValueType = True
            Width = 75
          end
          object cxGrid1DBTableView1NUMERO: TcxGridDBColumn
            DataBinding.FieldName = 'NUMERO'
            DataBinding.IsNullValueType = True
            Width = 92
          end
          object cxGrid1DBTableView1SITUACAO: TcxGridDBColumn
            DataBinding.FieldName = 'SITUACAO'
            DataBinding.IsNullValueType = True
            RepositoryItem = dmRepos.ercbSituacaoDF
            Width = 160
          end
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = cxGrid1DBTableView1
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'DBGrid'
      ImageIndex = 2
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 724
        Height = 421
        Align = alClient
        DataSource = dsNF
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'ID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NUMERO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SITUACAO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESC_SITUACAO'
            Title.Caption = 'DESC_SITUACAO (CalcField)'
            Width = 153
            Visible = True
          end>
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'StringGrid'
      ImageIndex = 3
      object sgNF: TStringGrid
        Left = 0
        Top = 0
        Width = 724
        Height = 421
        Align = alClient
        ColCount = 1
        FixedCols = 0
        RowCount = 2
        TabOrder = 0
        ColWidths = (
          106)
        RowHeights = (
          24
          24)
      end
    end
  end
  object dsNF: TDataSource
    DataSet = dmDF.mdNF
    Left = 680
    Top = 32
  end
  object BindSourceDB1: TBindSourceDB
    DataSet = dmDF.mdNF
    ScopeMappings = <>
    Left = 616
    Top = 96
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 620
    Top = 37
    object LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource
      Category = 'Quick Bindings'
      DataSource = BindSourceDB1
      GridControl = sgNF
      Columns = <>
    end
  end
end
