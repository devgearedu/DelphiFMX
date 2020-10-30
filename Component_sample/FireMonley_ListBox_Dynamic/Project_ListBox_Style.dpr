program Project_ListBox_Style;

uses
  System.StartUpCopy,
  FMX.Forms,
  ListBoxStyle in 'ListBoxStyle.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
