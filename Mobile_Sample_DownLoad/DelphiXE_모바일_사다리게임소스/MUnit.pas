//***************************************************************************************
// 델파이로 개발한 모바일앱 오픈소스 프로젝트 1차 : 사다리게임
// 2014.05.26 최초 배포
//***************************************************************************************
// * 이 소스는 델파이 개발자들의 스터디용으로 오픈 합니다.
// * 이 소스의 모든 권리는 최초 개발자인 c2deisgn@paran.com 에 귀속 됩니다.
// * 개인 스터디 용도 이외에는 사용을 금함니다.
// * 소스 및 이미지 무단 배포를 금합니다.
//***************************************************************************************

unit MUnit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.TabControl, FMX.Layouts, FMX.Objects,
  FMX.ListBox, FMX.Edit, FMX.Ani, FMX.Media;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    StatusBar1: TStatusBar;
    MTabControl: TTabControl;
    TabItem_Set: TTabItem;
    TabItem_Play: TTabItem;
    MainLabel: TLabel;
    Start_bt: TButton;
    Layout1: TLayout;
    PLayout: TLayout;
    Repage_bt: TSpeedButton;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ResultType_cb: TComboBox;
    ComboBox2: TComboBox;
    Label5: TLabel;
    Speed_cb: TComboBox;
    SelLabel: TLabel;
    YCount_cb: TComboBox;
    LineTimer: TTimer;
    BottomLayout: TLayout;
    SelNo_cb: TComboBox;
    TabItem_Info: TTabItem;
    ListBox1: TListBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxGroupHeader2: TListBoxGroupHeader;
    AppLink1_LItem: TListBoxItem;
    AppLink2_LItem: TListBoxItem;
    AppLink3_LItem: TListBoxItem;
    Info_bt: TSpeedButton;
    MPlayer: TMediaPlayer;
    procedure Start_btClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Repage_btMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure LineTimerTimer(Sender: TObject);
    procedure PLayoutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ResultType_cbChange(Sender: TObject);
    procedure AppLink1_LItemMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure AppLink2_LItemMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure AppLink3_LItemMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Info_btMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
  private
    { Private declarations }
    procedure Init_Game( pN : integer );
    procedure Create_Bar( pN : integer );
    procedure Point_Setup( pN : integer );
    procedure Loading_AIcon( pN : integer );
    procedure Loading_NIcon( pN : integer );
    procedure Loading_BIcon( pN : integer );
    procedure Play_Go( vLineNo : integer );

  public
    { Public declarations }
    VSpace, HSpace : single;
    xInc, yInc : integer;
    ColorNum : Cardinal;
    ResPath : String;
    procedure Create_Animation( i : integer; bParent : TRectangle );
  end;

type PointType = record
  x, y : single;     // 화면위치 좌표
  cross : integer;   // 접점 0:없음, 1:오른쪽, 2:왼쪽(다른접접)
end;

type MarginType = record
  top,
  bot,
  side : integer;
end;

var
  Form1: TForm1;

  PType : array[0..9, 0..16] of PointType;
  Margin : MarginType;

  VLines : array[0..9] of TLine;
  HLines : array[0..9, 1..14] of TLine;

  AIcon : array[0..9] of TRectangle;
  NIcon : array[0..9] of TRectangle;

  AIconAni : array[0..9] of TFloatAnimation;   // FMX.Ani

  SubLayout : TLayout;
  DownLine, SideLine : TLine;

const
  ColorArr : array[0..9] of Cardinal = ( $FFfa7eb5, $FFa84b23, $FF0000FF, $FF00FFFF, $FFffff00,
                                         $FF00FF00, $FF23262b, $FFFF00FF, $FF5b6267, $FFFF0000 );

implementation



