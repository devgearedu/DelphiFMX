unit uMainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Edit, FMX.StdCtrls,
  FMX.Objects, FMX.Platform.iOS, FMX.Layouts, FMX.Memo, FMX.ListBox,
  libzbar;

type
  TMainForm = class(TForm)
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    Switch1: TSwitch;
    Clear_Button: TButton;
    Label1: TLabel;
    Edit_Result: TEdit;
    Copy_Button: TButton;
    Memo1: TMemo;
    HistoryList: TListBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Switch1Switch(Sender: TObject);
    procedure Clear_ButtonClick(Sender: TObject);
    procedure Copy_ButtonClick(Sender: TObject);
  private
    { Private declarations }
    ZBarCode: TZBarCode;
    procedure OnFindBarCode(Sender: TObject; BarCode: String);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses iOSapi.CoreGraphics;

procedure TMainForm.Clear_ButtonClick(Sender: TObject);
begin
  Edit_Result.Text := '';
  HistoryList.Items.Clear;
end;

procedure TMainForm.Copy_ButtonClick(Sender: TObject);
begin
  edit_Result.SelectAll;
  edit_Result.CopyToClipboard;
end;

procedure TMainForm.OnFindBarCode(Sender: TObject; BarCode: String);
begin
  edit_Result.Text := BarCode;
  HistoryList.Items.Add(FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + ' - ' + BarCode);
end;

procedure TMainForm.Switch1Switch(Sender: TObject);
begin
  if not Assigned(ZBarCode) then
  begin
    ZBarCode := TZBarCode.Create;
    ZBarCode.OnBarCode := OnFindBarCode;
    ZBarCode.setFrame(WindowHandleToPlatform(Self.Handle).View,
      CGRectMake(memo1.Position.X, memo1.Position.Y, memo1.Width,
      memo1.Height));
  end;

  ZBarCode.Active := switch1.IsChecked;
end;

end.
