program Sample3_1;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit1_image in 'Unit1_image.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
