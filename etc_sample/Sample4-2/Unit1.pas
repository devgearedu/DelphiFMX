unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.MaterialSources, FMX.Objects3D, FMX.Controls3D,
  FMX.Viewport3D, FMX.StdCtrls, FMX.Layouts, System.Math.Vectors,
  FMX.Controls.Presentation;

type
  TForm1 = class(TForm)
    MViewport3D: TViewport3D;
    BaseGrid3D: TGrid3D;
    Cube1: TCube;
    TextureMaterialSource1: TTextureMaterialSource;
    Button1: TButton;
    RSpeedButton: TSpeedButton;
    LSpeedButton: TSpeedButton;
    XSpeedButton: TSpeedButton;
    Sphere1: TSphere;
    Dummy1: TDummy;
    Layout1: TLayout;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RSpeedButtonClick(Sender: TObject);
    procedure LSpeedButtonClick(Sender: TObject);
    procedure Cube1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single; RayPos, RayDir: TVector3D);
    procedure XSpeedButtonClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     ResPath : string;
     procedure Make_Cube( rate : single );
     procedure dummy_change;
     procedure Rotate_Cube_YAngle( CCW : Boolean );
  end;

var
  Form1: TForm1;

implementation

 // 동적 이벤트 생성 클래스
 type
    TEventHandlers = class
      procedure Mouse_Down(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single; RayPos, RayDir: TVector3D);
 end;

 var
   IM_FACE : array [1..6] of TPlane;
   EvHandler:TEventHandlers;


{$R *.fmx}

//********************************************
procedure TForm1.FormCreate(Sender: TObject);
begin
  {$IFDEF IOS}
  ResPath := GetHomePath() + PathDelim + 'Library' + PathDelim;    //  StartUp\Library
  {$ELSE}
  ResPath := GetHomePath() + PathDelim;                            // .\assets\internal
  {$ENDIF}                                                       // c:\Users\userid\AppData\Roaming\
end;


//********************************************************************
procedure TForm1.Button1Click(Sender: TObject);
begin
  Make_Cube( 3 );
end;

//-------------------------------------------------------------------
procedure TForm1.Make_Cube( rate : single );
var
  i : integer;
  rWidth, rHeight, yPos : single;
  iMaterial : TTextureMaterialSource;
begin
  rWidth  := 1.0 * rate;
  rHeight := 1.0 * rate;
  yPos := 0.0;

  for i := 1 to 6 do
  begin
    if Assigned( IM_FACE[ i ] ) then
       IM_FACE[ i ].Release;

    iMaterial := TTextureMaterialSource.Create(nil);
    iMaterial.Texture.LoadFromFile( ResPath + 'blue_'+ intToStr(i) +'.png' );

    IM_FACE[ i ] := TPlane.Create( nil );
    IM_FACE[ i ].Parent := dummy1; // MViewport3D;
    IM_FACE[ i ].MaterialSource := iMaterial;
    IM_FACE[ i ].Tag := i;
    IM_FACE[ i ].TagString := 'blue_'+ intToStr(i) +'.png';

    IM_FACE[ i ].Width  := rWidth;
    IM_FACE[ i ].Height := rHeight;
    IM_FACE[ i ].Depth  := 0.01;

    IM_FACE[ i ].OnMouseDown := EvHandler.Mouse_Down;     // 동적 이벤트 생성
  end;

  IM_FACE[ 1 ].Position.X := 0.0;            IM_FACE[ 1 ].RotationAngle.X := 0;
  IM_FACE[ 1 ].Position.Z := -rWidth/2;      IM_FACE[ 1 ].RotationAngle.Z := 0;
  IM_FACE[ 1 ].Position.Y := yPos;           IM_FACE[ 1 ].RotationAngle.Y := 0;

  IM_FACE[ 2 ].Position.X := rWidth/2;       IM_FACE[ 2 ].RotationAngle.X := 0;
  IM_FACE[ 2 ].Position.Z := 0.0;            IM_FACE[ 2 ].RotationAngle.Z := 0;
  IM_FACE[ 2 ].Position.Y := yPos;           IM_FACE[ 2 ].RotationAngle.Y := -90;

  IM_FACE[ 3 ].Position.X := 0.0;            IM_FACE[ 3 ].RotationAngle.X := 0;
  IM_FACE[ 3 ].Position.Z := rWidth/2;       IM_FACE[ 3 ].RotationAngle.Z := 0;
  IM_FACE[ 3 ].Position.Y := yPos;           IM_FACE[ 3 ].RotationAngle.Y := -180;

  IM_FACE[ 4 ].Position.X := -rWidth/2;      IM_FACE[ 4 ].RotationAngle.X := 0;
  IM_FACE[ 4 ].Position.Z := 0.0;            IM_FACE[ 4 ].RotationAngle.Z := 0;
  IM_FACE[ 4 ].Position.Y := yPos;           IM_FACE[ 4 ].RotationAngle.Y := -270;

  IM_FACE[ 5 ].Position.X := 0.0;            IM_FACE[ 5 ].RotationAngle.X := 90;
  IM_FACE[ 5 ].Position.Z := 0.0;            IM_FACE[ 5 ].RotationAngle.Z := 0;
  IM_FACE[ 5 ].Position.Y := yPos+rWidth/2;  IM_FACE[ 5 ].RotationAngle.Y := 0;

  IM_FACE[ 6 ].Position.X := 0.0;            IM_FACE[ 6 ].RotationAngle.X := -90;
  IM_FACE[ 6 ].Position.Z := 0.0;            IM_FACE[ 6 ].RotationAngle.Z := 0;
  IM_FACE[ 6 ].Position.Y := yPos-rWidth/2;  IM_FACE[ 6 ].RotationAngle.Y := 0;
