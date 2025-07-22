unit Refactor.Model.Behaviors;

interface

uses
  System.SysUtils,
  System.UITypes,
  VCl.Forms;

type
  TModelBehaviors = class
    private
       procedure BehaviorException( Sender : TObject; E: Exception);
    public
      constructor Create;
      destructor Destroy; override;
  end;

var
  ModelBehaviors : TModelBehaviors;

implementation

uses
  Vcl.Dialogs;

{ TModelBehaviors }

procedure TModelBehaviors.BehaviorException(Sender: TObject; E: Exception);
begin
  MessageDlg(E.Message, mtWarning, [mbOK], 0);
end;

constructor TModelBehaviors.Create;
begin
  ReportMemoryLeaksOnShutdown := True;
  Application.OnException := BehaviorException;
end;

destructor TModelBehaviors.Destroy;
begin

  inherited;
end;

initialization
  ModelBehaviors := TModelBehaviors.Create;

finalization
  ModelBehaviors.DisposeOf;

end.
