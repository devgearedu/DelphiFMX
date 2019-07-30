program Project_Camera;

uses
  System.StartUpCopy,
  FMX.Forms,
  UCamera in 'UCamera.pas' {Form220};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm220, Form220);
  Application.Run;
end.
