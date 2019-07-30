program Project_TTT;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit_TTT in 'Unit_TTT.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
