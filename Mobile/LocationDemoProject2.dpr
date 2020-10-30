program LocationDemoProject2;

uses
  System.StartUpCopy,
  FMX.Forms,
  LocationDemoUnit in 'LocationDemoUnit.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
