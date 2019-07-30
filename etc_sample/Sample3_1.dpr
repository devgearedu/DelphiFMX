program Sample3_1;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit1_image in 'G:\Source_Mobile_Advance\Source\Sample3-1\Unit1_image.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
