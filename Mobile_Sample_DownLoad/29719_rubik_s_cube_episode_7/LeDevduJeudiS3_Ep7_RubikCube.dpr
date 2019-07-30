program LeDevduJeudiS3_Ep7_RubikCube;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  UMain in 'UMain.pas' {FrmMain},
  UCommon in 'UCommon.pas' {DmCommon: TDataModule},
  ULaunchWebbrowser in 'ULaunchWebbrowser.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.soLandscape, TFormOrientation.soInvertedLandscape];
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TDmCommon, DmCommon);
  Application.Run;
end.
