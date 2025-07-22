unit Refactor.Model.DAO.Categoria.Test;

interface

uses
  DUnitX.TestFramework,
  Refactor.Model.Interfaces,
  Refactor.Model;

type
  [TestFixture]
  TModelDAOCategoriaTest = class
  private
    FModel : iModelInterface;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure ValidateFields;
    [Test]
    procedure Insert;
    [Test]
    procedure Get;
    [Test]
    procedure ValidateGetResult;
    [Test]
    procedure Update;
    [Test]
    procedure Delete;
  end;

implementation

uses
  Vcl.Graphics;

const
  _DESCRICAO = 'DUnitX999';
  _INDICE_ICONE = 9999;

procedure TModelDAOCategoriaTest.Delete;
begin
  FModel.DAO.Categorias.Get('DESCRICAO', _DESCRICAO + 'Update');
  Assert
    .WillNotRaise(
      procedure
      begin
        FModel.DAO
        .Categorias
          .This
            .ID_CATEGORIA(
              FModel.DAO.Categorias.DataSet.FieldByName('ID_CATEGORIA').AsInteger
            )
          .&End
        .Delete
      end,
      nil,
      'TModelDAOCategoria.Delete Erro na Exclusão de Dados'
  )
end;

procedure TModelDAOCategoriaTest.Get;
begin
  Assert.WillNotRaise(
    procedure
    begin
      FModel.DAO.Categorias.Get('DESCRICAO', _DESCRICAO);
    end,
    nil,
    'TModelDAOCategoria.Get Erro na Consulta de Dados'
  );
end;

procedure TModelDAOCategoriaTest.Insert;
var
  vBitmap : TBitmap;
begin
  vBitmap := TBitmap.Create;
  vBitmap.LoadFromResourceName(HInstance, 'ImageTeste');
  try
    Assert.WillNotRaise(
      procedure
      begin
        FModel
          .DAO
            .Categorias
              .This
                .DESCRICAO('DUnitX999')
                .INDICE_ICONE(9999)
                .ICONE(vBitmap)
              .&End
            .Insert;
      end,
      nil,
      'TModelDAOCategoria.Insert Erro na Inserção de Dados'
    );
  finally
    vBitmap.Free;
  end;
end;

procedure TModelDAOCategoriaTest.Setup;
begin
  FModel := TRefactorModel.New;
end;

procedure TModelDAOCategoriaTest.TearDown;
begin
end;

procedure TModelDAOCategoriaTest.Update;
var
  vBitmap : TBitmap;
begin
  vBitmap := TBitmap.Create;
  vBitmap.LoadFromResourceName(HInstance, 'ImageTeste');
  try
    FModel.DAO.Categorias.Get('DESCRICAO', _DESCRICAO);
    Assert
      .WillNotRaise(
        procedure
        begin
          FModel.DAO
          .Categorias
            .This
              .ID_CATEGORIA(
                FModel.DAO.Categorias.DataSet.FieldByName('ID_CATEGORIA').AsInteger
              )
              .DESCRICAO(_DESCRICAO + 'Update')
              .ICONE(vBitmap)
              .INDICE_ICONE(_INDICE_ICONE)
            .&End
          .Update
        end,
        nil,
        'TModelDAOCategoria.Update Erro na Atualização de Dados'
    )
  finally
    vBitmap.Free;
  end;
end;

procedure TModelDAOCategoriaTest.ValidateFields;
begin
  FModel.DAO.Categorias.This.DESCRICAO('');
  Assert.WillRaise(
    procedure
    begin
      FModel.DAO.Categorias.This.DESCRICAO;
    end,
    nil,
    'TCategoria.Descricao não pode aceitar valor vazio'
  );
end;

procedure TModelDAOCategoriaTest.ValidateGetResult;
begin
  FModel.DAO.Categorias.Get('DESCRICAO', _DESCRICAO);

  Assert.IsTrue(
    FModel.DAO.Categorias.DataSet.FieldByName('INDICE_ICONE').AsInteger = _INDICE_ICONE,
    'TDAOCategoria.Get Indice Icone não corresponde ao valor inserido'
  );

  Assert.IsNotNull(
    FModel.DAO.Categorias.DataSet.FieldByName('ICONE').AsVariant,
    'TDAOCategoria.Get Icone não corresponde ao valor inserido'
  );
end;

initialization
  TDUnitX.RegisterTestFixture(TModelDAOCategoriaTest);

end.
