unit Unit_MultiLayout_likeTab;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, Fmx.Bind.GenData,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Fmx.Bind.Navigator,
  Data.Bind.ObjectScope, FMX.StdCtrls, FMX.Layouts, FMX.ListBox, FMX.Objects,System.Generics.Collections,
  Data.Bind.GenData, System.Actions, FMX.ActnList, FMX.Memo, FMX.ScrollBox,
  FMX.Controls.Presentation;

type
  TForm2 = class(TForm)
    Left_Layout: TLayout;
    Panel1: TPanel;
    ListBox1: TListBox;
    Right_Layout: TLayout;
    ToolBar1: TToolBar;
    Button1: TButton;
    Layout2: TLayout;
    Button2: TButton;
    Label1: TLabel;
    PrototypeBindSource1: TPrototypeBindSource;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    ActionList1: TActionList;
    Action1: TAction;
    Action2: TAction;
    Memo1: TMemo;
    procedure ListBox1Click(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Action1Update(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    FDrawVisible: boolean;
    function IsPad : boolean;
    function IsLandscape : boolean;
    procedure LayoutForm;
    procedure SetDrawVisible(const Value: boolean);
    { Private declarations }
  public
    property DrawVisible:boolean read FDrawVisible write SetDrawVisible;
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
uses
{$IFDEF IOS}
  iOSapi.UIKit,
{$ENDIF}
  FMX.Platform, System.Inifiles;

{$R *.fmx}

{ TForm2 }

procedure TForm2.Action1Execute(Sender: TObject);
begin
   DrawVisible := not Drawvisible;
end;

procedure TForm2.Action1Update(Sender: TObject);
begin
  Action1.Visible := not (IsPad and IsLandscape);

end;

procedure TForm2.Action2Execute(Sender: TObject);
begin
//  if CurrentPageMenuItem <> nil then
//    (CurrentPageMenuItem.Page as IPage).Refresh;

end;

procedure TForm2.FormResize(Sender: TObject);
begin
  LayoutForm;
end;

function TForm2.IsLandscape: boolean;
begin
   Result := self.Width > self.Height;

end;

function TForm2.IsPad: boolean;
begin
 {$IFDEF IOS}
   Result := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice).userInterfaceIdiom = UIUserInterfaceIdiomPad;
 {$ENDIF}
end;

procedure TForm2.LayoutForm;
begin
  Left_Layout.Height := self.Height;
  Right_Layout.Height := self.Height;

  if IsPad and IsLandscape then
  begin
    Left_Layout.Align := TAlignLayout.alLeft;
    Right_Layout.Align := TAlignLayout.alClient;
  end
  else
  begin
    Left_Layout.Align := TAlignLayout.alNone;
    Right_Layout.Align := TAlignLayout.alNone;
    Right_Layout.Width := self.Width;

    if DrawVisible then
      Right_Layout.Position.X := Left_Layout.Position.X + Left_Layout.Width
    else
      Right_Layout.Position.X := 0;
  end;
end;


procedure TForm2.ListBox1Click(Sender: TObject);
begin
 DrawVisible := False;
end;

procedure TForm2.SetDrawVisible(const Value: boolean);
begin
 if FDrawVisible <> Value then
  begin
    FDrawVisible := Value;
    if DrawVisible then
      Right_Layout.AnimateFloat('Position.X', Left_Layout.Position.X + Left_Layout.Width)
    else
      Right_Layout.AnimateFloat('Position.X', 0);
  end;
  FDrawVisible := Value;
end;

end.
