unit UsawonList;

interface

uses
  FMX.platform, fmx.phoneDialer,System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  Fmx.Bind.GenData, Data.Bind.GenData, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, FMX.Gestures,
  FMX.TabControl, System.Actions, FMX.ActnList, Data.Bind.Components, FMX.Edit,
  FMX.StdCtrls, Data.Bind.ObjectScope, FMX.ListView, FMX.Objects, FMX.Layouts,
  FMX.ListBox, FMX.Controls.Presentation, FMX.MultiView;

type
  TForm129 = class(TForm)
    MultiView1: TMultiView;
    ToolBar1: TToolBar;
    ListBox1: TListBox;
    Masterbutton: TButton;
    Layout1: TLayout;
    ToolBar2: TToolBar;
    mzsterbutton2: TButton;
    Text1: TText;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    ListView1: TListView;
    PrototypeBindSource1: TPrototypeBindSource;
    BindingsList1: TBindingsList;
    ImageControl1: TImageControl;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    ActionList1: TActionList;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    GestureManager1: TGestureManager;
    LinkListControlToField1: TLinkListControlToField;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    StyleBook1: TStyleBook;
    procedure mzsterbutton2Click(Sender: TObject);
    procedure MasterbuttonClick(Sender: TObject);
    procedure ListBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form129: TForm129;

implementation

{$R *.fmx}

procedure TForm129.Button1Click(Sender: TObject);
var
   PhoneDialerService:TPhoneDialerService;
begin
   if Edit3.Text = '' then exit;

 //  if TPlatformServices.Current.SupportsPlatformService(TPhoneDialerService,
 //     IInterface(PhoneDialerService))then
 //     PhoneDialerService.Call(edit3.Text);
end;

procedure TForm129.ListBox1Change(Sender: TObject);
begin
case listBOX1.ItemIndex of
    0:  begin
          TabControl1.ActiveTab := tABITEM1;
          Text1.text:= '사원리스트';
          multiview1.HideMaster;
        end;
    1:  begin
          TabControl1.ActiveTab := tABiTEM2;
          Text1.text:= '사원목록';
          multiview1.HideMaster;
        end;
  end;
end;

procedure TForm129.MasterbuttonClick(Sender: TObject);
begin
   Multiview1.HideMaster;
end;

procedure TForm129.mzsterbutton2Click(Sender: TObject);
begin
  Multiview1.ShowMaster;
end;

end.
