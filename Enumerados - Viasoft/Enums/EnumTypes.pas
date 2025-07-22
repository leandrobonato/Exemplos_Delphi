unit EnumTypes;

interface

uses
  EnumHelper, pcnConversao;

type

  [TEnum('S','Sim')]
  [TEnum('N','Não')]
  TSimNao = (snSim, snNao);

  [TEnum('ATV','Ativo')]
  [TEnum('INT','Inativo')]
  [TEnum('CAN','Cancelado')]
  [TEnum('DES','Desatualizado')]
  [TEnum('','Todos')]
  TSituacaoCadastro = (scAtivo,
                       scInativo,
                       scCancelado,
                       scDesatualizado,
                       scTodos);
  [TEnum('ATV','Ativo')]
  [TEnum('INT','Inativo')]
  [TEnum('CAN','Cancelado')]
  [TEnum('DES','Desatualizado')]
  TSituacaoCadastroSel = scAtivo..scDesatualizado;

  [TEnum('EMI','Emitido', -1, 0)]
  [TEnum('AUT','Autorizado', Integer(TSituacaoDFe.snAutorizado), 1)]
  [TEnum('INU','Inutilizado', Integer(TSituacaoDFe.snDenegado), 3)]
  [TEnum('CAN','Cancelado', Integer(TSituacaoDFe.snCancelado), 2)]
  [TEnum('DEN','Denegado', Integer(TSituacaoDFe.snDenegado), 3)]
  [TEnum('','Todos', -1, 4)]
  TSituacaoDF = (sdfEmitido,
                 sdfAutorizado,
                 sdfInutilizado,
                 sdfCancelado,
                 sdfDenegado,
                 sdfTodos);

  const TSituacaoCadastroCad: array of TSituacaoCadastro = [scAtivo, scInativo, scCancelado, scDesatualizado];
  const TSituacaoDFCad: array of TSituacaoDF = [sdfEmitido, sdfAutorizado, sdfCancelado, sdfDenegado];

implementation


end.
