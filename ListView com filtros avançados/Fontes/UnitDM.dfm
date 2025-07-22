object Dm: TDm
  OnCreate = DataModuleCreate
  Height = 483
  Width = 397
  object Conn: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    AfterConnect = ConnAfterConnect
    BeforeConnect = ConnBeforeConnect
    Left = 64
    Top = 64
  end
  object qryPedido: TFDQuery
    Connection = Conn
    Left = 208
    Top = 64
  end
end
