unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Objects, FMX.Ani, FBSprite;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    Sprite1: TSprite;
    PathAnimation1: TPathAnimation;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
Var s, t: String;
 i: integer;
begin
   for i := 0 to 3 do
    begin
    case i of
     0:  begin
         s:= 'alien1.png';
         t:= 'alien1.txt';
         end;
     1:  begin
         s:= 'alien2.png';
         t:= 'alien2.txt';
         end;
    2:  begin
         s:= 'alien3.png';
         t:= 'alien3.txt';
         end;
    3:  begin
         s:= 'alien4.png';
         t:= 'alien4.txt';
         end;
    end;
    Sprite1 := TSprite.Create(Self);
    Sprite1.Parent := Form1;
    Sprite1.Position.X := 10;
    Sprite1.Position.Y := 100;
    Sprite1.Width := 200;
    Sprite1.Height := 200;
    Sprite1.LoadSpriteSheet(s);
    Sprite1.LoadSpriteSheetTxt(t);
    Sprite1.FrameCount := 2;
    Sprite1.Loop := true;
    Sprite1.Interval := 200;
    Sprite1.SetFrameRange(0,2);
    Sprite1.Enabled := True;
    Sprite1.Visible := true;
    PathAnimation1 := TPathAnimation.Create(Self);
    PathAnimation1.Parent := Sprite1;
    PathAnimation1.Path.MoveTo(PointF(Random(100)*50, 10));
    PathAnimation1.Path.LineTo(PointF(Random(30)*100,Random(5)*10));
    PathAnimation1.Path.LineTo(PointF(form1.Width - 60,0));
    PathAnimation1.Path.LineTo(PointF(form1.Height -60,form1.Height -60));
    PathAnimation1.Path.ClosePath;
    PathAnimation1.Loop := True;
    PathAnimation1.Duration := 30;
    PathAnimation1.Start;
    end;
end;

end.
