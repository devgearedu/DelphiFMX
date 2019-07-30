unit USawon_List;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.ListBox, FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.MultiView, Fmx.Bind.GenData, Data.Bind.GenData, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Gestures, System.Actions, FMX.ActnList, Data.Bind.Components, FMX.Edit,
  FMX.ListView, Data.Bind.ObjectScope, FMX.Objects,FMX.PhoneDialer,FMX.Platform,System.Permissions,
  FMX.Viewport3D,FMX.Layers3D,SYSTEM.Uiconsts,FMX.Types3D;

type
  TForm219 = class(TForm)
    MultiView1: TMultiView;
    ToolBar1: TToolBar;
    masterButton: TButton;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    Layout1: TLayout;
    ToolBar2: TToolBar;
    MasterButton2: TButton;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    Text1: TText;
    PrototypeBindSource1: TPrototypeBindSource;
    BindingsList1: TBindingsList;
    ListView1: TListView;
    LinkListControlToField2: TLinkListControlToField;
    ImageControl1: TImageControl;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    Button3: TButton;
    ActionList1: TActionList;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    GestureManager1: TGestureManager;
    Button1: TButton;
    Action_3d: TAction;
    procedure ListBox1Change(Sender: TObject);
    procedure masterButtonClick(Sender: TObject);
    procedure MasterButton2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Action_3dExecute(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    viewPort3D:TViewPort3D;
    Layer3D:TLayer3D;
    FPhoneDialerService: IFMXPhoneDialerService;
    FCallPhonePermission: string;

    procedure DisplayRationale(Sender: TObject; const APermissions: TArray<string>; const APostRationaleProc: TProc);
    procedure MakePhoneCallPermissionRequestResult(Sender: TObject; const APermissions: TArray<string>; const AGrantResults: TArray<TPermissionStatus>);
    procedure SwitchTo3D;
    procedure SwitchTo2D;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form219: TForm219;

implementation
uses
{$IFDEF ANDROID}
  Androidapi.Helpers,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os,
{$ENDIF}
  FMX.DialogService;

{$R *.fmx}

procedure TForm219.Action_3dExecute(Sender: TObject);
begin
  SwitchTo3d;
  if Assigned(Layer3d)then
  begin
    Layer3d.AnimateFloat('Position.Z', 500, 1);
    Layer3d.AnimateFloatDelay('Position.Z', 0, 1, 1);
    Layer3d.AnimateFloatWait('RotationAngle.y', 360, 2,
    TAnimationType.inOUT, TInterpolationType.back);
   // TAnimationType.inout, TInterpolationType.Linear);
   // Layer3d.AnimateFloatWait('RotationAngle.X', 360, 2);
    end;
   SwitchTo2d;
end;

procedure TForm219.Button1Click(Sender: TObject);
begin
  Multiview1.Mode := TMultiviewMode.Popover;
  Multiview1.ShowMaster;
  masterbutton2.enabled := false;
end;

procedure TForm219.Button3Click(Sender: TObject);
begin
   if edit3.Text = '' then exit;

      { test whether the PhoneDialer services are supported }
    if FPhoneDialerService <> nil then
      { if the Telephone Number is entered in the edit box then make the call, else
        display an error message }
      PermissionsService.RequestPermissions([FCallPhonePermission],
       MakePhoneCallPermissionRequestResult, DisplayRationale)
    else
      TDialogService.ShowMessage('PhoneDialer service not supported');

end;

procedure TForm219.MakePhoneCallPermissionRequestResult(Sender: TObject;
  const APermissions: TArray<string>;
  const AGrantResults: TArray<TPermissionStatus>);
begin
    // 1 permission involved: CALL_PHONE
  if (Length(AGrantResults) = 1) and (AGrantResults[0] = TPermissionStatus.Granted) then
    FPhoneDialerService.Call(edit3.Text)
  else
    TDialogService.ShowMessage('Cannot make a phone call because the required permission has not been granted');
end;

procedure TForm219.MasterButton2Click(Sender: TObject);
begin
  Multiview1.Mode := TMultiviewMode.Drawer;
  multiView1.ShowMaster;
end;

procedure TForm219.DisplayRationale(Sender: TObject;
  const APermissions: TArray<string>; const APostRationaleProc: TProc);
begin
  // Show an explanation to the user *asynchronously* - don't block this thread waiting for the user's response!
  // After the user sees the explanation, invoke the post-rationale routine to request the permissions
  TDialogService.ShowMessage('The app needs to be able to support your making phone calls',
    procedure(const AResult: TModalResult)
    begin
      APostRationaleProc;
    end)
end;

procedure TForm219.FormCreate(Sender: TObject);
begin

{$IFDEF ANDROID}
  FCallPhonePermission := JStringToString(TJManifest_permission.JavaClass.CALL_PHONE);
{$ENDIF}
  { test whether the PhoneDialer services are supported }
  TPlatformServices.Current.SupportsPlatformService(IFMXPhoneDialerService, FPhoneDialerService);
end;

procedure TForm219.ListBox1Change(Sender: TObject);
begin
  case ListBox1.ItemIndex of
   0: begin
       Text1.Text := '사원목록';
       TabControl1.ActiveTab := Tabitem1;
      end;
   1: begin
       Text1.Text := '사원정보';
       TabControl1.ActiveTab := TabItem2;
      end;
  end;
  MultiView1.HideMaster;
  masterbutton2.Enabled := true;
end;

procedure TForm219.masterButtonClick(Sender: TObject);
begin
  multiview1.hidemaster;
  masterbutton2.Enabled := true;
end;

procedure TForm219.SwitchTo2D;
begin
  Layout1.Parent := Self;
  { Free 3D }
  FreeAndNil(Viewport3d);
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
