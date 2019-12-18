program Project_Mobile_Client;

uses
  System.StartUpCopy,
  FMX.Forms,
  Umain_Mobile in 'Umain_Mobile.pas' {Form169},
  Uclientclass in 'Uclientclass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm169, Form169);
  Application.Run;
end.
