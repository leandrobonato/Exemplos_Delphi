object DmServices: TDmServices
  Encoding = esUtf8
  QueuedRequest = False
  Height = 362
  Width = 375
  object ServerEvents: TRESTDWServerEvents
    IgnoreInvalidParams = False
    Events = <
      item
        Routes = [crAll]
        NeedAuthorization = True
        Params = <>
        DataMode = dmRAW
        Name = 'messages'
        EventName = 'messages'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEventByType = ServerEventsEventsmessagesReplyEventByType
      end>
    Left = 72
    Top = 48
  end
end
