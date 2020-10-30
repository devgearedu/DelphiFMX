program Project_BasicControl;

uses
  System.StartUpCopy,
  FMX.Forms,
  uBasicControl in 'uBasicControl.pas' {Form28};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm28, Form28);
  Application.Run;
end.
