program Project_client;

uses
  Vcl.Forms,
  UMain_Client in 'UMain_Client.pas' {Form168},
  Uclientclass in 'Uclientclass.pas',
  Vcl.RecError in 'Vcl.RecError.pas' {ReconcileErrorForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm168, Form168);
  Application.Run;
end.
