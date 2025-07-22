object Dm: TDm
  OnCreate = DataModuleCreate
  Height = 609
  Width = 398
  object Conn: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    AfterConnect = ConnAfterConnect
    BeforeConnect = ConnBeforeConnect
    Left = 72
    Top = 56
  end
  object qryProduto: TFDQuery
    Connection = Conn
    Left = 208
    Top = 56
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 72
    Top = 160
  end
end
