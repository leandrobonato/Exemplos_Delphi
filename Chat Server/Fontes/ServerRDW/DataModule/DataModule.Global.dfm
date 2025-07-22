object DmGlobal: TDmGlobal
  OnCreate = DataModuleCreate
  Height = 406
  Width = 385
  object Conn: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    AfterConnect = ConnAfterConnect
    BeforeConnect = ConnBeforeConnect
    Left = 96
    Top = 40
  end
end
