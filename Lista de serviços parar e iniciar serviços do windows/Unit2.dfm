object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 580
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object pnlInfoServices: TPanel
    Left = 0
    Top = 225
    Width = 482
    Height = 355
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 152
    ExplicitTop = 272
    ExplicitWidth = 185
    ExplicitHeight = 41
  end
  object pnlStartStopService: TPanel
    Left = 0
    Top = 0
    Width = 482
    Height = 225
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 515
    object shpStatus: TShape
      Left = 152
      Top = 112
      Width = 185
      Height = 65
    end
    object btnStartServer: TBitBtn
      Left = 48
      Top = 24
      Width = 177
      Height = 57
      Caption = 'Start Server'
      TabOrder = 0
      OnClick = btnStartServerClick
    end
    object btnStopSerrver: TBitBtn
      Left = 264
      Top = 24
      Width = 177
      Height = 57
      Caption = 'Stop Server'
      TabOrder = 1
      OnClick = btnStopSerrverClick
    end
    object btnProcurar: TBitBtn
      Left = 24
      Top = 176
      Width = 75
      Height = 25
      Caption = 'btnProcurar'
      TabOrder = 2
    end
  end
end
