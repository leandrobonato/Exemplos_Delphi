object frmComparadorArquivos: TfrmComparadorArquivos
  Left = 0
  Top = 0
  Caption = 'frmComparadorArquivos'
  ClientHeight = 505
  ClientWidth = 1502
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 120
  TextHeight = 16
  object pnlCabecalho: TPanel
    Left = 0
    Top = 0
    Width = 1502
    Height = 65
    Align = alTop
    TabOrder = 0
    object btnComparar: TButton
      Left = 339
      Top = 1
      Width = 169
      Height = 63
      Align = alLeft
      Caption = 'Salvar'
      TabOrder = 2
    end
    object btnCarregarArquivos: TButton
      Left = 170
      Top = 1
      Width = 169
      Height = 63
      Align = alLeft
      Caption = 'Comparar'
      TabOrder = 1
      OnClick = btnCarregarArquivosClick
    end
    object btnSalvar: TButton
      Left = 1
      Top = 1
      Width = 169
      Height = 63
      Align = alLeft
      Caption = 'Carregar arquivos'
      TabOrder = 0
      OnClick = btnSalvarClick
    end
    object btnLimpar: TButton
      Left = 508
      Top = 1
      Width = 169
      Height = 63
      Align = alLeft
      Caption = 'Limpar'
      TabOrder = 3
      OnClick = btnLimparClick
      ExplicitLeft = 747
      ExplicitTop = 9
    end
  end
  object pnlArquivo1: TPanel
    Left = 0
    Top = 65
    Width = 500
    Height = 440
    Align = alLeft
    Caption = 'Arquivo 1'
    TabOrder = 1
    VerticalAlignment = taAlignTop
    object mmoArquivo1: TMemo
      AlignWithMargins = True
      Left = 4
      Top = 21
      Width = 492
      Height = 415
      Margins.Top = 20
      Align = alClient
      Color = 15790320
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
  object pnlArquivo2: TPanel
    Left = 500
    Top = 65
    Width = 500
    Height = 440
    Align = alLeft
    Caption = 'Arquivo 2'
    TabOrder = 2
    VerticalAlignment = taAlignTop
    object mmoArquivo2: TMemo
      AlignWithMargins = True
      Left = 4
      Top = 21
      Width = 492
      Height = 415
      Margins.Top = 20
      Align = alClient
      Color = 15790320
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
  object pnlDiferenca: TPanel
    Left = 1000
    Top = 65
    Width = 500
    Height = 440
    Align = alLeft
    Caption = 'Diferen'#231'as'
    TabOrder = 3
    VerticalAlignment = taAlignTop
    object mmoDiferenca: TMemo
      AlignWithMargins = True
      Left = 4
      Top = 21
      Width = 492
      Height = 415
      Margins.Top = 20
      Align = alClient
      Color = 15790320
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
end
