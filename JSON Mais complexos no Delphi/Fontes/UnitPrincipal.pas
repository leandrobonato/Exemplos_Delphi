unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.StdCtrls, FMX.Layouts, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  FMX.TabControl, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,

  DataSet.Serialize.Config, DataSet.Serialize, System.JSON;

type
  TFrmPrincipal = class(TForm)
    mJson: TMemo;
    Layout1: TLayout;
    btnProcessar: TButton;
    Conn: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    qry: TFDQuery;
    qryDetalhe: TFDQuery;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure btnProcessarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    procedure Log(str: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
    Conn.Params.Values['DriverID'] := 'SQLite';

    // Mudar na sua maquina -------
    Conn.Params.Values['Database'] := 'D:\99Coders\Posts\378 - Como gerar JSON mais complexos no Delphi\Fontes\DB\banco.db';
    //-----------------------------

    try
        Conn.Connected := true;
    except on e:exception do
        raise Exception.Create('Erro de conexão com o banco de dados: ' + e.Message);
    end;

    TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
    TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';
end;

procedure TFrmPrincipal.Log(str: string);
begin
    mJson.Lines.Clear;
    mJson.Text := str;
end;

procedure TFrmPrincipal.btnProcessarClick(Sender: TObject);
var
    json: TJSONObject;
    arrItem, arrDetalhe: TJSONArray;
    i: integer;
begin
    // Itens...
    qry.SQL.Add('select id, descricao, qtd, total from tab_pedido_item where pedido = 52148');
    qry.Active := true;
    arrItem := qry.ToJSONArray;

    for i := 0 to arrItem.Count - 1 do
    begin
        // Detalhes...
        qryDetalhe.Active := false;
        qryDetalhe.SQL.Clear;
        qryDetalhe.SQL.Add('select id_detalhe, detalhe from tab_pedido_item_detalhe where id = :id');
        qryDetalhe.ParamByName('id').Value := arrItem[i].GetValue<integer>('id');
        qryDetalhe.Active := true;

        arrDetalhe := qryDetalhe.ToJSONArray;

        TJsonObject(arrItem[i]).AddPair('detalhes', arrDetalhe);
    end;

    json := TJSONObject.Create;
    json.AddPair('pedido', TJSONNumber.Create(52148));
    json.AddPair('cliente', '99 Coders');
    json.AddPair('itens', arrItem);

    Log(json.ToJSON);

    json.DisposeOf;
end;

procedure TFrmPrincipal.Button1Click(Sender: TObject);
var
    jsonPessoa, jsonEndereco, jsonPai, jsonLoc: TJSONObject;
begin
    try
        jsonPessoa := TJSONObject.Create;
        jsonPessoa.AddPair('nome', 'Heber Stein Mazutti');
        jsonPessoa.AddPair('cpf', '000.000.000-00');

        jsonLoc := TJSONObject.Create;
        jsonLoc.AddPair('latitude', TJSONNumber.Create(25.12345));
        jsonLoc.AddPair('longitude', TJSONNumber.Create(10.12345));

        jsonEndereco := TJSONObject.Create;
        jsonEndereco.AddPair('logradouro', 'Av. Brasil, 1500');
        jsonEndereco.AddPair('bairro', 'Centro');
        jsonEndereco.AddPair('localizacao', jsonLoc);

        jsonPai := TJSONObject.Create;
        jsonPai.AddPair('pessoa', jsonPessoa);
        jsonPai.AddPair('endereco', jsonEndereco);

        Log(jsonPai.ToJSON);

    finally
        jsonPai.DisposeOf;
    end;
end;

procedure TFrmPrincipal.Button2Click(Sender: TObject);
var
    arr: TJSONArray;
    jsonParams, jsonPai: TJSONObject;
begin
    arr := TJSONArray.Create;
    arr.Add('db14').Add(2).Add('1234567').Add('template').Add('search_read');

    jsonParams := TJSONObject.Create;
    jsonParams.AddPair('service', 'object');
    jsonParams.AddPair('method', 'execute');
    jsonParams.AddPair('args', arr);

    jsonPai := TJSONObject.Create;
    jsonPai.AddPair('jsonrpc', '2.0');
    jsonPai.AddPair('method', 'call');
    jsonPai.AddPair('params', jsonParams);

    Log(jsonPai.ToJSON);

    jsonPai.DisposeOf;

end;

procedure TFrmPrincipal.Button3Click(Sender: TObject);
var
    jCategoria, jProdDetalhe, jProduto, jTipo, jPai: TJSONObject;
    arrProdutos: TJSONArray;
begin
    jCategoria := TJSONObject.Create;
    jCategoria.AddPair('id', '0352132');
    jCategoria.AddPair('descricao', 'categoria xyz');

    jProdDetalhe := TJSONObject.Create;
    jProdDetalhe.AddPair('codigo', '032523121');
    jProdDetalhe.AddPair('descricao', 'Produto ABC');
    jProdDetalhe.AddPair('categoria', jCategoria);

    jProduto := TJSONObject.Create;
    jProduto.AddPair('produto', jProdDetalhe);

    arrProdutos := TJSONArray.Create;
    arrProdutos.Add(jProduto);

    jTipo := TJSONObject.Create;
    jTipo.AddPair('produtos', arrProdutos);

    jPai := TJSONObject.Create;
    jPai.AddPair('retorno', jTipo);

    Log(jPai.ToJSON);

    jPai.DisposeOf;

end;

end.
