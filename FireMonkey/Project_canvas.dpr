program Project_canvas;

uses
  FMX.Forms,
  Unit_Shape in 'Unit_Shape.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
