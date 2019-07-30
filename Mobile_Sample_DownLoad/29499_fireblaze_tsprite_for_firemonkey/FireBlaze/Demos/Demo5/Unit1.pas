unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FBSprite;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Sprite1: TSprite;
    Timer1: TTimer;
    CheckBox6: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
    procedure CheckBox4Change(Sender: TObject);
    procedure CheckBox5Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CheckBox6Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
Checkbox6.IsChecked := false;
timer1.Enabled := false;
Sprite1.Loop := false;
Sprite1.PriorFrame;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
if Sprite1.Loop = True then
  Sprite1.Loop := False
  else
  Sprite1.Loop := true;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
Checkbox6.IsChecked := false;
timer1.Enabled := false;
Sprite1.Loop := false;
Sprite1.NextFrame;
end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
Sprite1.FlippedX := CheckBox1.IsChecked;
end;

procedure TForm1.CheckBox2Change(Sender: TObject);
begin
Sprite1.FlippedY := CheckBox2.IsChecked;
end;

procedure TForm1.CheckBox3Change(Sender: TObject);
begin
  if CheckBox3.IsChecked then
   Sprite1.RotationAngle := 90
  else
   Sprite1.RotationAngle := 0;
end;

procedure TForm1.CheckBox4Change(Sender: TObject);
begin
Sprite1.Reverse := CheckBox4.IsChecked;
end;

procedure TForm1.CheckBox5Change(Sender: TObject);
begin
if Checkbox5.IsChecked then
   timer1.Enabled := true
  else
   timer1.Enabled := false;
end;

procedure TForm1.CheckBox6Change(Sender: TObject);
begin
  if Checkbox6.IsChecked then
   Sprite1.Loop := True
  else
    Sprite1.Loop := False;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
Sprite1.LoadSpriteSheet('smurf.png');
Sprite1.LoadSpriteSheetTxt('smurf.txt');
Checkbox6.IsChecked := True;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
Sprite1.Motion;
end;

end.