{$R *.fmx}
//******************************************************
procedure TForm1.FormCreate(Sender: TObject);
begin
  {$IFDEF IOS}
  ResPath := GetHomePath() + PathDelim + 'Library' + PathDelim;    //  StartUp\Library
  {$ELSE}
     {$IFDEF ANDROID}
       ResPath := GetHomePath() + PathDelim;                           // .\assets\internal
     {$ELSE}
       ResPath := '..\..\_Data\';
     {$ENDIF}
  {$ENDIF}

  Repage_bt.Visible := FALSE;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  Margin.top  := Round( PLayout.Height / 10 );
  Margin.bot  := Round( PLayout.Height / 20 );
  Margin.side := Round( Playout.Width  / 12 );
end;

//******************************************************
procedure TForm1.Info_btMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  MTabControl.ActiveTab := MTabControl.Tabs[ 2 ];
  Repage_bt.Visible := TRUE;
end;


//******************************************************
procedure TForm1.Start_btClick(Sender: TObject);
begin
  Init_Game( YCount_cb.Selected.Index+2 );

  MTabControl.ActiveTab := MTabControl.Tabs[ 1 ];
  Repage_bt.Visible := TRUE;
end;


//******************************************************
// 화면 복귀
procedure TForm1.Repage_btMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  MTabControl.ActiveTab := MTabControl.Tabs[ 0 ];
  Repage_bt.Visible := FALSE;
end;

//******************************************************
procedure TForm1.ResultType_cbChange(Sender: TObject);
var
  I: Integer;
begin
  if ResultType_cb.ItemIndex = 0 then       // 순위.
  begin
    SelLabel.Opacity := 0.3;
    SelNo_cb.Opacity := 0.3;
    SelNo_cb.Enabled := FALSE;
  end
  else
  begin                                     // 뽑기.
    SelLabel.Opacity := 1;
    SelNo_cb.Opacity := 1;
    SelNo_cb.Enabled := TRUE;

    SelNo_cb.Items.Clear;
    for i := 0 to YCount_cb.Selected.Index  do
      SelNo_cb.Items.Add( '    ' + IntToStr( i+1 ) );

    SelNo_cb.ItemIndex := 0;
  end;
end;

//----------------------------------------------------
// 게임 초기화
procedure TForm1.Init_Game( pN : integer );
begin
  // DownLine, SideLine 화면 클리어 용.
  if Assigned( SubLayout ) then
  begin
    SubLayout.Release();
    SubLayout := nil;
  end;

  SubLayout := TLayout.Create(nil);
  SubLayout.Parent :=  PLayout;             // 아이콘이 상위에 위치가능
  SubLayout.Align := TAlignLayout.alClient;

  PLayout.Tag := 0;
  BottomLayout.Opacity := 0;

  Create_bar( pN );
  Point_Setup( pN );
  Loading_AIcon( pN );

  if ResultType_cb.ItemIndex = 0 then     // 순위.
     Loading_NIcon( pN )
  else                                    // 뽑기.
     Loading_BIcon( pN );

  case Speed_cb.ItemIndex of
    0 : LineTimer.Interval := 400;
    1 : LineTimer.Interval := 250;
    2 : LineTimer.Interval := 100;
  end;
end;

//-----------------------------------------------------------------------------------
// 사다리 생성
procedure TForm1.Create_Bar( pN : integer );
var
  i, j, iRnd: Integer;
