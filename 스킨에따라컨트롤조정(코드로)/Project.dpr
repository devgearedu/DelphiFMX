program Project;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit1 in 'D:\1-1_버튼위치배열\1-1_버튼위치배열\Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
