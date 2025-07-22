object MainService: TMainService
  OldCreateOrder = False
  OnCreate = ServiceCreate
  DisplayName = 'Numbers'
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 179
  Width = 246
end
