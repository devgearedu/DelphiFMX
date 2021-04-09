program Project_SawonList;

uses
  System.StartUpCopy,
  FMX.Forms,
  USawonList in 'UsawonList.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
