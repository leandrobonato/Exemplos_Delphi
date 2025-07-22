object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 292
  Width = 355
  object conn: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 64
    Top = 40
  end
  object RESTClientBackup: TRESTClient
    Accept = '*/*'
    AcceptCharset = 'utf-8, *;q=0.8'
    AcceptEncoding = 'deflate, gzip'
    BaseURL = 'http://192.168.0.105:9000'
    ContentType = 'application/octet-stream'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 64
    Top = 110
  end
  object ReqBackup: TRESTRequest
    Client = RESTClientBackup
    Method = rmPOST
    Params = <>
    Resource = 'backup'
    SynchronizedEvents = False
    Left = 160
    Top = 110
  end
  object qry: TFDQuery
    Connection = conn
    Left = 160
    Top = 40
  end
  object RESTClientRestore: TRESTClient
    Accept = '*/*'
    AcceptCharset = 'utf-8, *;q=0.8'
    AcceptEncoding = 'deflate, gzip'
    BaseURL = 'http://192.168.0.105:9000'
    ContentType = 'application/json'
    Params = <>
    Left = 64
    Top = 192
  end
  object ReqRestore: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClientRestore
    Params = <>
    Resource = 'restore'
    SynchronizedEvents = False
    Left = 160
    Top = 192
  end
end
