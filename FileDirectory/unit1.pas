uses
  Winapi.ShlObj, Winapi.ActiveX, System.IOUtils;

procedure SelecionarDiretorioComFileOpenDialog;
var
  FileOpenDialog: TFileOpenDialog;
begin
  FileOpenDialog := TFileOpenDialog.Create(nil);
  try
    FileOpenDialog.Options := [fdoPickFolders];
    FileOpenDialog.Title := 'Selecione um Diretório';
    
    if FileOpenDialog.Execute then
    begin
      // Diretório selecionado
      ShowMessage('Diretório selecionado: ' + FileOpenDialog.FileName);
      
      // Usar o diretório...
      // Exemplo: Edit1.Text := FileOpenDialog.FileName;
    end;
  finally
    FileOpenDialog.Free;
  end;
end;