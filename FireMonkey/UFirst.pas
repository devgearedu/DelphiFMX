unit UFirst;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Objects,system.uiconsts;

type
  TForm219 = class(TForm)
    Layout1: TLayout;
    Button1: TButton;
    StyleBook1: TStyleBook;
    Button2: TButton;
    Button3: TButton;
    Text1: TText;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form219: TForm219;

implementation

{$R *.fmx}
{$R *.XLgXhdpiTb.fmx ANDROID}
{$R *.iPhone47in.fmx IOS}
{$R *.SmXhdpiPh.fmx ANDROID}
{$R *.NmXhdpiPh.fmx ANDROID}

procedure TForm219.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TForm219.Button3Click(Sender: TObject);
begin
  Text1.TextSettings.FontColor := clared;
  button1.TextSettings.FontColor := claRed;
end;

end.
