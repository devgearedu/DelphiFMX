program Sample4_2_animation;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit1_animation in 'Unit1_animation.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.soInvertedLandscape];
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
