program Project_SkinControl;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit_skincontrol in 'Unit_skincontrol.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
