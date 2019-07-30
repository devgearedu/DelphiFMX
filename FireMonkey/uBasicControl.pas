unit uBasicControl;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.Layouts, FMX.TabControl, FMX.Colors, FMX.ComboEdit, FMX.DateTimeCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Fmx.Bind.GenData, Data.Bind.GenData, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, FMX.Grid.Style, Fmx.Bind.Grid,
  FMX.Filter.Effects, FMX.Effects, FMX.Objects, FMX.StdCtrls, Data.Bind.Grid,
  FMX.Grid, FMX.ScrollBox, Data.Bind.Components, Data.Bind.ObjectScope,
  Data.Bind.DBScope, Data.DB, Datasnap.DBClient, FMX.ListView, FMX.Ani,
  FMX.Gestures, System.Actions, FMX.ActnList,FMX.Viewport3D,FMX.Layers3D,
  SYSTEM.Uiconsts,FMX.Types3D;

type
  TForm219 = class(TForm)
    Layout1: TLayout;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBox2: TListBox;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    Edit1: TEdit;
    DateEdit1: TDateEdit;
    ComboEdit1: TComboEdit;
    ColorComboBox1: TColorComboBox;
    ComboBox1: TComboBox;
    ListView1: TListView;
    ClientDataSet1: TClientDataSet;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    PrototypeBindSource1: TPrototypeBindSource;
    LinkListControlToField1: TLinkListControlToField;
    Grid1: TGrid;
    Grid2: TStringGrid;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    LinkGridToDataSourceBindSourceDB12: TLinkGridToDataSource;
    ImageControl1: TImageControl;
    Image1: TImage;
    ImageControl2: TImageControl;
    ImageControl4: TImageControl;
    TabItem5: TTabItem;
    TabItem6: TTabItem;
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
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    ShadowEffect1: TShadowEffect;
    BlurEffect1: TBlurEffect;
    ReflectionEffect1: TReflectionEffect;
    SwirlEffect1: TSwirlEffect;
    EmbossEffect1: TEmbossEffect;
    Rectangle1: TRectangle;
    ColorAnimation1: TColorAnimation;
    ImageControl3: TImageControl;
    BitmapAnimation1: TBitmapAnimation;
    FloatAnimation1: TFloatAnimation;
    Rectangle2: TRectangle;
    Button1: TButton;
    Rectangle3: TRectangle;
    Button2: TButton;
    Button3: TButton;
    StyleBook1: TStyleBook;
    ActionList1: TActionList;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    GestureManager1: TGestureManager;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ColorComboBox1Change(Sender: TObject);
    procedure DateEdit1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    viewPort3D:TViewPort3D;
    Layer3D:TLayer3D;
    procedure SwitchTo3D;
    procedure SwitchTo2D;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form219: TForm219;

implementation
var
 ListBoxItem: TListBoxItem;
 ani:TFloatAnimation;
{$R *.fmx}

procedure TForm219.Button1Click(Sender: TObject);
begin
   rectangle2.AnimateFloat('RotationAngle',360,3);
end;

procedure TForm219.Button2Click(Sender: TObject);
begin
   ani := TFloatAnimation.create(rectangle3);
   ani.Parent := rectangle3;
   ani.PropertyName := 'RotationAngle';
   ani.StopValue := 360;
   ani.Loop := true;
   ani.Duration := 3;
   ani.start;     //stop;
end;

procedure TForm219.Button3Click(Sender: TObject);
begin
   Grid1.AnimateFloat('height',20,1);
   grid2.AnimateFloat('height',20,1);

   grid1.AnimateFloatDelay('position.y', grid2.Position.Y,1,1);
   grid2.AnimateFloatDelay('position.y', grid1.Position.Y,1,1);

   grid1.AnimateFloatDelay('height',200,1,2);
   grid2.AnimateFloatDelay('height',200,1,2);

end;

procedure TForm219.Button4Click(Sender: TObject);
begin
     SwitchTo3d;
  if Assigned(Layer3d)then
  begin
    Layer3d.AnimateFloat('Position.Z', 500, 1);
    Layer3d.AnimateFloatDelay('Position.Z', 0, 1, 1);
    Layer3d.AnimateFloatWait('RotationAngle.X', 360, 2,
    TAnimationType.inOUT, TInterpolationType.back);
  //  TAnimationType.inout, TInterpolationType.Linear);
   // Layer3d.AnimateFloatWait('RotationAngle.X', 360, 2);
    end;
   SwitchTo2d;
end;

procedure TForm219.ColorComboBox1Change(Sender: TObject);
begin
   ListBoxItem5.TextSettings.Fontcolor :=
   ColorComboBox1.Color;
end;

procedure TForm219.DateEdit1Change(Sender: TObject);
begin
  ListBoxItem3.ItemData.Text :=
  FormatDateTime('yyyy-mmmm-dd', dateEdit1.Date);
end;

procedure TForm219.FormCreate(Sender: TObject);
begin
  ListBoxItem := TListBoxItem.create(ListBox1);
  ListBoxitem.Height := 40;
  ListBoxitem.ItemData.Text := '윈도우프로그래밍';
  ListBoxItem.ItemData.Accessory := TListBoxItemData.TAccessory.aMore;
  ListBoxItem.ItemData.Detail := '4일';
  ListBoxItem.Parent  := Listbox1;
  ListBoxitem.StyleLookup := 'listboxitembottomdetail';
end;

procedure TForm219.SwitchTo2D;
begin
   Layout1.Parent := self;
   FreeAndNil(ViewPort3d);
end;

procedure TForm219.SwitchTo3D;
begin
  ViewPort3D := TViewPort3D.Create(self);
  viewPort3D.Parent := Self;
  viewPort3D.Align := TAlignLayout.Client;
  viewPort3D.Color := claNull;
  Layer3D := TLayer3d.Create(ViewPort3d);
  Layer3D.Parent := viewPort3d;
  Layer3D.Projection := TProjection.pjScreen;
    Layer3D.Align := TAlignLayout.alClient;
  { Move object to 3D scene}
  Layout1.Parent := Layer3d;
end;

end.
