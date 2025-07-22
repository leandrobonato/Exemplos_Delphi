unit uSession;

interface

type
  TSession = class
  private
    class var Fcod_usuario_logado: integer;
    class var Fnome_usuario_logado: string;
  public
    class property cod_usuario_logado: integer read Fcod_usuario_logado write Fcod_usuario_logado;
    class property nome_usuario_logado: string read Fnome_usuario_logado write Fnome_usuario_logado;
  end;

implementation

end.