begin
  VSpace := ( Playout.Width - Margin.side*2 ) / ( pN-1 );       // 세로줄 간격
  HSpace := ( PLayout.Height - Margin.top - Margin.bot ) / 16;  // 가로줄 간격

  for i := 0 to 9 do
  begin
    if Assigned( VLines[i] ) then
    begin
       VLines[i].Release();
       VLines[i] := nil;
    end;

    for j := 1 to 14 do
      if Assigned( HLines[i,j] ) then
      begin
        HLines[i,j].Release();
        HLines[i,j] := nil;
      end;
  end;

  for i := 0 to pN-1 do
  begin
    VLines[ i ] := TLine.Create(nil);
    VLines[ i ].Parent := PLayout;
    VLines[ i ].LineType := TLineType.ltLeft;
    VLines[ i ].Stroke.Color := $FF6D6D6D;
    VLines[ i ].Stroke.Thickness := 5;
    VLines[ i ].HitTest := FALSE;

    VLines[ i ].Position.X := Margin.side + i * VSpace;
    VLines[ i ].Position.Y := Margin.top;
    VLines[ i ].Height := PLayout.Height - Margin.top - Margin.bot;
    VLines[ i ].Width  := 5;
    VLines[ i ].Opacity := 0.5;

    if i < pN -1  then  // 세로줄 보다 하나 적게 가로줄세트 생성
    begin
      for j := 1 to 14 do
      begin
        if not Odd( i ) then // 세로줄 짝수 라인 (첫번째부터)
        begin
          if ( j = 1 ) or ( j = 13 ) then  // 필수생성
            iRnd := 1
          else if ( j = 2 ) or ( j = 4 ) or ( j = 6 ) or ( j = 8 ) or ( j = 10 ) or ( j = 12 ) or ( j = 14 ) then // 무조건 없음.
            iRnd := 0
          else
            iRnd := Random( 2 );  // 나머진 랜덤.
        end
        else  // 세로줄 짝수 라인
        begin
          if ( j = 2 ) or ( j = 14 ) then  // 필수생성
            iRnd := 1
          else if ( j = 1 ) or ( j = 3 ) or ( j = 5 ) or ( j = 7 ) or ( j = 9 ) or ( j = 11 ) or ( j = 13 ) then // 무조건 없음.
            iRnd := 0
          else
            iRnd := Random( 2 );  // 나머진 랜덤.
        end;

        if iRnd = 1  then
        begin
          HLines[ i,j ] := TLine.Create(nil);
          HLines[ i,j ].Parent := PLayout;
          HLines[ i,j ].Tag := 1;              // 생성되었음.

          HLines[ i,j ].LineType := TLineType.ltTop;
          HLines[ i,j ].Stroke.Color := $FF6D6D6D;
          HLines[ i,j ].Stroke.Thickness := 5;
          HLines[ i,j ].HitTest := FALSE;
          HLines[ i,j ].Height := 5;
          HLines[ i,j ].Width  := vSpace + 5;
          HLines[ i,j ].Opacity := 0.5;
        end
        else
        begin
          HLines[ i,j ] := TLine.Create(nil);
          HLines[ i,j ].Tag := 0;              // 생성 안된경우.
        end;

        HLines[ i,j ].Position.X := Margin.side + vSpace*i;
        HLines[ i,j ].Position.Y := Margin.top +  HSpace*j;
      end;
    end;
  end;
end;

//-------------------------------------------------------------
// 접점 데이터 생성
procedure TForm1.Point_Setup( pN : integer );
var
  i, j : Integer;
