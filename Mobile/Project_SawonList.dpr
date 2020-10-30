program Project_sawonList;

uses
  System.StartUpCopy,
  FMX.Forms,
  UsawonList in 'UsawonList.pas' {Form129};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm129, Form129);
  Application.Run;
end.
