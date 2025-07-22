object Dm: TDm
  OnCreate = DataModuleCreate
  Height = 368
  Width = 353
  object Conn: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    AfterConnect = ConnAfterConnect
    BeforeConnect = ConnBeforeConnect
    Left = 64
    Top = 48
  end
  object qryCliente: TFDQuery
    Connection = Conn
    Left = 168
    Top = 48
  end
end
