program Project_First;

uses
  System.StartUpCopy,
  FMX.Forms,
  UFirst in 'UFirst.pas' {Form219};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm219, Form219);
  Application.Run;
end.
