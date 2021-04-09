unit USawonList;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  Fmx.Bind.GenData, Data.Bind.GenData, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, FMX.TabControl,
  System.Actions, FMX.ActnList, FMX.Gestures, Data.Bind.Components, FMX.Edit,
  FMX.StdCtrls, Data.Bind.ObjectScope, FMX.ListView, FMX.Objects, FMX.Layouts,
  FMX.ListBox, FMX.Controls.Presentation, FMX.MultiView,FMX.PhoneDialer,System.Permissions;

type
  TForm1 = class(TForm)
    MultiView1: TMultiView;
    ToolBar1: TToolBar;
    Button1: TButton;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    Layout1: TLayout;
    ToolBar2: TToolBar;
    Button2: TButton;
    Text1: TText;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    ListView1: TListView;
    PrototypeBindSource1: TPrototypeBindSource;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    ImageControl1: TImageControl;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button3: TButton;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    GestureManager1: TGestureManager;
    ActionList1: TActionList;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    procedure ListBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    FPhoneDialerService: IFMXPhoneDialerService;
    FCallPhonePermission: string;
    procedure DisplayRationale(Sender: TObject; const APermissions: TArray<string>; const APostRationaleProc: TProc);
    procedure MakePhoneCallPermissionRequestResult(Sender: TObject; const APermissions: TArray<string>; const AGrantResults: TArray<TPermissionStatus>);

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses
 {$IFDEF ANDROID}
  Androidapi.Helpers,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os,
 {$ENDIF}
  FMX.DialogService, FMX.Platform;
{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
   Multiview1.HideMaster;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  multiview1.ShowMaster;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 if Edit3.text = ''  then exit;

 if TPlatformServices.Current.SupportsPlatformService(IFMXPhoneDialerService,IInterface(FPhoneDialerService)) then
    PermissionsService.RequestPermissions([FCallPhonePermission], MakePhoneCallPermissionRequestResult, DisplayRationale)
 else
    TDialogService.ShowMessage('전화 걸기가 지원이 안됨');
end;

procedure TForm1.DisplayRationale(Sender: TObject;
  const APermissions: TArray<string>; const APostRationaleProc: TProc);
begin
  TDialogService.ShowMessage('The app needs to be able to support your making phone calls',
    procedure(const AResult: TModalResult)
    begin
      APostRationaleProc;
    end)
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
{$IFDEF ANDROID}
  FCallPhonePermission := JStringToString(TJManifest_permission.JavaClass.CALL_PHONE);
{$ENDIF}
  { test whether the PhoneDialer services are supported }
end;

procedure TForm1.ListBox1Change(Sender: TObject);
begin
  case ListBox1.ItemIndex of
    0: begin
        TabControl1.ActiveTab := Tabitem1;
        Text1.text := '사원리스트';
       end;
    1: begin
        TabControl1.ActiveTab := Tabitem2;
        Text1.text := '사원상세정보';
       end;
  end;
  MultiView1.HideMaster;
end;

procedure TForm1.MakePhoneCallPermissionRequestResult(Sender: TObject;
  const APermissions: TArray<string>;
  const AGrantResults: TArray<TPermissionStatus>);
begin
 if (Length(AGrantResults) = 1) and (AGrantResults[0] = TPermissionStatus.Granted) then
    FPhoneDialerService.Call(Edit3.Text)
  else
    TDialogService.ShowMessage('Cannot make a phone call because the required permission has not been granted');
end;

end.
