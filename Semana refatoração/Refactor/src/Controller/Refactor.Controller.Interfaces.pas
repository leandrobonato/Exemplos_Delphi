unit Refactor.Controller.Interfaces;

interface

uses
  Refactor.Model.DAO.Interfaces,
  Refactor.Model.Entities.Categoria,
  Refactor.Model.Entities.Users;

type
  iControllerEntities = interface;
  iControllerServices = interface;

  iController = interface
    ['{59D969EB-EDF8-450F-9B73-7D4E864A99BB}']
    function Entities : iControllerEntities;
    function Services : iControllerServices;
  end;

  iControllerEntities = interface
    ['{7326B40D-7E7F-47F5-A23B-A59FFE24D0F4}']
    function Categorias : iModelDAOEntity<TCategoria>;
    function Users : iModelDAOEntity<TUsers>;
  end;

  iControllerServicesGeneric = interface
    ['{75931F19-2C6A-415F-B4E8-D9C56A96DC30}']
    function Consultar : iControllerServicesGeneric;
    function Enviar : iControllerServicesGeneric;
    function Validar : iControllerServicesGeneric;
  end;

  iControllerServices = interface
    ['{BA3046AF-36B6-434B-BD07-10174D0CA677}']
    function MercadoLivre : iControllerServicesGeneric;
    function NFe : iControllerServicesGeneric;
    function NFSe : iControllerServicesGeneric;
    function Boleto : iControllerServicesGeneric;
  end;

implementation

end.
