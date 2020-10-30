unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Controls.Presentation, FMX.StdCtrls, System.ImageList,
  FMX.ImgList, FMX.Objects;

type
  TForm1 = class(TForm)
    ListView1: TListView;
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    Button2: TButton;
    Button1: TButton;
    procedure ListView1UpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListView1Resized(Sender: TObject);
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
  ListView1.ItemSpaces := TBounds.Create(RectF(0, 0, 0, 0));
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Item: TListViewitem;
begin
  Item := ListView1.Items.Add;
  Item.Data['Text1'] := '김현수';
  Item.Data['Text2'] := '남자';
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Item: TListViewitem;
begin
  Item := ListView1.Items.Add;
  Item.Data['Text1'] := '아이유';
  Item.Data['Text2'] := '여자';
//  (Item.Objects.ObjectByName('Image2') as TListItemImage).Bitmap := ImageList1.Bitmap(TSizeF.Create(16, 16), 1);
end;

function FindTextObject(const AListView: TListView; AName: string): TCommonObjectAppearance;
var
  Obj: TCommonObjectAppearance;
begin
  Result := nil;

  for Obj in AListView.ItemAppearanceObjects.ItemObjects.Objects do
  begin
    if Obj.Name = AName then
      Exit(Obj as TCustomTextObjectAppearance);
  end;
end;

procedure TForm1.ListView1Resized(Sender: TObject);
var
  Text1, Text2: TCommonObjectAppearance;
begin
  Text1 := FindTextObject(ListView1, 'Text1');
  Text2 := FindTextObject(ListView1, 'Text2');

  Text1.Width := ListView1.Width / 2;
  Text2.PlaceOffset.X := Text1.Width;
  Text2.Width := ListView1.Width / 2;
end;

procedure TForm1.ListView1UpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
var
  ImageItem: TListItemImage;
  TextItem: TListItemText;
begin
  ImageItem := AItem.Objects.DrawableByName('Image2') as TListItemImage;
  TextItem := AItem.Objects.DrawableByName('Text2') as TListItemText;

  if Assigned(ImageItem) then
  begin
    if AItem.Data['Text1'].ToString = '김현수' then
      ImageItem.Bitmap := ImageList1.Bitmap(TSizeF.Create(16, 16), 0)
    else
      ImageItem.Bitmap := ImageList1.Bitmap(TSizeF.Create(16, 16), 1)
    ;
    ImageItem.Visible := True;
  end;

  if Assigned(TextItem) then
  begin
    if Textitem.Text = '여자' then
      Textitem.Font.Style := [TFontStyle.fsBold, TFontStyle.fsItalic];
  end;
end;

end.
