object frmDataModule: TfrmDataModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 469
  Width = 769
  object fdConexãoSQLite: TFDConnection
    Params.Strings = (
      
        'Database=S:\Aplicativos Mobile\Mobile cria'#231#227'o automatica de base' +
        '\Win32\Debug\BD\SQLite.s3db'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 40
    Top = 24
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 128
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 224
    Top = 24
  end
  object fdQrySQLite: TFDQuery
    Connection = fdConexãoSQLite
    SQL.Strings = (
      'SELECT * FROM TESTE;')
    Left = 40
    Top = 80
  end
  object dsSqlite: TDataSource
    DataSet = fdQrySQLite
    Left = 40
    Top = 144
  end
end
