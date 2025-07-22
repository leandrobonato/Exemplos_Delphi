object dm: Tdm
  OldCreateOrder = False
  Encoding = esUtf8
  Height = 150
  Width = 215
  object ServerEvents: TDWServerEvents
    IgnoreInvalidParams = False
    Events = <
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'flags'
        EventName = 'flags'
        OnlyPreDefinedParams = False
        OnReplyEventByType = ServerEventsEventsflagsReplyEventByType
      end>
    Left = 40
    Top = 24
  end
end
