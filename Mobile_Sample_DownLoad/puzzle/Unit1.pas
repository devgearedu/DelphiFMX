unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Colors, FMX.Ani, FMX.TabControl, FMX.Layouts,
  FMX.Controls.Presentation;

type
  TForm1 = class(TForm)
    Field1: TRectangle;
    Cell1: TRectangle;
    Cell2: TRectangle;
    Cell3: TRectangle;
    Cell4: TRectangle;
    Cell5: TRectangle;
    Cell6: TRectangle;
    Cell7: TRectangle;
    Cell8: TRectangle;
    Cell9: TRectangle;
    Cell10: TRectangle;
    Cell11: TRectangle;
    Cell12: TRectangle;
    Cell13: TRectangle;
    Cell14: TRectangle;
    Cell15: TRectangle;
    Cell16: TRectangle;
    Counter1: TLabel;
    Counter2: TLabel;
    Counter3: TLabel;
    Counter4: TLabel;
    Counter5: TLabel;
    Counter6: TLabel;
    Counter7: TLabel;
    Counter8: TLabel;
    Counter9: TLabel;
    Counter10: TLabel;
    Counter11: TLabel;
    Counter12: TLabel;
    Counter13: TLabel;
    Counter14: TLabel;
    Counter15: TLabel;
    Counter16: TLabel;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    sbPlay: TSpeedButton;
    ImageLogo: TImage;
    ToolBar1: TToolBar;
    sbBackMenu: TSpeedButton;
    ToolBar2: TToolBar;
    ImageSteps: TImage;
    LabelSteps: TLabel;
    ImageTime: TImage;
    LabelTime: TLabel;
    sbGameUpdate: TSpeedButton;
    Timer1: TTimer;
    Layout1: TLayout;
    sbStatistics: TSpeedButton;
    procedure RectangleAllMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure RectangleAllMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Single);
    procedure FormCreate(Sender: TObject);
    procedure sbPlayClick(Sender: TObject);
    procedure sbBackMenuClick(Sender: TObject);
    procedure sbGameUpdateClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
    FXPosOld, FYPosOld: Single;
    FPressKey, FAnimateNotRun: Boolean;
    FSendItem: TRectangle;
  public
    { Public declarations }
    function CheckVictory: Boolean;
    procedure ClearGame;
    procedure AnimateFloatWaitStatus(const AParent: TFmxObject;
      const APropertyName: string; const NewValue: Single;
      Duration: Single = 0.2; AType: TAnimationType = TAnimationType.In;
      AInterpolation: TInterpolationType = TInterpolationType.Linear);
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  System.DateUtils, System.Math;

procedure TForm1.RectangleAllMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Single);
var
  ItemOne, ItemTwo: TRectangle;
  XPosDiff, YPosDiff: Single;
  ItemTagTemp: integer;
begin

  if (FPressKey = FAnimateNotRun) AND (Sender is TRectangle) then
  begin

    ItemOne := TRectangle(Sender); // На?ни?проносит? курсор ил?пале?:)
    ItemTwo := FSendItem; // Выбранны?итем

    if ItemOne.TagString = '' then
    begin

      XPosDiff := Abs(ItemOne.Position.X - ItemTwo.Position.X);
      YPosDiff := Abs(ItemOne.Position.Y - ItemTwo.Position.Y);

      if ((ItemOne.Position.X = ItemTwo.Position.X) OR
        (ItemOne.Position.Y = ItemTwo.Position.Y)) AND
        ((XPosDiff <= ItemTwo.Width) AND (YPosDiff <= ItemTwo.Height)) then
      begin

        ItemTagTemp := ItemTwo.Tag;
        ItemTwo.Tag := ItemOne.Tag;
        ItemOne.Tag := ItemTagTemp;

        if (ItemOne.Position.X = ItemTwo.Position.X) then
        begin
          ItemOne.Visible := False;
          AnimateFloatWaitStatus(ItemTwo, 'Position.Y', ItemOne.Position.Y, 0.2,
            TAnimationType.In, TInterpolationType.Linear);
          ItemOne.Visible := True;
          ItemOne.Position.Y := FYPosOld;
        end
        else
        begin
          ItemOne.Visible := False;
          AnimateFloatWaitStatus(ItemTwo, 'Position.X', ItemOne.Position.X, 0.2,
            TAnimationType.In, TInterpolationType.Linear);
          ItemOne.Visible := True;
          ItemOne.Position.X := FXPosOld;
        end;

        if CheckVictory then
        begin
          Timer1.Enabled := False;
          showmessage('Победа!');
        end;

        LabelSteps.Text := IntToStr(StrToInt(LabelSteps.Text) + 1);

      end;
      FPressKey := False;

    end;

  end;

end;

procedure TForm1.sbBackMenuClick(Sender: TObject);
begin
  TabControl1.ActiveTab := TabItem1;
  ClearGame;
end;

procedure TForm1.sbGameUpdateClick(Sender: TObject);
begin
  ClearGame;

  sbGameUpdate.Enabled := False;
  sbPlayClick(Self);
  sbGameUpdate.Enabled := True;
end;

procedure TForm1.sbPlayClick(Sender: TObject);
var
  i, RndNumOne, RndNumTwo, ItemTagTemp: integer;
  ItemOne, ItemTwo: TRectangle;
  ItemOnePosX, ItemOnePosY: Single;
const
  NamePrefixCell = 'Cell';
  NumberOfCells = 16;