//  tempCircle : TCircle;
begin
  // 초기화 ---------------
  for i := 0 to pn-1 do
    for j := 0 to 16 do
    begin
      PType[i,j].cross := 0;
      PType[i,j].x := 0;
      PType[i,j].y := 0;
    end;

  for i := 0 to pn-1 do           // 세로줄 보다 하나 적게 가로줄세트 생성
  begin
    PType[i,0].cross := 0;        // 시작, 끝점 접점 없음.
    PType[i,15].cross := 0;
    PType[i,16].cross := 0;

    pType[i,0].x := VLines[ i ].Position.X;
    pType[i,0].y := VLines[ i ].Position.Y;   // Margin.top;

    pType[i,15].x := VLines[ i ].Position.X;
    pType[i,15].y := VLines[ i ].Position.Y + VLines[ i ].Height - HSpace;

    pType[i,16].x := VLines[ i ].Position.X;
    pType[i,16].y := VLines[ i ].Position.Y + VLines[ i ].Height;

    if i < pN -1  then  // HLine은 세로줄 보다 하나 적게 가로줄세트 생성 되었음.
      for j := 1 to 14 do
      begin
        if HLines[ i,j ].Tag = 0 then  // HLine 없을때
           pType[ i,j ].cross := 0
        else
           pType[ i,j ].cross := 1;

        pType[i,j].x := HLines[ i,j ].Position.X;
        pType[i,j].y := HLines[ i,j ].Position.Y;
      end;
  end;

  // 우측 접점 별도 표시
  for i := 0 to pn-2 do
    for j := 1 to 14 do
    begin
      if HLines[ i,j ].Tag = 1 then
         pType[ i+1,j ].cross := 2;

      if i+1 = pn-1  then  // 맨 오른쪽 세로 끝점 
      begin
        pType[pn-1,j].x := HLines[ i,j ].Position.X + VSpace;
        pType[pn-1,j].y := HLines[ i,j ].Position.Y;
      end;
    end;

  // Point 확인용 -------------------------------
{  for i := 0 to pn-1 do
    for j := 0 to 16 do
    begin
      tempCircle := TCircle.Create(nil);
      tempCircle.Parent := SubLayout;
      tempCircle.Position.X := pType[i,j].x;
      tempCircle.Position.Y := pType[i,j].y;
      tempCircle.Width := 10;
      tempCircle.Height := 10;

      case pType[ i,j ].cross of
        0 : tempCircle.Fill.Color := $FFFFFFFF;
        1 : tempCircle.Fill.Color := $FF00FF00;
        2 : tempCircle.Fill.Color := $FFFF0000;
      end;
     end;
}
end;


//-------------------------------------------------------------------
// Animal 아이콘 로딩
procedure TForm1.Loading_AIcon( pN : integer );
var
  i : integer;
begin
  for i := 0 to 9 do
  begin
    if Assigned( AIcon[i] ) then
    begin
       AIcon[i].Release();
       AIcon[i] := nil;
    end;

    if Assigned( AIconAni[i] ) then
    begin
       AIconAni[i].Release();
       AIconAni[i] := nil;
    end;
  end;

  for i := 0 to pN-1 do
  begin
    AIcon[ i ] := TRectangle.Create(nil);
    AIcon[ i ].Parent := PLayout;          // SubLayout 보다 위에 있어 아이콘 상단 배치
    AIcon[ i ].Fill.Bitmap.WrapMode := TWrapMode.wmTileStretch;
    AIcon[ i ].Fill.Kind := TBrushKind.bkBitmap;
    AIcon[ i ].Stroke.Kind := TBrushKind.bkNone;
    AIcon[ i ].HitTest := FALSE;
    AIcon[ i ].Width  := 36;
    AIcon[ i ].Height := 36;
    AIcon[ i ].Fill.Bitmap.Bitmap.LoadFromFile( ResPath + 'A0'+IntToStr(i)+ '.png' );

    AIcon[ i ].Position.X := pType[ i,0 ].x-13;
    AIcon[ i ].Position.Y := pType[ i,0 ].y-36;

    Create_Animation( i, AIcon[ i ] );
  end;
end;

//-------------------------------------------------------------------
// 순위 결과 아이콘 로딩
procedure TForm1.Loading_NIcon( pN : integer );
var
  i, k : integer;
begin
  for i := 0 to 9 do
    if Assigned( NIcon[i] ) then
    begin
       NIcon[i].Release();
       NIcon[i] := nil;
    end;

  k := Random( pN ) + 1;   // 시작위치 임의 지정
  for i := 0 to pN-1 do
  begin
    if k > pN then
       k := 1;

    NIcon[ i ] := TRectangle.Create(nil);
    NIcon[ i ].Parent := BottomLayout;
    NIcon[ i ].Fill.Bitmap.WrapMode := TWrapMode.wmTileStretch;
    NIcon[ i ].Fill.Kind := TBrushKind.bkBitmap;
    NIcon[ i ].Stroke.Kind := TBrushKind.bkNone;
    NIcon[ i ].Width  := 36;
    NIcon[ i ].Height := 36;
    NIcon[ i ].Fill.Bitmap.Bitmap.LoadFromFile( ResPath + 'R'+IntToStr(k)+ '.png' );
    NIcon[ i ].Position.X := pType[ i,0 ].x-13;
    NIcon[ i ].Position.Y := 0;

    if k = 1 then
       NIcon[ i ].Tag := 1 // 1등 표시
    else
       NIcon[ i ].Tag := -1;

    Inc( k );
  end;
