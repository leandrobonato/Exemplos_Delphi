object DmGlobal: TDmGlobal
  OnCreate = DataModuleCreate
  Height = 357
  Width = 387
  object Conn: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    AfterConnect = ConnAfterConnect
    Left = 88
    Top = 64
  end
end
