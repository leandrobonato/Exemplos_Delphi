object DmGlobal: TDmGlobal
  OnCreate = DataModuleCreate
  Height = 480
  Width = 345
  object Conn: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    AfterConnect = ConnAfterConnect
    BeforeConnect = ConnBeforeConnect
    Left = 64
    Top = 48
  end
end
