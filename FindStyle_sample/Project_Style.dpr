program Project_Style;

uses
  FMX.Forms,
  Unit_style in 'Unit_style.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
