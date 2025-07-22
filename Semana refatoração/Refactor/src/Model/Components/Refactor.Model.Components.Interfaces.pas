unit Refactor.Model.Components.Interfaces;

interface

uses
  Refactor.Model.Components.Connections.Interfaces;

type
  iModelComponentsFactory = interface
    ['{92675C9D-C11D-4430-92B3-54435216FCF1}']
    function Connection : iModelComponentsConnections;
  end;

implementation

end.