end;


//-------------------------------------------------------------------
procedure TForm1.Rotate_Cube_YAngle( CCW : Boolean );
var
  i, angle : integer;
  dr, rad  : single;
begin
  for i := 1 to 6 do
    if not Assigned( IM_FACE[ i ] ) then exit;

  dr  := 0.2;  // 회전속도
  rad := IM_FACE[ 1 ].Width/2;  // Cube 내경 반지름.

  if CCW = TRUE then
     angle := 45
  else
     angle := -45;

  for i := 1 to 4 do
  begin
    IM_FACE[ i ].AnimateFloat('Position.X', -rad*sin( Pi()/180.0*( IM_FACE[i].RotationAngle.Y+angle )), dr );
    IM_FACE[ i ].AnimateFloat('Position.Z', -rad*cos( Pi()/180.0*( IM_FACE[i].RotationAngle.Y+angle )), dr );
    IM_FACE[ i ].AnimateFloat('RotationAngle.Y', IM_FACE[i].RotationAngle.Y+angle, dr );
  end;
  IM_FACE[ 5 ].AnimateFloat('RotationAngle.Z', IM_FACE[5].RotationAngle.Z-angle, dr );
  IM_FACE[ 6 ].AnimateFloat('RotationAngle.Z', IM_FACE[6].RotationAngle.Z+angle, dr );
end;


//*****************************************************
procedure TForm1.RSpeedButtonClick(Sender: TObject);
begin
  Cube1.AnimateFloat( 'RotationAngle.Y',  Cube1.RotationAngle.Y - 45, 0.2 );

  Rotate_Cube_YAngle( FALSE );
end;

procedure TForm1.LSpeedButtonClick(Sender: TObject);
begin
  Cube1.AnimateFloat( 'RotationAngle.Y',  Cube1.RotationAngle.Y + 45, 0.2 );

  Rotate_Cube_YAngle( TRUE );
end;

procedure TForm1.XSpeedButtonClick(Sender: TObject);
begin
  Dummy1.AnimateFloat( 'RotationAngle.X',  Dummy1.RotationAngle.X - 45, 0.2 );
end;

//*********************************************************************************************************************************
procedure TForm1.Button2Click(Sender: TObject);
begin
  dummy_change;
end;

procedure TForm1.Cube1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single; RayPos, RayDir: TVector3D);
begin
  ShowMessageFmt( 'Cube1 Angle Y = %.f', [cube1.RotationAngle.Y] );
end;


procedure TForm1.dummy_change;
begin
  BaseGrid3d.Position.Y := 1.5;
  Dummy1.Position.Vector := vector3d(0,-5,0);
  Dummy1.RotationAngle.Vector := Vector3d(0,0,0);
  Dummy1.AnimateFloat('position.y',0,1.5, TAnimationType.Out, TInterpolationType.Bounce);
  Dummy1.AnimateFloatDelay('RotationAngle.x', 90 * random(4)+1,0.5);
  Dummy1.AnimateFloatDelay('RotationAngle.y', 90 * random(4)+1,0.5,0.5);
  Dummy1.AnimateFloatdelay('RotationAngle.z', 90 * random(4)+1,0.5,1.0);
end;

//*****************************************************
procedure TEventHandlers.Mouse_Down(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single; RayPos, RayDir: TVector3D);
begin
  ShowMessage( (Sender as TPlane).TagString );
end;


end.

