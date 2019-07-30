unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FBSprite;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Button1: TButton;
    Sprite1: TSprite;
    TrackBar1: TTrackBar;
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;
  X1 : integer;
  Y1 : integer;
  S1 : integer;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
 X1 := 1;
 Y1 := 1;
 S1 := 1;
timer1.Enabled := True;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Sprite1.Position.X := Sprite1.Position.X + Y1 * S1;
  Sprite1.Position.Y := Sprite1.Position.Y + X1 * S1;
  if Sprite1.Position.X + Sprite1.Width >= form1.Width then
   Y1 := -1;
  if Sprite1.Position.Y + Sprite1.Height > form1.Height then
   X1 := -1;
  if Sprite1.Position.X < S1 then
   begin
    Y1 := 1;
   end;
  if Sprite1.Position.Y < S1 then
   X1 := 1;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
S1 := Round(TrackBar1.Value);
end;

end.
