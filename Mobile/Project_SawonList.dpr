program Project_SawonList;

uses
  System.StartUpCopy,
  FMX.Forms,
  USawon_List in 'USawon_List.pas' {Form219};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm219, Form219);
  Application.Run;
end.
