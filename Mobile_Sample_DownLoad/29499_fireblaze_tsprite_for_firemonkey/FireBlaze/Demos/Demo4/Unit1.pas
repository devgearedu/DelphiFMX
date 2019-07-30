unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FBSprite, FMX.Objects;

type
  TForm1 = class(TForm)
    Sprite1: TSprite;
    Timer1: TTimer;
    Image1: TImage;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
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

procedure TForm1.FormResize(Sender: TObject);
begin
image1.Width := Form1.ClientWidth;
image1.Height := Form1.ClientHeight;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
   if (Sprite1.Position.X + Sprite1.Width < image1.Width) then
     Sprite1.Position.X := Sprite1.Position.X + 5;

end;

end.
