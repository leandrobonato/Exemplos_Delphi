unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    pgc1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    btn1: TButton;
    mmo1: TMemo;
    btn2: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  uConstantesMobile;

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  I: Integer;
  vTexto: String;
begin
  for I := Low(vArrListaTabelas) to High(vArrListaTabelas) do
  begin
    vTexto := Format(vComando_CreateTable, [vArrListaTabelas[I]]);
    if vArrListaTabelas[I] = 'ORCAMENTO_ITEM' then
    begin
      vTexto := vTexto + Format(vComando_CreateTable_Column,[vCampoCodigo]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoFK_Orcamento]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoFK_Produto]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoQtd]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoPreco]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoTotal]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoItem]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoCodigoLocal]);
    end
    else if vArrListaTabelas[I] = 'CIDADE' then
    begin
      vTexto := vTexto + Format(vComando_CreateTable_Column,[vCampoCodigo]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoDescricao]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoCodUf]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoUf]);
    end
    else if vArrListaTabelas[I] = 'EMPRESA' then
    begin
      vTexto := vTexto + Format(vComando_CreateTable_Column,[vCampoCodigo]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoNome_Empresa]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoAtivo]);
    end
    else if vArrListaTabelas[I] = 'ORCAMENTO' then
    begin
      vTexto := vTexto + Format(vComando_CreateTable_Column,[vCampoCodigo]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoData]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoFKVendedor]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoFK_Cliente]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoCliente]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoTelefone]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoCelular]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoEndereco]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoNumero]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoBairro]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoCidade]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoUF]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoCNPJ]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoFORMA_Pagamento]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoValidade]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoSituacao]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoTotal]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoCEP]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoFKEmpresa]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoSubTotal]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoPercentual]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoDesconto]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoCodigoLocal]);
    end
    else if vArrListaTabelas[I] = 'CONFIGURA' then
    begin
      vTexto := vTexto + Format(vComando_CreateTable_Column,[vCampoCodigo]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoip_servidor]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoConexao]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoHost]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoBanco]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoSenha]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoUsuario]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoEmpresa]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoCNPJ]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoID_Vendedor]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoImpressora]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoPorta]);
    end
    else if vArrListaTabelas[I] = 'VENDEDORES' then
    begin
      vTexto := vTexto + Format(vComando_CreateTable_Column,[vCampoCodigo]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoNome]);
    end
    else if vArrListaTabelas[I] = 'PRODUTO' then
    begin
      vTexto := vTexto + Format(vComando_CreateTable_Column,[vCampoCodigo]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoTipo]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoCodBarra]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoReferencia]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoUnidade]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoPr_Custo]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampopr_venda]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoqtd_atual]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoDescricao]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoFOTO_Icone]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoFoto_Grande]);
    end
    else if vArrListaTabelas[I] = 'PESSOA' then
    begin
      vTexto := vTexto + Format(vComando_CreateTable_Column,[vCampoCodigo]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoTipo]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoEmpresa_Pessoa]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoCNPJ]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoIE]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoFantasia]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoRazao]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoEndereco]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoNumero]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoComplemento]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoCodMun]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoMunicipio]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoBairro]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoUF]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoCEP]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoFone1]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoFone2]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoCelular1]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoCelular2]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoEmail1]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoEmail2]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoSexo]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoDT_Nasc]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoeCivil]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoLimite]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoDia_Pgto]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoNum_Usu]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoFatura]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoCHEQUE]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoCCF]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoSPC]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoISENTO]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoFORN]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoFUN]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoCLI]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoFAB]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoTRAN]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoADm]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoAtivo]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoDt_Admissao]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoDt_DEmissao]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoSalario]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoPAI]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoMae]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoNovo]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoCodigoLocal]);
    end
    else if vArrListaTabelas[I] = 'FORMA_PAGAMENTO' then
    begin
      vTexto := vTexto + Format(vComando_CreateTable_Column,[vCampoCodigo]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoDescricao]);
      vTexto := vTexto + ',' + Format(vComando_CreateTable_Column,[vCampoAtivo]);
    end;
    vTexto := vTexto + vComando_Fim;
    mmo1.Lines.Add(vTexto);
  end;
end;

procedure TForm1.btn2Click(Sender: TObject);
var
  vGUID: TGuid;
begin
  ShowMessage(vGUID.NewGuid.ToString);
end;

end.
