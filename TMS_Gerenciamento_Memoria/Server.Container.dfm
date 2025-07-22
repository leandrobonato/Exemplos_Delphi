object ServerContainer: TServerContainer
  OldCreateOrder = False
  Height = 210
  Width = 431
  object SparkleHttpSysDispatcher: TSparkleHttpSysDispatcher
    Active = True
    Left = 72
    Top = 16
  end
  object XDataServer: TXDataServer
    BaseUrl = 'http://+:2001/tms/xdata'
    Dispatcher = SparkleHttpSysDispatcher
    Pool = XDataConnectionPool
    EntitySetPermissions = <>
    Left = 216
    Top = 16
  end
  object XDataConnectionPool: TXDataConnectionPool
    Connection = AureliusConnection
    Left = 216
    Top = 72
  end
  object AureliusConnection: TAureliusConnection
    AdapterName = 'FireDac'
    AdaptedConnection = FDConnection1
    SQLDialect = 'Sqlite'
    Params.Strings = (
      'Database=.\banco.sqlite'
      'EnableForeignKeys=True')
    Left = 216
    Top = 128
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\ronaldo\Documents\Embarcadero\Studio\Projects\' +
        'TMS_Gerenciamento_Memoria\banco.sqlite'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 344
    Top = 96
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 336
    Top = 24
  end
end
