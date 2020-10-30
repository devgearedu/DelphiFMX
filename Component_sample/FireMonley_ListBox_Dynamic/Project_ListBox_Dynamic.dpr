program Project_ListBox_Dynamic;

uses
  System.StartUpCopy,
  FMX.Forms,
  ListBoxNormal in 'ListBoxNormal.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
