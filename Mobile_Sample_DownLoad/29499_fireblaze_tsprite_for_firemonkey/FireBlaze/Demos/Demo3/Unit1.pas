unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FBSprite, FMX.Objects;

type
  TForm1 = class(TForm)
    Sprite1: TSprite;
    Image1: TImage;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin
image1.Width := Form1.Width;
image1.Height := Form1.Height;
sprite1.LoadSpriteSheet('smurf_sprite.png');
sprite1.LoadSpriteSheetTxt('smurf.txt');
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
 if Key = vkRight then begin
     Sprite1.RotationAngle := 0;
     Sprite1.FlippedX := False;
     Sprite1.NextFrame;
     Sprite1.Position.X := Sprite1.Position.X + 3;
  end;

 if Key = vkLeft then
      Begin
        Sprite1.RotationAngle := 0;
        Sprite1.FlippedX := true;
        Sprite1.NextFrame;
        Sprite1.Position.X := Sprite1.Position.X - 3;
     End;

  if Key = vkUP then begin
     Sprite1.RotationAngle := -90;
     Sprite1.NextFrame;
     Sprite1.Position.Y := Sprite1.Position.Y - 3;
  end;

  if Key = vkDown then begin
     Sprite1.RotationAngle := 90;
     Sprite1.NextFrame;
     Sprite1.Position.Y := Sprite1.Position.Y + 3;
  end;

end;

procedure TForm1.FormResize(Sender: TObject);
begin
image1.Width := Form1.ClientWidth;
image1.Height := Form1.ClientHeight;
end;

end.