begin

  TabControl1.ActiveTab := TabItem2;

  for i := 1 to 8 do
  begin

    RndNumOne := RandomRange(1, NumberOfCells);
    RndNumTwo := RandomRange(1, NumberOfCells);
    if FAnimateNotRun then
    begin
      if RndNumOne <> RndNumTwo then
      begin

        ItemOne := TRectangle
          (FindComponent(NamePrefixCell + IntToStr(RndNumOne)));
        ItemTwo := TRectangle
          (FindComponent(NamePrefixCell + IntToStr(RndNumTwo)));

        ItemOnePosX := ItemOne.Position.X;
        ItemOnePosY := ItemOne.Position.Y;

        AnimateFloatWaitStatus(ItemOne, 'Position.Y', ItemTwo.Position.Y, 0.2,
          TAnimationType.In, TInterpolationType.Linear);
        AnimateFloatWaitStatus(ItemOne, 'Position.X', ItemTwo.Position.X, 0.2,
          TAnimationType.In, TInterpolationType.Linear);

        AnimateFloatWaitStatus(ItemTwo, 'Position.Y', ItemOnePosY, 0.2,
          TAnimationType.In, TInterpolationType.Linear);
        AnimateFloatWaitStatus(ItemTwo, 'Position.X', ItemOnePosX, 0.2,
          TAnimationType.In, TInterpolationType.Linear);

        ItemTagTemp := ItemTwo.Tag;
        ItemTwo.Tag := ItemOne.Tag;
        ItemOne.Tag := ItemTagTemp;

      end;

    end;
  end;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  LabelTime.Text := TimeToStr(IncSecond(StrToTime(LabelTime.Text), 1));
end;

procedure TForm1.AnimateFloatWaitStatus(const AParent: TFmxObject;
  const APropertyName: string; const NewValue: Single; Duration: Single;
  AType: TAnimationType; AInterpolation: TInterpolationType);
var
  A: TFloatAnimation;
begin
  StopPropertyAnimation(APropertyName);
  A := TFloatAnimation.Create(Self);
  try
    A.Parent := AParent;
    A.AnimationType := AType;
    A.Interpolation := AInterpolation;
    A.Duration := Duration;
    A.PropertyName := APropertyName;
    A.StartFromCurrent := True;
    A.StopValue := NewValue;
    A.Start;
    while A.Running do
    begin
      FAnimateNotRun := False;
      Application.ProcessMessages;
      Sleep(0);
    end;
  finally
    FAnimateNotRun := True;
    A.DisposeOf;
  end;
end;

function TForm1.CheckVictory: Boolean;
var
  i: integer;
  compares: Boolean;
  item_one, item_two: TRectangle;
const
  NamePrefix = 'Cell';
  NumberOfCells = 15; // -1 ячейк?
begin

  compares := True;

  for i := 1 to NumberOfCells do
  begin
    item_one := TRectangle(FindComponent(NamePrefix + IntToStr(i)));
    item_two := TRectangle(FindComponent(NamePrefix + IntToStr(i + 1)));
    if (item_one.Tag > item_two.Tag) then
    begin
      compares := False;
      break;
    end;
  end;

  Result := compares;
end;

procedure TForm1.ClearGame;
begin
  Timer1.Enabled := False;
  LabelSteps.Text := '0';
  LabelTime.Text := '0:00:00';
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  SizeCell, i: integer;
  x, y: integer;
  ItemCell: TRectangle;
  ItemText: TLabel;
const
  NamePrefixText = 'Counter';
  NamePrefixCell = 'Cell';
  NumberOfCells = 16;
begin

  Timer1.Enabled := False;

  TabControl1.ActiveTab := TabItem1;

  Field1.Width := Trunc(Form1.ClientWidth - 18);
  Field1.Height := Field1.Width;
  SizeCell := Trunc(Field1.Width) div 4;

  Randomize;

  x := 1;
  y := 1;

  for i := 1 to NumberOfCells do
  begin
    ItemText := TLabel(FindComponent(NamePrefixText + IntToStr(i)));
    ItemText.Text := i.ToString;

    ItemCell := TRectangle(FindComponent(NamePrefixCell + IntToStr(i)));
    ItemCell.TagString := i.ToString;
    ItemCell.Parent := TRectangle(FindComponent('Field1'));
    ItemCell.Width := SizeCell;
    ItemCell.Height := SizeCell;

    ItemCell.Position.X := (SizeCell * x) - SizeCell + 1;

    if x = 4 then
    begin
      x := 1;
    end
    else
    begin
      Inc(x);
    end;

    ItemCell.Position.Y := (SizeCell * y) - SizeCell + 1;

    if (Frac(i/4) = 0) AND (Trunc(i) mod 4 = 0) then
    begin
      y := (i div 4) + 1;
    end;

    if i = NumberOfCells then
    begin
      ItemText.Text := '';
      ItemCell.TagString := '';
    end;
  end;
  // Анимац? не запущена
  FAnimateNotRun := True;

end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if (Key = vkHardwareBack) AND (TabControl1.ActiveTab <> TabItem1) then
  begin
    TabControl1.ActiveTab := TabItem1;
    ClearGame;
    Key := 0;
  end;
end;

procedure TForm1.RectangleAllMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  Item: TRectangle;
begin

  if FAnimateNotRun AND (Sender is TRectangle) then
  begin

    Item := TRectangle(Sender);
    FXPosOld := Item.Position.X;
    FYPosOld := Item.Position.Y;

    FPressKey := True;

    FSendItem := Item;

    if not Timer1.Enabled then
    begin
      Timer1.Enabled := True;
    end;

  end;

end;

end.
