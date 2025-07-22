unit unFrmImportacaoDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue,
  dxSkinsdxBarPainter, cxClasses, dxBar, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, System.Win.ComObj, unit_rotinas;

type
  TFrmImportacaoDados = class(TForm)
    ScrollBox1: TScrollBox;
    dbmBARRA: TdxBarManager;
    btnPRIMEIRO: TdxBarLargeButton;
    btnANTERIOR: TdxBarLargeButton;
    btnPROXIMO: TdxBarLargeButton;
    btnULTIMO: TdxBarLargeButton;
    btnNOVO: TdxBarLargeButton;
    btnALTERAR: TdxBarLargeButton;
    btnEXCLUIR: TdxBarLargeButton;
    btnGRAVAR: TdxBarLargeButton;
    btnCANCELAR: TdxBarLargeButton;
    btnIMPRIMIR: TdxBarLargeButton;
    OS: TdxBarLargeButton;
    btnSAIR: TdxBarLargeButton;
    dbmBARRABar1: TdxBar;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    dxBarButton4: TdxBarButton;
    dxBarButton5: TdxBarButton;
    OpenDialog1: TOpenDialog;
    ScrollBox2: TScrollBox;
    Panel1: TPanel;
    DBLookupComboBox1: TDBLookupComboBox;
    Label1: TLabel;
    Memo1: TMemo;
    Label2: TLabel;
    dxBarButton6: TdxBarButton;
    StringGrid1: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure dxBarButton5Click(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
    procedure DBLookupComboBox1Click(Sender: TObject);
    procedure dxBarButton6Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    arquivo: TextFile;
    vArrIni, vArrFim: array of integer;
    vArrFie: array of String;
    vTop: Integer;
    procedure criarNovoCampo;
    procedure ProcessarDadosTexto;
    procedure DropaCampos;
    procedure preencheMatriz;
    function XlsToStringGrid(xStringGrid: TStringGrid;
      xFileXLS: string): Boolean;
    procedure ProcessarDadosXLS;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmImportacaoDados: TFrmImportacaoDados;

implementation

{$R *.dfm}

uses unit_DataModule, unFrmProgresso;

procedure TFrmImportacaoDados.DBLookupComboBox1Click(Sender: TObject);
begin
  dxBarButton1.Enabled := DBLookupComboBox1.KeyValue <> '';
  dxBarButton2.Enabled := DBLookupComboBox1.KeyValue <> '';
  dxBarButton3.Enabled := DBLookupComboBox1.KeyValue <> '';
  dxBarButton6.Enabled := DBLookupComboBox1.KeyValue <> '';
  dropaCampos;
end;

procedure TFrmImportacaoDados.dxBarButton1Click(Sender: TObject);
begin
  criarNovoCampo;
end;

procedure TFrmImportacaoDados.dxBarButton3Click(Sender: TObject);
begin
  if Pos('.TXT',UpperCase(OpenDialog1.FileName)) >= 1 then
    ProcessarDadosTexto
  else
    ProcessarDadosXLS;
  DropaCampos;
end;

procedure TFrmImportacaoDados.ProcessarDadosXLS;
var
  vSQL: String;
  I, II: Integer;
begin
  try
    frmProgresso := TFrmProgresso.Create(Self);
    frmProgresso.vQtdReg := StringGrid1.RowCount -1;
    frmProgresso.Show;
    application.processMessages;
    for II := 1 to StringGrid1.RowCount -1 do
    begin  
      frmProgresso.vTexLbl := 'Processando a linha ' + IntToStr(II) + ' de ' + IntTOStr(StringGrid1.RowCount) + ' linhas...';
      Inc(frmProgresso.vRegAtu);
      frmProgresso.ProcessaRegistros;                                         
      application.processMessages; 
      if Trim(StringGrid1.Rows[II].Text) <> '' then
      begin
        vSQL := '';                   
        vSQL := ' INSERT INTO ' + DBLookupComboBox1.KeyValue + ' (';
        for I := 0 to StringGrid1.colCount -1 do
        begin
          if Trim(StringGrid1.cells[i,0]) <> '' then
          begin
            if I = 0 then
              vSQL := vSQL + StringGrid1.cells[i,0]
            else
              vSQL := vSQL + ',' + StringGrid1.cells[i,0]
          end;
        end;
        vSQL := vSQL + ') VALUES (';
        for I := 0 to StringGrid1.ColCount -1 do
        begin
          if I = 0 then
            vSQL := vSQL + QuotedStr(trim(StringGrid1.Cells[I,II]))
          else
            vSQL := vSQL + ',' + QuotedStr(trim(StringGrid1.Cells[I,II]));
        end;
        vSQL := vSQL + ');';
        Memo1.Lines.Add(vSQL);
      end;
    end;
    frmProgresso.close;
    if messageDlg('Processo finalizado com sucesso!' + #13#10 + 'Deseja efetuar a execução do comando SQL?', MtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      try
        if not dm.conSoftSig.InTransaction then
          dm.conSoftSig.StartTransaction;
        for I := 0 to memo1.Lines.Count - 1 do
        begin
          dm.qryAux.Close;
          dm.qryAux.SQL.Clear;
          dm.qryAux.SQL.Text := memo1.Lines.Strings[I];
          dm.qryAux.ExecSQL;
        end;
        dm.conSoftSig.Commit;
      except on E: Exception do
      begin
        MessageDlg('Problemas ao inserir os dados!' + #13#10 +
                   'Você poderá corrigi-los do comando abaixo, sem haver a necessidade de reprocessamento e executá-los manualmente.' + #13#10 +
                   'Erro: ' + E.Message, mtError, [mbOk],0);
        dm.ConSoftSig.Rollback;
      end;
      end;
    end;
  finally
    FreeAndNil(frmProgresso);
    FreeAndNil(arquivo);
  end;
end;

procedure TFrmImportacaoDados.criarNovoCampo;
var
  ComboBox: TComboBox;
  edit: TEdit;
  lblDescricao: TLabel;
  GroupBox: TGroupBox;
  bitbtn: TBitbtn;
begin
  //Cria o group Box
  groupBox:= TGroupBox.Create(ScrollBox2);
  groupBox.Parent := ScrollBox2;
  groupBox.Caption := 'Informações do campo';
  groupBox.Align := alCustom;
  vTop := groupBox.Height + vTop + 30;
  groupBox.Align := alTop;
  groupBox.top := vTop;
  groupBox.AlignWithMargins := True;
  groupBox.Margins.Left := 10;
  groupBox.Margins.Right := 10;
  groupBox.Margins.Bottom := 5;
  groupBox.Margins.Top := 5;
  groupBox.Height := 65;
  groupBox.Visible := True;
  groupBox.Enabled := True;

  if Pos('.TXT', UpperCase(OpenDialog1.FileName)) >= 1 then
  begin
    //Label descrição "Posição inicial"
    lblDescricao := TLabel.Create(GroupBox);
    lblDescricao.Parent := GroupBox;
    lblDescricao.Caption := 'Posição inicial';
    lblDescricao.Height := 13;
    lblDescricao.left := 17;
    lblDescricao.top := 17;
    lblDescricao.Autosize := True;

    //Label descrição "Posição final"
    lblDescricao := TLabel.Create(GroupBox);
    lblDescricao.Parent := GroupBox;
    lblDescricao.Caption := 'Posição final';
    lblDescricao.Height := 13;
    lblDescricao.left := 112;
    lblDescricao.top := 17;
    lblDescricao.Autosize := True;

    //Edit posição inicial
    edit := TEdit.Create(GroupBox);
    edit.Parent := GroupBox;
    edit.alignment := taRightJustify;
    edit.Height := 21;
    edit.Left := 17;
    edit.Top := 32;
    edit.Width := 64;
    edit.Text := '';
    edit.textHint := 'Posição inicial';

    //Edit posicao final
    edit := TEdit.Create(GroupBox);
    edit.Parent := GroupBox;
    edit.alignment := taRightJustify;
    edit.Height := 21;
    edit.Left := 112;
    edit.Top := 32;
    edit.Width := 64;
    edit.Text := '';
    edit.textHint := 'Posição final';
  end
  else
  begin
    //Label descrição "Posição inicial"
    lblDescricao := TLabel.Create(GroupBox);
    lblDescricao.Parent := GroupBox;
    lblDescricao.Caption := 'Coluna';
    lblDescricao.Height := 13;
    lblDescricao.left := 17;
    lblDescricao.top := 17;
    lblDescricao.Autosize := True;

    //Edit posição inicial
    edit := TEdit.Create(GroupBox);
    edit.Parent := GroupBox;
    edit.alignment := taRightJustify;
    edit.Height := 21;
    edit.Left := 17;
    edit.Top := 32;
    edit.Width := 64;
    edit.Text := '';
    edit.textHint := 'Coluna';
  end;

   //Label descritivo do campo da tabela para ser escolhido
  lblDescricao := TLabel.Create(GroupBox);
  lblDescricao.Parent := GroupBox;
  lblDescricao.Caption := 'Campo da base de dados';
  lblDescricao.Height := 13;
  lblDescricao.left := 200;
  lblDescricao.top := 17;
  lblDescricao.Autosize := True;
  //Cria o dblookup para o campo equivalente
  ComboBox := TComboBox.Create(GroupBox);
  ComboBox.Parent := GroupBox;
  ComboBox.Height := 21;
  ComboBox.Top := 32;
  ComboBox.Width := 250;
  ComboBox.Left := 200;
  ComboBox.ItemIndex := -1;
  dm.qryTablesColumns.First;
  while not dm.qryTablesColumns.Eof do
  begin
    combobox.Items.Add(dm.qryTablesColumns.FieldByName('RDB$FIELD_NAME').AsString);
    dm.qryTablesColumns.Next;
  end;
end;

procedure TFrmImportacaoDados.ProcessarDadosTexto;
var
  vlinha, vSQL: String;
  I: Integer;
begin
  try
    Reset(arquivo);
    vLinha := '';
    preencheMatriz;
    frmProgresso := TFrmProgresso.Create(Self);
    while not eof(arquivo) do
    begin
      readLn(arquivo, vLinha);
      Inc(frmProgresso.vQtdReg);
    end;
    frmProgresso.vTitPrg := 'Processamento de dados através de importação de texto, aguarde...';
    frmProgresso.vTexLbl := 'Processando a linha 0 de ' + IntTOStr(frmProgresso.vQtdReg) + ' linhas...';
    frmProgresso.vRegAtu := 0;
    Reset(arquivo);
    vLinha := '';
    frmProgresso.Show;
    application.processMessages;
    while not Eof(arquivo) do
    begin
      vSQL := '';
      ReadLn(arquivo, vLinha);
      application.processMessages;
      Inc(frmProgresso.vRegAtu);
      frmProgresso.ProcessaRegistros;
      frmProgresso.vTexLbl := 'Processando a linha ' + IntToStr(frmProgresso.vRegAtu) + ' de ' + IntTOStr(frmProgresso.vQtdReg) + ' linhas...';
      application.processMessages;
      vSQL := ' INSERT INTO ' + DBLookupComboBox1.KeyValue + ' (';
      for I := 0 to High(vArrFie) do
      begin
        if I = 0 then
          vSQL := vSQL + vArrFie[I]
        else
          vSQL := vSQL + ',' + vArrFie[I]
      end;
      vSQL := vSQL + ') VALUES (';
      for I := 0 to High(vArrIni) do
      begin
        if I = 0 then
          vSQL := vSQL + QuotedStr(trim(Copy(vLinha, vArrIni[I], vArrFim[I] - vArrIni[I])))
        else
          vSQL := vSQL + ',' + QuotedStr(trim(Copy(vLinha, vArrIni[I], vArrFim[I] - vArrIni[I])));
      end;
      vSQL := vSQL + ');';
      Memo1.Lines.Add(vSQL);
    end;
    frmProgresso.close;
    if messageDlg('Processo finalizado com sucesso!' + #13#10 + 'Deseja efetuar a execução do comando SQL?', MtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      try
        if not dm.conSoftSig.InTransaction then
          dm.conSoftSig.StartTransaction;
        for I := 0 to memo1.Lines.Count - 1 do
        begin
          dm.qryAux.Close;
          dm.qryAux.SQL.Text := memo1.Lines.Strings[I];
          dm.qryAux.ExecSQL;
        end;
        dm.conSoftSig.Commit;
      except on E: Exception do
      begin
        MessageDlg('Problemas ao inserir os dados!' + #13#10 +
                   'Você poderá corrigi-los do comando abaixo, sem haver a necessidade de reprocessamento e executá-los manualmente.' + #13#10 +
                   'Erro: ' + E.Message, mtError, [mbOk],0);
        dm.ConSoftSig.Rollback;
      end;
      end;
    end;
  finally
    FreeAndNil(frmProgresso);
  end;
end;

procedure TFrmImportacaoDados.preencheMatriz;
var
  I, II, vValor: Integer;
  groupBox: TGroupBox;
  comboBox: TComboBox;
  edit: TEdit;
begin
  vArrIni := nil;
  vArrFim := nil;
  vArrFie := Nil;
  i := ScrollBox2.ControlCount -1;
  while i >= 0 do
  begin
    if scrollBox2.Controls[I].ClassName = 'TGroupBox' then
    begin
      groupBox := TGroupBox(scrollBox2.Controls[I]);
      II := groupBox.ControlCount -1;
      while II >= 0 do
      begin
        if groupBox.Controls[II].ClassName = 'TEdit' then
        begin
          edit := TEdit(groupBox.Controls[II]);
          if not TryStrToInt(edit.Text, vValor) then
          begin
            MessageDlg('Há dados preenchidos incorretamente, verifique!', mtWarning, [Mbok],0);
            edit.SetFocus;
            edit.Color := clCream;
            abort;
          end;
          if edit.Left = 17 then
          begin
            SetLength(vArrIni,length(vArrIni) + 1);
            vArrIni[high(vArrIni)] := StrToInt(edit.Text);
          end
          else if edit.Left = 112 then
          begin
            setLength(vArrFim, length(vArrFim) + 1);
            vArrFim[high(vArrFim)] := StrToInt(Edit.Text);
          end;
        end
        else if groupBox.Controls[II].ClassName = 'TComboBox' then
        begin
          comboBox := TComboBox(groupBox.Controls[II]);
          setLength(vArrFie, length(vArrFie) + 1);
          if comboBox.ItemIndex = -1 then
          begin
            MessageDlg('Há itens que não foram preenchidos corretamente, verifique!', mtWarning, [mbOk],0);
            comboBox.SetFocus;
            comboBox.Color := clCream;
            abort;
          end;
          vArrFie[high(vArrFie)] := comboBox.Text;
        end;
        ii := ii - 1;
      end;
    end;
    i := i - 1;
  end;
end;

procedure TFrmImportacaoDados.dxBarButton5Click(Sender: TObject);
begin
  if OpenDialog1.Execute() then
  begin
    DBLookupComboBox1.Enabled := True;
    dropaCampos;
    AssignFile(arquivo, OpenDialog1.FileName);
    if Pos('.TXT',UpperCase(Opendialog1.FileName)) <= 0 then
    begin
      StringGrid1.Visible := True;
      XlsToStringGrid(StringGrid1,OpenDialog1.FileName);
    end;
  end;
end;

function TFrmImportacaoDados.XlsToStringGrid(xStringGrid: TStringGrid; xFileXLS: string): Boolean;
const
  xlCellTypeLastCell = $0000000B;
  var
  XLSAplicacao, AbaXLS: OLEVariant;
  RangeMatrix: Variant;
  x, y, k, r: Integer;
  begin
  Result := False;
  // Cria Excel- OLE Object
  XLSAplicacao := CreateOleObject('Excel.Application');
  try
    // Esconde Excel
    XLSAplicacao.Visible := False;
    // Abre o Workbook
    XLSAplicacao.Workbooks.Open(xFileXLS);
    {Selecione aqui a aba que você deseja abrir primeiro - 1,2,3,4....}
    XLSAplicacao.WorkSheets[1].Activate;
    {Selecione aqui a aba que você deseja ativar - começando sempre no 1 (1,2,3,4) }
    AbaXLS := XLSAplicacao.Workbooks[ExtractFileName(xFileXLS)].WorkSheets[1];
    AbaXLS.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
    // Pegar o número da última linha
    x := XLSAplicacao.ActiveCell.Row;
    // Pegar o número da última coluna
    y := XLSAplicacao.ActiveCell.Column;
    // Seta xStringGrid linha e coluna
    XStringGrid.RowCount := x;
    XStringGrid.ColCount := y;
    // Associaca a variant WorkSheet com a variant do Delphi
    RangeMatrix := XLSAplicacao.Range['A1', XLSAplicacao.Cells.Item[x, y]].Value;
    // Cria o loop para listar os registros no TStringGrid
    k := 1;
    repeat
      for r := 1 to y do
        XStringGrid.Cells[(r - 1), (k - 1)] := RangeMatrix[k, r];
      Inc(k, 1);
      until k > x;
        RangeMatrix := Unassigned;
      finally
        // Fecha o Microsoft Excel
        if not VarIsEmpty(XLSAplicacao) then
        begin
          XLSAplicacao.Quit;
          XLSAplicacao := Unassigned;
          AbaXLS := Unassigned;
          Result := True;
        end;
  end;
end;

procedure TFrmImportacaoDados.dxBarButton6Click(Sender: TObject);
var
  I: Integer;
begin
  if messageDlg('Tem certeza que deseja efetuar a execução do comando SQL?', MtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    try
      if not dm.conSoftSig.InTransaction then
        dm.conSoftSig.StartTransaction;
      for I := 0 to memo1.Lines.Count - 1 do
      begin
        dm.qryAux.Close;
        dm.qryAux.SQL.Text := memo1.Lines.Strings[I];
        dm.qryAux.ExecSQL;
      end;
      dm.conSoftSig.Commit;
    except on E: Exception do
    begin
      MessageDlg('Problemas ao inserir os dados!' + #13#10 +
             'Você poderá corrigi-los do comando abaixo, sem haver a necessidade de reprocessamento e executá-los manualmente.' + #13#10 +
             'Erro: ' + E.Message, mtError, [mbOk],0);
      dm.ConSoftSig.Rollback;
    end;
    end;
  end;
end;

procedure TFrmImportacaoDados.DropaCampos;
var
  I: Integer;
  groupBox: TGroupBox;
begin
  i := ScrollBox2.ControlCount -1;
  while i >= 0 do
  begin
    if scrollBox2.Controls[I].ClassName = 'TGroupBox' then
    begin
      groupBox := TGroupBox(scrollBox2.Controls[I]);
      groupBox.Destroy;
    end;
    i := i - 1;
  end;
  vTop:= 0;
end;

procedure TFrmImportacaoDados.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Tecla_Esc_Sair_Tela(Key, Self);
end;

procedure TFrmImportacaoDados.FormShow(Sender: TObject);
begin
  dm.qryTables.Close;
  dm.qryTables.Open;
  dm.qryTablesColumns.Close;
  dm.qryTablesColumns.Open;
end;

end.
