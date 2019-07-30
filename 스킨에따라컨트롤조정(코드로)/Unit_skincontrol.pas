unit Unit_skincontrol;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation;

type
  TForm1 = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    StatusBar1: TStatusBar;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    FixdButton: TButton;
    Button5: TButton;
    Label1: TLabel;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    Rectangle6: TRectangle;
    procedure FormResize(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    WD : single;
    procedure ButtonSizeSet;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

//*******************************************************
procedure TForm1.FormResize(Sender: TObject);
begin
  ButtonSizeSet();
end;

//------------------------------------------------------
// http://community.embarcadero.com/index.php/blogs/entry/xe7-dialog-box-methods-support-anonymous-methods-to-handle-their-closing
procedure TForm1.Button1Click(Sender: TObject);
begin

  MessageDlg('Choose a button:', System.UITypes.TMsgDlgType.mtInformation,
    [
      System.UITypes.TMsgDlgBtn.mbYes,
      System.UITypes.TMsgDlgBtn.mbNo,
      System.UITypes.TMsgDlgBtn.mbCancel
    ], 0,

      // Use an anonymous method to make sure the acknowledgment appears as expected.
      procedure(const AResult: TModalResult)
      begin
        case AResult
          of
          { Detect which button was pushed and show a different message }
          mrYES:
            ShowMessage('You chose Yes');
          mrNo:
            ShowMessage('You chose No');
          mrCancel:
            ShowMessage('You chose Cancel');
        end;
      end
    )
end;

procedure TForm1.ButtonSizeSet;
var
  bw : single;
const
  BH = 60;   // 버튼 높이
  sp = 20;   // 버튼 간격
begin
  WD := Form1.ClientWidth;   // = Layout1.Width
  bw := ( WD - ( sp*4 ) )/ 3;    // 버튼 width

  Button1.Width := bw;      Button1.Height := BH;
  Button2.Width := bw;      Button2.Height := BH;
  Button3.Width := bw;      Button3.Height := BH;

  Button1.Position.X := sp;           Button1.Position.Y := 20;
  Button2.Position.X := sp*2 + bw;    Button2.Position.Y := 20;
  Button3.Position.X := sp*3 + bw*2;  Button3.Position.Y := 20;

  //---------------------------------------------------
  FixdButton.Width  := 100;
  FixdButton.Height := BH;
  FixdButton.Position.X := sp;    FixdButton.Position.Y := 100;

  Button5.Width  := WD - sp*3 - FixdButton.Width;
  Button5.Height := BH;
  Button5.Position.X := sp*2 + FixdButton.Width;
  Button5.Position.Y := 100;
end;



end.
