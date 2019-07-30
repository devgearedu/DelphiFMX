program Project_BasicControl;

uses
  System.StartUpCopy,
  FMX.Forms,
  UBasicControl in 'UBasicControl.pas' {Form28};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm28, Form28);
  Application.Run;
end.
