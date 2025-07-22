object dmDF: TdmDF
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object mdNF: TJvMemoryData
    FieldDefs = <>
    OnCalcFields = mdNFCalcFields
    Left = 88
    Top = 56
    object mdNFID: TAutoIncField
      FieldName = 'ID'
    end
    object mdNFNUMERO: TIntegerField
      FieldName = 'NUMERO'
    end
    object mdNFSITUACAO: TStringField
      FieldName = 'SITUACAO'
      Size = 5
    end
    object mdNFDESC_SITUACAO: TStringField
      FieldKind = fkCalculated
      FieldName = 'DESC_SITUACAO'
      Size = 100
      Calculated = True
    end
  end
end
