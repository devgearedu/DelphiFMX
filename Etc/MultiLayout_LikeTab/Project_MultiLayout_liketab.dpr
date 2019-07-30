program Project_MultiLayout_liketab;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit_MultiLayout_likeTab in 'Unit_MultiLayout_likeTab.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
