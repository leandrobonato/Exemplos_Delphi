object Dm: TDm
  OnCreate = DataModuleCreate
  Height = 294
  Width = 311
  object Conn: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    AfterConnect = ConnAfterConnect
    BeforeConnect = ConnBeforeConnect
    Left = 72
    Top = 56
  end
  object FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink
    Left = 192
    Top = 56
  end
  object qryUsuario: TFDQuery
    Connection = Conn
    Left = 72
    Top = 152
  end
  object TabUsuario: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 200
    Top = 152
  end
end
