unit uDmRepos;

interface

uses
  System.SysUtils, System.Classes, cxEdit, cxEditRepositoryItems,
  System.ImageList, Vcl.ImgList, Vcl.Controls, cxGraphics, cxClasses, cxImageList;

type
  TdmRepos = class(TDataModule)
    repCadastros: TcxEditRepository;
    imgIcons: TcxImageList;
    ercbSituacaoDF: TcxEditRepositoryImageComboBoxItem;
    ercbSituacaoCadastro: TcxEditRepositoryImageComboBoxItem;
    errgSituacaoDF: TcxEditRepositoryRadioGroupItem;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmRepos: TdmRepos;

implementation

uses
  EnumHelper, EnumTypes;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmRepos.DataModuleCreate(Sender: TObject);
begin
  TEnumUtils<TSituacaoCadastro>.Fill(ercbSituacaoCadastro.Properties.Items);
  TEnumUtils<TSituacaoDF>.Fill(ercbSituacaoDF.Properties.Items);
  TEnumUtils<TSituacaoDF>.Fill(errgSituacaoDF.Properties.Items);
end;

end.
