program Project_BasocControl;

uses
  System.StartUpCopy,
  FMX.Forms,
  uBasicControl in 'uBasicControl.pas' {Form219};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm219, Form219);
  Application.Run;
end.
