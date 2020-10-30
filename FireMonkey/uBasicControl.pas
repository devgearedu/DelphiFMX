unit UBasicControl;

interface

uses
  System.UIConsts,fmx.types3d,System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Layouts, FMX.ListBox, FMX.Colors, FMX.DateTimeCtrls,
  FMX.Controls.Presentation, FMX.Edit, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.Gestures,
  Data.Bind.Components, Data.Bind.DBScope, Data.DB, Datasnap.DBClient,
  FMX.ListView, System.Actions, FMX.ActnList, FMX.Grid.Style, Fmx.Bind.Grid,
  System.ImageList, FMX.ImgList, FMX.StdCtrls, FMX.Objects, Data.Bind.Grid,
  FMX.Grid, FMX.Filter,FMX.ScrollBox, FMX.Effects, FMX.Filter.Effects, FMX.Ani,fmx.viewport3d,fmx.layers3d;
type
  TForm28 = class(TForm)
    Layout1: TLayout;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    TabItem5: TTabItem;
    TabItem6: TTabItem;
    ListBox1: TListBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBox2: TListBox;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    ListBoxItem7: TListBoxItem;
    Edit1: TEdit;
    DateEdit1: TDateEdit;
    ColorComboBox1: TColorComboBox;
    ComboBox1: TComboBox;
    StyleBook1: TStyleBook;
    BindingsList1: TBindingsList;
    ListView1: TListView;
    ClientDataSet1: TClientDataSet;
    BindSourceDB1: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    GestureManager1: TGestureManager;
    ActionList1: TActionList;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    Grid1: TGrid;
    StringGrid1: TStringGrid;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    LinkGridToDataSourceBindSourceDB12: TLinkGridToDataSource;
    ImageList1: TImageList;
    Button1: TButton;
    Image2: TImage;
    Image3: TImage;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    ShadowEffect1: TShadowEffect;
    BlurEffect1: TBlurEffect;
    BandsEffect1: TBandsEffect;
    PaperSketchEffect1: TPaperSketchEffect;
    ImageControl2: TImageControl;
    Rectangle1: TRectangle;
    ColorAnimation1: TColorAnimation;
    ColorAnimation2: TColorAnimation;
    BitmapAnimation1: TBitmapAnimation;
    FloatAnimation1: TFloatAnimation;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ListBox3: TListBox;
    ShadowEffect3: TShadowEffect;
    ShadowEffect4: TShadowEffect;
    Button6: TButton;
    LayoutFilterSettings: TLayout;
    ImageContainer: TImageControl;
    Path1: TPath;
    AniIndicator1: TAniIndicator;
    Switch1: TSwitch;
    CornerButton1: TCornerButton;
    Edit13: TEdit;
    Label1: TLabel;
    ColorPanel1: TColorPanel;
    Circle1: TCircle;
    ComboColorBox1: TComboColorBox;
    AlphaTrackBar1: TAlphaTrackBar;
    BWTrackBar1: TBWTrackBar;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox3: TCheckBox;
    RoundRect1: TRoundRect;
    Text1: TText;
    PathAnimation1: TPathAnimation;
    PathLabel1: TPathLabel;
    Button5: TButton;
    TrackBar1: TTrackBar;
    LinkControlToPropertyXRadius: TLinkControlToProperty;
    procedure DateEdit1Change(Sender: TObject);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ListBox3Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
    procedure CheckBox4Change(Sender: TObject);
    procedure Switch1Switch(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ColorComboBox1Change(Sender: TObject);
  private
    fViewport: TViewport3D;
    FContainer: TLayer3D;
    FEffect: TFilter;
    FRawBitmap: TBitmap;
    procedure SwitchTo3D;
    procedure SwitchTo2D;
    procedure LoadFilterSettings(Rec: TFilterRec);
    procedure DoOnChangedEffectParam(Sender: TObject);
    { Private declarations }

    { Private declarations }
  public
    procedure SetEffect(const AFilterName: string);
    procedure UpdateEffect;

    { Public declarations }
  end;

var
  Form28: TForm28;

implementation

{$R *.fmx}

procedure TForm28.Button1Click(Sender: TObject);
begin
  Image3.Bitmap.Assign(imagelist1.Bitmap(image3.Bitmap.size, 1));
end;

procedure TForm28.Button2Click(Sender: TObject);
begin
   rectangle2.AnimateFloat('RotationAngle', 360, 3);
end;

procedure TForm28.Button3Click(Sender: TObject);
var
  ani :TFloatAnimation;
begin
  ani := TFloatAnimation.Create(rectangle3);
  ani.PropertyName := 'RotationAngle';
  ani.Duration := 3;
  ani.StopValue := 360;
  ani.Loop := true;
  ani.Parent := Rectangle3;
  ani.Start; //stop;
end;

procedure TForm28.Button4Click(Sender: TObject);
begin
  Grid1.AnimateFloat('Height',20,1);
  StringGrid1.AnimateFloat('Height',20,1);

  Grid1.AnimateFloatDelay('Position.Y',StringGrid1.Position.Y,1,1);
  StringGrid1.AnimateFloatDelay('Position.Y',Grid1.Position.Y,1,1);

  Grid1.AnimateFloatDelay('Height',200,1,2);
  StringGrid1.AnimateFloatDelay('Height',200,1,2);
end;


procedure TForm28.Button6Click(Sender: TObject);
begin
   FreeAndNil(FEffect);
   ImageContainer.Bitmap.assign(FRawBitmap);
end;

procedure TForm28.CheckBox1Change(Sender: TObject);
begin
   if checkBox1.IsChecked then
     CornerButton1.Corners := CornerButton1.Corners + [TCorner.TopLeft]
  else
     CornerButton1.Corners := CornerButton1.Corners - [TCorner.TopLeft]

end;

procedure TForm28.CheckBox2Change(Sender: TObject);
begin
   if checkBox2.IsChecked then
     CornerButton1.Corners := CornerButton1.Corners + [TCorner.TopRight]
  else
     CornerButton1.Corners := CornerButton1.Corners - [TCorner.TopRight]
end;

procedure TForm28.CheckBox3Change(Sender: TObject);
begin
   if checkBox3.IsChecked then
     CornerButton1.Corners := CornerButton1.Corners + [TCorner.BottomLeft]
  else
     CornerButton1.Corners := CornerButton1.Corners - [TCorner.BottomLeft]

end;

procedure TForm28.CheckBox4Change(Sender: TObject);
begin
   if checkBox3.IsChecked then
     CornerButton1.Corners := CornerButton1.Corners + [TCorner.BottomLeft]
  else
     CornerButton1.Corners := CornerButton1.Corners - [TCorner.BottomLeft]

end;

procedure TForm28.ColorComboBox1Change(Sender: TObject);
begin
   ListBoxItem6.TextSettings.FontColor :=  ColorComboBox1.Color;
end;

procedure TForm28.DateEdit1Change(Sender: TObject);
begin
  ListBoxItem5.Text := DateToStr(dateEdit1.Date);
end;

procedure TForm28.DoOnChangedEffectParam(Sender: TObject);
var
  TrackBarTmp: TTrackBar;
begin
  if not (Sender is TTrackBar) then
    Exit;
  TrackBarTmp := Sender as TTrackBar;
  FEffect.ValuesAsFloat[TrackBarTmp.TagString] := TrackBarTmp.Value;
  UpdateEffect;
end;

procedure TForm28.FormCreate(Sender: TObject);
begin
 FRawBitmap := TBitmap.Create(0, 0);
 FRawBitmap.Assign(ImageContainer.Bitmap);

end;

procedure TForm28.FormDestroy(Sender: TObject);
begin
 FreeAndNil(FRawBitmap);
end;

procedure TForm28.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  case EventInfo.GestureID of
    sgiSquare: ShowMessage('사각형');
    sgiCircle: ShowMessage('원');
    sgiTriAngle: ShowMessage('삼각형');
  end;
end;

procedure TForm28.ListBox3Change(Sender: TObject);
begin
  SetEffect(ListBox3.Items[ListBox3.ItemIndex]);

end;

procedure TForm28.LoadFilterSettings(Rec: TFilterRec);
var
  TB: TTrackBar;
  RecValue: TFilterValueRec;
begin
  LayoutFilterSettings.DeleteChildren;
  for RecValue in Rec.Values do
  begin
    if RecValue.ValueType <> TFilterValueType.Float then
      Continue;
    TB := TTrackBar.Create(Self);
    TB.Parent := LayoutFilterSettings;
    TB.Orientation := TOrientation.Vertical;
    TB.Align := TAlignLayout.Left;
    TB.Min := RecValue.Min.AsExtended;
    TB.Max := RecValue.Max.AsExtended;
    TB.Value := RecValue.Value.AsExtended;
    TB.TagString := RecValue.Name;
    TB.Tracking := False;
    TB.OnChange := DoOnChangedEffectParam;
end;
end;

procedure TForm28.SetEffect(const AFilterName: string);
var
  Rec: TFilterRec;
begin
  FreeAndNil(FEffect);

  FEffect := TFilterManager.FilterByName(AFilterName);
  if Assigned(FEffect) then
  begin
    // Create settings
    Rec := FEffect.FilterAttr;
    UpdateEffect;
    LoadFilterSettings(Rec);
  end;

end;

procedure TForm28.Switch1Switch(Sender: TObject);
begin
 if Switch1.IsChecked  then
     Showmessage('on')
  else
     Showmessage('off');
end;

procedure TForm28.SwitchTo2D;
begin
   Layout1.Parent := Self;
  { Free 3D }
  FreeAndNil(FViewport);
end;
procedure TForm28.SwitchTo3D;
begin
 { Create 3D viewport and layer }
  FViewport := TViewport3D.Create(Self);
  FViewport.Parent := Self;
  FViewport.Align := TAlignLayout.alClient;
  FViewport.Color := claNull;
  FContainer := TLayer3D.Create(FViewport);
  FContainer.Parent := FViewport;
  FContainer.Projection := TProjection.pjScreen;
  FContainer.Align := TAlignLayout.alClient;
  { Move object to 3D scene}
  Layout1.Parent := FContainer;
end;
procedure TForm28.Button5Click(Sender: TObject);
begin
 SwitchTo3D;
  if Assigned(FContainer) then
  begin
    FContainer.AnimateFloat('Position.Z', 500, 1);
    FContainer.AnimateFloatDelay('Position.Z', 0, 1, 1);
    FContainer.AnimateFloatWait('RotationAngle.X', 360, 2,
     TAnimationType.inOUT, TInterpolationType.back);
   // FContainer.AnimateFloatWait('RotationAngle.X', 360, 2);

  end;
  SwitchTo2D;
end;

procedure TForm28.UpdateEffect;
begin
if Assigned(FEffect) then
  begin
    FEffect.ValuesAsBitmap['Input'] := FRawBitmap;
    ImageContainer.Bitmap := FEffect.ValuesAsBitmap['Output'];
  end;
end;

end.
