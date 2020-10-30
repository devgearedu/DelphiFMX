program Project_Camera;

uses
  System.StartUpCopy,
  FMX.Forms,
  Ucamera in 'Ucamera.pas' {Form6};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm6, Form6);
  Application.Run;
end.
