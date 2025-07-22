unit Refactor.Model.Interfaces;

interface

uses
  Refactor.Model.DAO.Factory,
  Refactor.Model.Components.Interfaces;

type

  iModelInterface = interface
    ['{DA331FE1-B3FA-4671-BA29-2F317AD6EB9C}']
    function Components : iModelComponentsFactory;
    function DAO : iModelDAOFactory;
    //function Entities : iModelEntitiesFactory;
  end;

implementation

end.