end;

//-------------------------------------------------------------------
// 선택 결과 아이콘 로딩
procedure TForm1.Loading_BIcon( pN : integer );
var
  i, rk, rm,  rCount : integer;
  strMem : array[0..9] of string;
  tmpStr : string;

begin
  for i := 0 to 9 do
    if Assigned( NIcon[i] ) then
    begin
       NIcon[i].Release();
       NIcon[i] := nil;
    end;

  rCount := SelNo_cb.Selected.Index + 1;  // 메달갯수

  for i := 0 to rCount-1 do    // 앞열에 골드 할당
    strMem[i] := 'gold.png';
  for i := rCount to pn-1 do   // 뒷열에 폭탄 할당
    strMem[i] := 'bomb.png';

  for i := 0 to 50 do      // 무작위로 순서 섞음.
  begin
    rk := Random( pN );    // 여러번 돌리니 똑같은값 나와도 무관.
    rm := Random( pN );
    tmpStr := strMem[ rk ];
    strMem[ rk ] := strMem[ rm ];
    strMem[ rm ] := tmpStr;
  end;

  for i := 0 to pN-1 do
  begin
    NIcon[ i ] := TRectangle.Create(nil);
    NIcon[ i ].Parent := BottomLayout;
    NIcon[ i ].Fill.Bitmap.WrapMode := TWrapMode.wmTileStretch;
    NIcon[ i ].Fill.Kind := TBrushKind.bkBitmap;
    NIcon[ i ].Stroke.Kind := TBrushKind.bkNone;
    NIcon[ i ].Width  := 36;
    NIcon[ i ].Height := 36;
    NIcon[ i ].Fill.Bitmap.Bitmap.LoadFromFile( ResPath + strMem[i] );

    NIcon[ i ].Position.X := pType[ i,0 ].x-13;
    NIcon[ i ].Position.Y := 0;

    if strMem[i] = 'gold.png' then
       NIcon[ i ].Tag := 1  // 골드 표시
    else
       NIcon[ i ].Tag := -1;
  end;
end;


//----------------------------------------------------------
// 한번 터치할때 마다 한개씩 실행
procedure TForm1.PLayoutClick(Sender: TObject);
begin
  if ( PLayout.Tag > YCount_cb.Selected.Index + 1 ) or ( LineTimer.Enabled = TRUE ) then
     Exit;

  Play_Go( PLayout.Tag );
  PLayout.Tag := PLayout.Tag + 1;
end;

//-------------------------------------------------------------
procedure TForm1.Play_Go( vLineNo : integer );
begin
  xInc := vLineNo;
  yInc := 0;
  ColorNum := ColorArr[ vLineNo ];

  LineTimer.Tag := vLineNo;
  LineTimer.Enabled := TRUE;

  MPlayer.Clear;
  MPlayer.FileName := ResPath + 'play.mp3';
  MPlayer.Play;
end;

