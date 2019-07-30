unit Unit_STYLE;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FMX.ListBox,System.UIConsts,
  FMX.Controls.Presentation;

type
  TForm3 = class(TForm)
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    OpenDialog1: TOpenDialog;
    StyleBook1: TStyleBook;
    Label1: TLabel;
    Text1: TText;
    procedure Button1Click(Sender: TObject);
    procedure Text1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation
uses
  FMX.Styles;

{$R *.fmx}

procedure TForm3.Button1Click(Sender: TObject);
begin
//    TStyleManager.SetStyleFromFile(OpenDialog1.FileName);
  if OpenDialog1.Execute then
  begin
      TStyleManager.SetStyleFromFile(OpenDialog1.FileName);

//     StyleBook1.FileName := OpenDialog1.FileName;
     ListBox1.Items.Add('Picked Style ' +
     ExtractFileName(OpenDialog1.FileName));
  end;
end;

procedure TForm3.Button2Click(Sender: TObject);
var
  aText:TText;
begin
   aText := Button2.FindStyleResource('text') as TTEXT;
   aText.Color := claRed;

//  Label1.StyledSettings := Label1.StyledSettings - [TStyledSetting.ssFontColor];
//  Label1.FontColor := claRed;
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  if Button3.StyleLookup = 'MyButtonStyle' then
     Button3.StyleLookup := 'ButtonStyle'
  else
     Button3.StyleLookup := 'MyButtonStyle';

end;

procedure TForm3.Button4Click(Sender: TObject);
var

listItem: TListBoxItem;
itemText: TText;
itemImage: TImage;

begin
 // create a new custom listbox item
 ListBox1.Items.Clear;
 listItem := TListBoxItem.Create(ListBox1);
 listItem.Parent := ListBox1;
 listItem.Height := 150;

 itemText := TText.Create (ListBox1);
 itemText.Parent := listItem;
 itemText.Position.X :=  5;
 itemText.Position.Y  := 5;
 itemText.Width := 190;
 itemText.Text :=  'Blue_0.png';
 itemText.Font.Size := 16;

 itemImage := TImage.Create(ListBox1);

 itemImage.Parent  := ListItem;
 itemImage.Position.X  := 5;
 itemImage.Position.Y := 5;
 itemImage.Bitmap.LoadFromFile ('Blue_0.png');
 listItem.Height := itemImage.Bitmap.Height;
end;

procedure TForm3.Button5Click(Sender: TObject);
var

  listItem: TListBoxItem;
  itemText: TText;
  itemImage: TImage;
begin

// create a new custom listbox item
 ListBox1.Items.Clear;
 listItem := TListBoxItem.Create(ListBox1);
 listItem.Parent := ListBox1;

// force the items style, creating sub-elements
  listItem.StyleLookup := 'NewStyle';

// customize the text
 itemText := listItem.FindStyleResource ('TextItem') as TText;
 if Assigned (itemText) then
    itemText.Text := 'Blue_0.png';


// customize the image
 itemImage := (listItem.FindStyleResource('ImageItem') as TImage);
 if Assigned (itemImage) then
 begin
   itemImage.Bitmap.LoadFromFile ('Blue_0.png');
   listItem.Height := itemImage.Bitmap.Height;
 end
 else
   ShowMessage ('Image binding element not found');
end;

procedure TForm3.Text1Click(Sender: TObject);
begin
  if Text1.Color = claBlack then
     Text1.Color := claWhite
  else
     Text1.Color := claBlack;
end;

end.
