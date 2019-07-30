
{*****************************************************************************}
{    FIREBLAZE                                                                }
{    TSprite class & Component for Delphi FireMonkey                          }
{                                                                             }
{    Copyright (c) 2013 Gilberto Padilla All Rights Reserved                  }
{                                                                             }
{       Comments and Donations To:                                            }                                                                              {                                                                             }
{       email: maravillasoft@hotmail.com                                      }
{       Web: http://fireblazefmx.wordpress.com/                               }
{                                                                             }
{                                                                             }
{    THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND,          }
{    EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED    }
{    MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.                 }
{                                                                             }
{*****************************************************************************}


unit FBSprite;

interface

uses
  System.SysUtils, System.Classes, System.Types, FMX.Types, FMX.Objects, FMX.Dialogs;

type
  TSprite = class(TControl)
  private
    FFrame: TBitmap;
    FSpriteSheet: TBitmap;
    FSpriteSheetFile: TFileName;
    FFramesList: TStringList;
    FFrameListFile: TFileName;
    FFrameCount: Integer;
    FFrameNumber: Integer;
    FTimer: TTimer;
    FLoop: Boolean;
    FInterval: Cardinal;
    FReverse: Boolean;
    FStartFrame: Integer;
    FEndFrame: Integer;
    FrameX: Integer;
    FrameY: Integer;
    FFlippedX : Boolean;
    FFlippedY : Boolean;
    procedure OnTimer(Sender: TObject);
    procedure SetInterval(const Value: Cardinal);
    procedure SetLoop(const Value: Boolean);
    Procedure SetSheetFile(Value: TFileName);
    Procedure SetFrameListFile(Value: TFileName);
    Procedure SetFrameSize(index: integer);
  protected
    Procedure DrawFrame(Number: Integer);
    procedure Paint; override;
    procedure FFrameChanged(Sender: TObject); virtual;
    function GetToken(Str,Delim: string; TokenNo:integer):string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    Procedure NextFrame;
    Procedure PriorFrame;
    Procedure Motion;
    Procedure MoveToFrame(Value: Integer);
    Procedure SetFrameRange(StartF, EndF: Integer);
    Procedure LoadSpriteSheet(Img: String); Overload;
    procedure LoadSpriteSheet(const Img: TBitmap); Overload;
    Procedure LoadSpriteSheetTxt(Value: String); Overload;
    procedure LoadSpriteSheetTxt(const value: TStrings); Overload;
  published
   property FrameCount: Integer read FFrameCount write FFrameCount;
   property FrameNumber: Integer read FFrameNumber;
   property StartFrame: Integer read FStartFrame write FStartFrame;
   property EndFrame: Integer read FEndFrame write FEndFrame;
   property Reverse: Boolean read FReverse write FReverse;
   property FlippedX: Boolean read FFlippedX write FFlippedX;
   property FlippedY: Boolean read FFlippedY write FFlippedY;
   property Interval: Cardinal read FInterval write SetInterval;
   property Loop: Boolean read FLoop write SetLoop;
   property SpriteSheetFile: TFileName read FSpriteSheetFile write SetSheetFile;
   property FrameListFile: TFileName read FFrameListFile write SetFrameListFile;
   Property FramesList: TStringList read FFramesList;
   Property SpriteSheet: TBitmap read FSpriteSheet;
  end;

procedure Register;

implementation
 constructor TSprite.Create(AOwner: TComponent);
begin
  inherited;
  FFrame := TBitmap.Create(0, 0);
  FSpriteSheet := TBitmap.Create(0, 0);
  FFramesList:= TStringList.Create;
  if not (csDesigning in ComponentState) then
  begin
  FTimer := TTimer.Create(AOwner);
  FTimer.OnTimer := OnTimer;
  FTimer.Interval := FInterval;
  FTimer.Enabled := False;
  end;
  FLoop := False;
  FReverse := False;
  FFrame.OnChange := FFrameChanged;
  SetAcceptsControls(False);
end;

Procedure TSprite.DrawFrame(Number: Integer);
  begin
    SetFrameSize(Number);
    FFrameNumber := Number;
    Width := FFrame.Width;
    Height := FFrame.Height;
    FFrame.Clear(clanull);
    FFrame.Canvas.BeginScene;
    FFrame.Canvas.DrawBitmap(FSpriteSheet,
            RectF(FrameX, FrameY, FrameX + FFrame.Width, FrameY + FFrame.Height),
            RectF(0, 0, FFrame.Width , FFrame.Height), 1);
    FFrame.Canvas.EndScene;
    if FFlippedX then FFrame.FlipHorizontal;
    if FFlippedY then FFrame.FlipVertical;
    Repaint;
  end;

Procedure TSprite.SetFrameSize(index: integer);
   Begin
    FrameX := StrToInt(GetToken(FFramesList.Strings[Index],' ', 1));
    FrameY := StrToInt(GetToken(FFramesList.Strings[Index],' ', 2));
    FFrame.Width := StrToInt(GetToken(FFramesList.Strings[Index],' ', 3));
    FFrame.Height := StrToInt(GetToken(FFramesList.Strings[Index],' ', 4));
   End;

procedure TSprite.NextFrame;
begin
 if FFrameNumber < FEndFrame then
 DrawFrame(FFrameNumber+1)
 else
  FFrameNumber := FStartFrame;
end;

procedure TSprite.PriorFrame;
begin
 if FFrameNumber > FStartFrame then
   DrawFrame(FFrameNumber-1)
 else
   FFrameNumber := FEndFrame;
end;

procedure TSprite.MoveToFrame(Value: Integer);
 begin
   if (Value <= FEndFrame) and (Value >= FStartFrame) then
      DrawFrame(Value);
 end;

 procedure TSprite.Motion;
  begin
  if FReverse then
    begin
   if FFrameNumber <= FStartFrame then FFrameNumber := FEndFrame;
      DrawFrame(FFrameNumber);
      Dec(FFrameNumber);
    end
   else
    begin
     if FFrameNumber >= FEndFrame then FFrameNumber := FStartFrame;
       DrawFrame(FFrameNumber);
       Inc(FFrameNumber);
    end;
  end;

procedure TSprite.OnTimer(Sender: TObject);
begin
 Motion;
end;

destructor TSprite.Destroy;
begin
  FFrame.Free;
  FSpriteSheet.Free;
  FFramesList.Free;
  FreeAndNil(FTimer);
  inherited;
end;

procedure TSprite.Paint;
var
  DrawArea: TRectF;
  State: TCanvasSaveState;
  R: TRectF;
begin
 if (csDesigning in ComponentState) and not Locked and not FInPaintTo then
  begin
    R := LocalRect;
    InflateRect(R, -0.5, -0.5);
    Canvas.StrokeThickness := 2;
    Canvas.Stroke.Kind := TBrushKind.bkSolid;
    Canvas.Stroke.Color := $A0909090;
    Canvas.DrawRect(R, 0, 0, AllCorners, AbsoluteOpacity);
    Canvas.StrokeDash := TStrokeDash.sdSolid;
    Canvas.FillText(R, 'FireBlaze TSprite', false, 100, [], TTextAlign.taLeading,TTextAlign.taCenter);

  end;

  if FFrame.IsEmpty then
       Exit;

  State := Canvas.SaveState;
  Canvas.IntersectClipRect(LocalRect);
  DrawArea := RectF(0, 0, FFrame.Width, FFrame.Height);
  Canvas.DrawBitmap(FFrame, RectF(0, 0, FFrame.Width, FFrame.Height), DrawArea,
  AbsoluteOpacity, True);
  Canvas.RestoreState(State);
 end;

procedure TSprite.SetFrameRange(StartF, EndF: Integer);
 begin
  FStartFrame := StartF;
  FEndFrame := EndF;
 end;

procedure TSprite.SetInterval(const Value: Cardinal);
 begin
  if not (csDesigning in ComponentState) then
   FTimer.Interval := Value
  else
   FInterval := Value;
 end;

procedure TSprite.SetLoop(const Value: Boolean);
 begin
  if not (csDesigning in ComponentState) then
   FTimer.Enabled := Value
  else
   FLoop := Value;
 end;

procedure TSprite.SetFrameListFile(Value: TFileName);
begin
   FFramesList.LoadFromFile(Value);
   FFrameListFile := Value;
end;

procedure TSprite.SetSheetFile(Value: TFileName);
begin
   FSpriteSheet.LoadFromFile(Value);
   FSpriteSheetFile := Value;
end;

procedure TSprite.FFrameChanged(Sender: TObject);
begin
  Repaint;
  UpdateEffects;
end;

procedure TSprite.LoadSpriteSheet(Img: String);
begin
 FSpriteSheet.LoadFromFile(Img);
end;

procedure TSprite.LoadSpriteSheet(const Img: TBitmap);
begin
  FSpriteSheet.Assign(Img);
end;

procedure TSprite.LoadSpriteSheetTxt(Value: String);
 begin
  FFramesList.LoadFromFile(Value);
 end;

procedure TSprite.LoadSpriteSheetTxt(const Value: TStrings);
 begin
  FFramesList.Assign(Value);
 end;

Function TSprite.GetToken(Str,Delim:string;TokenNo:integer):string;
 var
  Position:integer;
 begin
  while TokenNo > 1 do begin
   Delete(Str,1,Pos(Delim,Str));
   Dec(TokenNo);
 end;
  Position := Pos(Delim,Str);
 if Position = 0 then result := Str
   else Result := Copy(Str,1,Position-Length(Delim));
 end;

procedure Register;
begin
  RegisterComponents('Fire Blaze', [TSprite]);
end;

end.

