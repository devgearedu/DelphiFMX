program Project_3D;

uses
  FMX.Forms,
  Unit_3D in 'Unit_3D.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
