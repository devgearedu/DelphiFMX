program Sample4_2;

uses
  System.StartUpCopy,
//  FMX.MobilePreview,
  FMX.Forms,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.soInvertedLandscape];
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
