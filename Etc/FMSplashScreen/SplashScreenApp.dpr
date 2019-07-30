program SplashScreenApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  System.SysUtils,
  MainUnit in 'MainUnit.pas' {MainForm},
  SplashUnit in 'SplashUnit.pas' {SplashForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TSplashForm, SplashForm);
  Application.Run;
end.

