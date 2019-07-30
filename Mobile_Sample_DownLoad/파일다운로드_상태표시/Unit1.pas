unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts, FMX.Objects, FMX.StdCtrls, FMX.Edit,
  IdHTTP, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  FMX.Controls.Presentation;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    NoThredDown_bt: TButton;
    URLEdit: TEdit;
    ProgressBar1: TProgressBar;
    DownImage: TImage;
    Layout1: TLayout;
    FileNameEdit: TEdit;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Pie1: TPie;
    Circle1: TCircle;
    RateText: TText;
    AniIndicator1: TAniIndicator;
    procedure NoThredDown_btClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    procedure FilePositionChange(Sender: TObject; OldPos, NewPos: integer);
  public
     ResPath : string;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  ImpFileStream;

{$R *.fmx}


//----------------------------------------------------------------------------
procedure TForm1.FormCreate(Sender: TObject);
begin
  {$IFDEF IOS}
  ResPath := GetHomePath() + PathDelim + 'Library' + PathDelim;    //  StartUp\Library
  {$ELSE}
     {$IFDEF ANDROID}
       ResPath := GetHomePath() + PathDelim;                        // .\assets\internal
     {$ELSE}
       ResPath := '..\..\_Data\';
     {$ENDIF}
  {$ENDIF}

  Pie1.Opacity := 0;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  DownImage.Bitmap.Clear( $FFFFFF );
  ProgressBar1.Value := 0;
  Pie1.EndAngle := -90;
  Pie1.StartAngle := -90;
  Pie1.Opacity := 0.0;
  Label1.Text := '0 Bytes';
end;

//**********************************************************************
procedure TForm1.NoThredDown_btClick(Sender: TObject);
var
  i : integer;
  mHTTP: TIdHTTP;
  SaveFile, URL : string;
  fsSource : TImpFileStream; // TFileStream;

begin
  SpeedButton1Click( Sender );

  SaveFile := ResPath + FileNameEdit.Text;
  URL := URLEdit.Text + FileNameEdit.Text;

  if FileExists( SaveFile ) then
     fsSource := TImpFileStream.Create( SaveFile, fmOpenWrite )
  else
     fsSource := TImpFileStream.Create( SaveFile, fmCreate );

  try
    //-----------------------------------------------------
    fsSource.OnPositionChange := FilePositionChange;
    if fsSource.Size = 0 then  ProgressBar1.Max := 3454761        // 최초 파일 다운로드시는 단말기에서는 파일사이즈 모르므로 지정값으로 알려 줘야함.
    else                       ProgressBar1.Max := fsSource.Size; // 기존파일이 있으므로 사이즈 알고 있음.
    ProgressBar1.Value := 0;

    Pie1.Opacity := 0.6;
    Pie1.EndAngle := -90;
    Pie1.StartAngle := -90;
    //-----------------------------------------------------

    mHTTP := TIdHTTP.Create(nil);
    mHttp.Get( URL, fsSource );       // 다운받아 파일 저장
  finally
    fsSource.Free;
    mHTTP.Free;

// 다운받은 파일 불러옴.
// 단말기에 따라 대형이미지는(2000만화소급 고해상도)는 작은모바일 화면에서 로딩실패함.

//  DownImage.MultiResBitmap.Items[0].Bitmap.LoadThumbnailFromFile( SaveFile, DownImage.Width, DownImage.Height ); // 이럴때는 썸내일로 표시할수 있음. 보통 600만 화소정도는 로딩가능
    DownImage.MultiResBitmap.Items[0].Bitmap.LoadFromFile( SaveFile ); // 작은크기(?)는 화면표시가능
  end;
end;

//------------------------------------------------------------------------------
procedure TForm1.FilePositionChange(Sender: TObject; OldPos, NewPos: integer);
var
  rate : single;
begin
  ProgressBar1.Value := NewPos;
  Label1.Text := IntToStr( NewPos ) + ' Bytes';

  // 파이그래프 표시 --------------------------------------------------
  Pie1.EndAngle := 360 * NewPos / ProgressBar1.Max + Pie1.StartAngle;
  rate := ( Pie1.EndAngle - Pie1.StartAngle ) * 100 / 360;
  RateText.Text := Format( '%.0f' , [rate] ) + '%';

  if rate >= 100 then Pie1.AnimateFloatDelay( 'Opacity', 0.0, 1.5, 1.0 ); // 보여주고 사라짐.

  Application.ProcessMessages;
end;



end.