//**********************************************************
procedure TForm1.LineTimerTimer(Sender: TObject);
begin
  if yInc > 15  then    // 바닥에 다 내려온 상태
  begin
    LineTimer.Enabled := FALSE;
    BottomLayout.AnimateFloat( 'Opacity', 1.0, 2.0 );   // 첫번째만 의미 있음.

    MPlayer.Clear;
    if NIcon[ xInc ].Tag = 1 then  // 골드,1등 일때만 애니작동
    begin
       AIconAni[ LineTimer.Tag ].Start;
       MPlayer.FileName := ResPath + 'play_ok.mp3';
    end
    else
       MPlayer.FileName := ResPath + 'play_fail.mp3';
    MPlayer.Play;

    Exit;
  end;

  DownLine := TLine.Create(nil);
  DownLine.Parent := SubLayout;
  DownLine.LineType := TLineType.ltLeft;
  DownLine.Stroke.Color := ColorNum;
  DownLine.Stroke.Thickness := 7;
  DownLine.HitTest := FALSE;

  DownLine.Position.X := pType[ xInc, yInc ].x;
  DownLine.Position.Y := pType[ xInc, yInc ].y - 3;
  DownLine.Height := HSpace + 12;

  AICon[ LineTimer.Tag ].AnimateFloat( 'Position.X', DownLine.Position.X-13, 0.3 );
  AICon[ LineTimer.Tag ].AnimateFloat( 'Position.Y', DownLine.Position.Y+5,  0.3 );

  if pType[ xInc, yInc+1 ].cross = 0 then          // 하강
  begin
    Inc( yInc );
    Exit;
  end
  else if pType[ xInc, yInc+1 ].cross = 1 then     // 우측 이동
  begin
    SideLine := TLine.Create(nil);
    SideLine.Parent := SubLayout;
    SideLine.LineType := TLineType.ltTop;
    SideLine.Stroke.Color := ColorNum;
    SideLine.Stroke.Thickness := 7;
    SideLine.HitTest := FALSE;

    SideLine.Position.X := pType[ xInc, yInc+1 ].x;
    SideLine.Position.Y := pType[ xInc, yInc+1 ].y;
    SideLine.Width := VSpace + 4;

    AICon[ LineTimer.Tag ].AnimateFloat( 'Position.X', SideLine.Position.X-13, 0.3 );
    AICon[ LineTimer.Tag ].AnimateFloat( 'Position.Y', SideLine.Position.Y,    0.3 );
    Inc( xInc );
  end
  else if pType[ xInc, yInc+1 ].cross = 2 then      // 좌측 이동
  begin
    SideLine := TLine.Create(nil);
    SideLine.Parent := SubLayout;
    SideLine.LineType := TLineType.ltTop;
    SideLine.Stroke.Color := ColorNum;
    SideLine.Stroke.Thickness := 7;
    SideLine.HitTest := FALSE;

    SideLine.Position.X := pType[ xInc-1, yInc+1 ].x;
    SideLine.Position.Y := pType[ xInc-1, yInc+1 ].y;
    SideLine.Width := VSpace + 4;

    AICon[ LineTimer.Tag ].AnimateFloat( 'Position.X', SideLine.Position.X-13, 0.3 );
    AICon[ LineTimer.Tag ].AnimateFloat( 'Position.Y', SideLine.Position.Y,    0.3 );
    Dec( xInc );
  end;

  Inc( yInc );
end;

//---------------------------------------------------------------------------
procedure TForm1.Create_Animation( i : integer; bParent : TRectangle );
begin
  AIconAni[ i ] := TFloatAnimation.Create(nil);
  AIconAni[ i ].Parent := bParent;
  AIconAni[ i ].PropertyName := 'Position.Y';
  AIconAni[ i ].AnimationType := TAnimationType.atIn;
  AIconAni[ i ].Interpolation := TInterpolationType.itBounce;
  AIconAni[ i ].Delay         := 0.0;
  AIconAni[ i ].Duration      := 1.0;
  AIconAni[ i ].Loop          := TRUE;
  AIconAni[ i ].StartValue    := pType[ i,16 ].y-20;
  AIconAni[ i ].StopValue     := pType[ i,16 ].y-40;
end;

//*********************************************************************
procedure TForm1.AppLink1_LItemMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
//  PlatFormAPI.CrossApi.AppStoreLink( 1 );
end;

procedure TForm1.AppLink2_LItemMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
//  PlatFormAPI.CrossApi.AppStoreLink( 2 );
end;

procedure TForm1.AppLink3_LItemMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
//  PlatFormAPI.CrossApi.AppStoreLink( 3 );
end;



end.
