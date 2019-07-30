program Project_Viewport3d;

uses
  FMX.Forms,
  Unit_hdForm_Viewport3d in 'Unit_hdForm_Viewport3d.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
