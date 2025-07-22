object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 395
  Width = 282
  object conn: TFDConnection
    Params.Strings = (
      'LockingMode=Normal'
      'DriverID=SQLite')
    LoginPrompt = False
    AfterConnect = connAfterConnect
    BeforeConnect = connBeforeConnect
    Left = 64
    Top = 32
  end
  object qry: TFDQuery
    Connection = conn
    Left = 160
    Top = 32
  end
end
