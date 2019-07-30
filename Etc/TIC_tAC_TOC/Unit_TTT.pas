unit Unit_TTT;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls;

type
  TXOPosArray = array [1..3, 1..3] of Integer;

  TMainForm = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    ToolBar2: TToolBar;
    Panel1: TPanel;
    CornerButton1: TCornerButton;
    lblXScore: TLabel;
    Button1: TButton;
    Button5: TButton;
    Button7: TButton;
    Button8: TButton;
    Button4: TButton;
    Button2: TButton;
    Button9: TButton;
    Button6: TButton;
    Button3: TButton;
    StyleBook1: TStyleBook;
    procedure FormCreate(Sender: TObject);
    procedure CornerButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure InitPlayGround;
    function FindButton(sName:string):TButton;
    function GamePlay(xo_Move:Integer):integer;
    function CheckWin(iPos:TXOPosArray):integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

  iXPos : TXOPosArray;
  iOPos : TXOPosArray;
  sPlaySign : String;
  bGameOver : Boolean;
  iMove : Integer;
  nAngle : Integer;
implementation
function TMainForm.CheckWin(iPos: TXOPosArray): integer;
var
  iScore : Integer;
  i : Integer;
  j : Integer;
begin
  Result := -1;

  iScore := 0;
  for i := 1 to 3 do begin
    iScore := 0;
    Inc(Result);
    for j := 1 To 3 do begin
      Inc(iScore, iPos[i,j]);
    end;
    if iScore = 3 Then begin
      Exit
    end;
  end;

  iScore := 0;
  Inc(Result);
  for i := 1 to 3 do begin
    Inc(iScore, iPos[i,i]);
  end;
  if iScore = 3 then begin
    Exit;
  end;

  iScore := 0;
  Inc(Result);
  for i := 1 to 3 do begin
    Inc(iScore, iPos[i,4-i]);
  end;
  if iScore = 3 then begin
    Exit;
  end;

  for i := 1 to 3 do begin
    iScore := 0;
    Inc(Result);
    for j := 1 to 3 do begin
      Inc(iScore, iPos[j,i]);
    end;
    if iScore = 3 then begin
      Exit;
    end;
  end;
  Result := -1;

end;


procedure TMainForm.Button1Click(Sender: TObject);
var
  iWin : integer;
  CellIndex : 0..8;
begin

  if bGameOver = True then
    Exit;
  if TLabel(Sender).Text <> '' then
    Exit;

  TButton(Sender).AnimateFloat('Position.y', TButton(Sender).Position.Y, 0.2);
  TButton(Sender).AnimateFloat('RotationAngle', 180, 0.3);
  TButton(Sender).AnimateFloat('RotationAngle', -180, 0.3);

  CellIndex := TButton(Sender).Tag;
  iWin := GamePlay(CellIndex);
end;



procedure TMainForm.CornerButton1Click(Sender: TObject);
begin
  Panel1.AnimateFloat('RotationAngle', nAngle, 1.0);
  nAngle := -nAngle;

  InitPlayGround;
end;

function TMainForm.FindButton(sName:string): TButton;
var
  i:integer;
begin

  for i := 0 to Self.ComponentCount-1 do begin
    if Self.Components[i] is TButton then begin
      if TButton(Self.Components[i]).Name = sName then
      begin
        Result := TButton(Self.Components[i]);
        exit;
      end;
    end;
  end;

end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  nAngle := 180;
  InitPlayGround;
end;

function TMainForm.GamePlay(xo_Move: Integer): integer;
var
  x, y:1..3;
  iWin:integer;
  sText:string;
begin
  Result := -1;

  Inc(iMove);
  x := (xo_Move Div 3) + 1;
  y := (xo_Move Mod 3) + 1;

  if sPlaySign = 'O' then begin
    iOPos[x,y] := 1;
    iWin := CheckWin(iOPos);
  end else begin
    iXPos[x,y] := 1;
    iWin := CheckWin(iXPos);
  end;

  sText := 'Button' + IntToStr(xo_Move+1);
  FindButton(sText).Text := sPlaySign;

  Result := iWin;
  if sPlaySign = 'O' Then begin
    sPlaySign := 'X'
  end else begin
    sPlaySign := 'O';
  end;

  if iWin >= 0 then begin
     bGameOver := True;

    if sPlaySign = 'X' then begin
      sPlaySign := 'O';
    end else begin
      sPlaySign := 'X';
    end;
    lblXScore.Text := sPlaySign + ' - Wins!';
  end;

  if (iMove = 9) AND (bGameOver = False) Then begin
    lblXScore.Text := 'Draw!';
    bGameOver := True
  end;

end;

procedure TMainForm.InitPlayGround;
var
  i, j, k: integer;
  sText:string;
begin

  for i := 1 to 3 do begin
    for j := 1 To 3 do begin
      k:= (i - 1) * 3 + j - 1;
      sText := 'Button' + IntToStr(k+1);
      FindButton(sText).Text := '';
      iXPos[i, j] := 0;
      iOPos[i][j] := 0;
    end;
  end;

  lblXScore.Text := 'Start!';
  sPlaySign := 'X';
  bGameOver := False;
  iMove := 0;

end;

{$R *.fmx}

end.
