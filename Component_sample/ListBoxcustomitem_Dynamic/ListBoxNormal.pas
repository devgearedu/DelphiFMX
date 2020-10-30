unit ListBoxNormal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts, FMX.ListBox, FMX.TabControl, FMX.Controls.Presentation, FMX.Edit
, FMX.StdCtrls, FMX.Objects
;

type

  TPerson = record
    Name:string;
    Title:string;
    Address:string;
    mail:string;
    Tel:string;
  end;

  TForm1 = class(TForm)
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    Name: TEdit;
    Layout1: TLayout;
    Mail: TEdit;
    Tel: TEdit;
    Layout2: TLayout;
    Address: TEdit;
    Title: TEdit;
    ToolBar1: TToolBar;
    Label1: TLabel;
    Back: TButton;
    StyleBook1: TStyleBook;
    procedure FormCreate(Sender: TObject);
    procedure BackClick(Sender: TObject);
  private
    { Private-Deklarationen }
    Procedure OnItemClick(Sender : TObject);
    Procedure InitListBox;
  public
    { Public-Deklarationen }
  end;
const
  persons_Num = 10;

var
  Form1: TForm1;
  persons:array [0..persons_num-1] of Tperson;

implementation

{$R *.fmx}

procedure TForm1.BackClick(Sender: TObject);
begin
  Back.Visible       := false;
  TabControl1.SetActiveTabWithTransitionAsync(TabItem1,TTabTransition.Slide,TTabTransitionDirection.Reversed,Procedure
   begin
   end);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i         : Integer;
  LBI       : TListBoxItem;
begin
  TabControl1.ActiveTab   := TabItem1;
  TabControl1.TabPosition := TTabPosition.None;
  Back.Visible            := false;

  InitListBox;
end;

procedure TForm1.InitListBox;
var
  i         : Integer;
  LBI       : TListBoxItem;
  LBL       : TLabel;
  R         : TRectangle;
  Lay       : TLayout;
begin
  ListBox1.BeginUpdate;
  try
    ListBox1.Clear;

    for i:=0 to persons_num - 1 do
      begin

        LBI := TListBoxItem.Create(ListBox1);

        LBI.Parent                  := ListBox1;
        LBI.StyleLookup             := 'listboxitembottomdetail';
        LBI.Height                  := 110;
        LBI.OnClick                 := OnItemClick;
        LBI.Tag                     := i;
        LBI.ItemData.Accessory      := TListBoxItemData.TAccessory.aMore;

        R                           := TRectangle.Create(LBI);
        R.Parent                    := LBI;
        R.Align                     := TAlignLayout.Left;
        R.Margins.Top               := 4;
        R.Margins.Right             := 6;
        R.Margins.Bottom            := 4;
        R.Margins.Left              := 2;
        R.Stroke.Kind               := TBrushKind.None;

        if i mod 2 = 0
          then R.Fill.Color         := TAlphacolorRec.Cyan
          else R.Fill.Color         := TAlphacolorRec.Pink;

        R.Fill.Kind                 := TBrushKind.Solid;
        R.Width                     := 12;

        Lay                         := TLayout.Create(LBI);
        Lay.Parent                  := LBI;
        Lay.Align                   := TAlignLayout.Client;

        // Type
        LBL                         := TLabel.Create(Lay);
        LBL.Parent                  := Lay;
        LBL.AutoSize                := true;
        LBL.WordWrap                := false;
        LBL.Align                   := TAlignLayout.MostTop;
        LBL.TextSettings.HorzAlign  := TTextAlign.Leading;
        LBL.Margins.Top             := 3;
        LBL.Margins.Right           := 6;
        LBL.Margins.Bottom          := 0;
        LBL.Margins.Left            := 12;
        LBL.TextSettings.Font.Size  := 14;
        LBL.TextSettings.Font.Style := LBL.TextSettings.Font.Style + [TFontStyle.fsBold];
        LBL.TextSettings.FontColor  := TAlphaColorRec.Crimson;
        LBL.Text                    := '이름' + inttostr(i+1);
        persons[i].Name             := LBL.Text;

        LBL.StyledSettings          := LBL.StyledSettings - [TStyledSetting.Size];
        LBL.StyledSettings          := LBL.StyledSettings - [TStyledSetting.Style];
        LBL.StyledSettings          := LBL.StyledSettings - [TStyledSetting.FontColor];

        // TOP
        LBL                         := TLabel.Create(Lay);
        LBL.Parent                  := Lay;
        LBL.AutoSize                := true;
        LBL.WordWrap                := false;
        LBL.Align                   := TAlignLayout.Top;
        LBL.TextSettings.HorzAlign  := TTextAlign.Leading;
        LBL.Margins.Top             := 3;
        LBL.Margins.Right           := 6;
        LBL.Margins.Bottom          := 0;
        LBL.Margins.Left            := 12;
        LBL.TextSettings.Font.Size  := 14;
        LBL.TextSettings.Font.Style := LBL.TextSettings.Font.Style + [TFontStyle.fsBold];
        LBL.TextSettings.FontColor  := TAlphaColorRec.Black;
        LBL.Text                    := '직업군 ' + inttostr(i+1);
        persons[i].Title            := LBL.Text;

        LBL.StyledSettings          := LBL.StyledSettings - [TStyledSetting.Size];
        LBL.StyledSettings          := LBL.StyledSettings - [TStyledSetting.Style];
        LBL.StyledSettings          := LBL.StyledSettings - [TStyledSetting.FontColor];

        // MID
        LBL                         := TLabel.Create(Lay);
        LBL.Parent                  := Lay;
        LBL.AutoSize                := true;
        LBL.WordWrap                := false;
        LBL.Align                   := TAlignLayout.Client;
        LBL.TextSettings.HorzAlign  := TTextAlign.Leading;
        LBL.Margins.Top             := 0;
        LBL.Margins.Right           := 6;
        LBL.Margins.Bottom          := 0;
        LBL.Margins.Left            := 12;
        LBL.TextSettings.Font.Size  := 14;
        LBL.TextSettings.FontColor  := TAlphaColorRec.Darkgreen;
        LBL.Text                    := '서울시 강남구 반포동 사평대로' + inttostr(i+i);
        persons[i].Address          := LBL.Text;

        LBL.StyledSettings          := LBL.StyledSettings - [TStyledSetting.Size];
        LBL.StyledSettings          := LBL.StyledSettings - [TStyledSetting.Style];
        LBL.StyledSettings          := LBL.StyledSettings - [TStyledSetting.FontColor];

        // Bottom
        LBL                         := TLabel.Create(Lay);
        LBL.Parent                  := Lay;
        LBL.AutoSize                := true;
        LBL.WordWrap                := false;
        LBL.Align                   := TAlignLayout.Bottom;
        LBL.TextSettings.HorzAlign  := TTextAlign.Leading;
        LBL.Margins.Top             := 0;
        LBL.Margins.Right           := 6;
        LBL.Margins.Bottom          := 6;
        LBL.Margins.Left            := 12;
        LBL.TextSettings.Font.Size  := 14;
        LBL.TextSettings.FontColor  := TAlphaColorRec.Black;
        LBL.Text                    := '메일 주소' + inttostr(i+i) + '@naver.com';
        persons[i].mail             := LBL.Text;

        LBL.StyledSettings          := LBL.StyledSettings - [TStyledSetting.Size];
        LBL.StyledSettings          := LBL.StyledSettings - [TStyledSetting.Style];
        LBL.StyledSettings          := LBL.StyledSettings - [TStyledSetting.FontColor];

        // MostBottom
        LBL                         := TLabel.Create(Lay);
        LBL.Parent                  := Lay;
        LBL.AutoSize                := true;
        LBL.WordWrap                := false;
        LBL.Align                   := TAlignLayout.MostBottom;
        LBL.TextSettings.HorzAlign  := TTextAlign.Trailing;
        LBL.Margins.Top             := 0;
        LBL.Margins.Right           := 40;
        LBL.Margins.Bottom          := 6;
        LBL.Margins.Left            := 0;
        LBL.TextSettings.Font.Size  := 12;
        LBL.TextSettings.FontColor  := TAlphaColorRec.Navy;
        LBL.Text                    := '전화번호 010-' + inttostr(i+1);
        persons[i].Tel              := LBL.Text;

        LBL.StyledSettings          := LBL.StyledSettings - [TStyledSetting.Size];
        LBL.StyledSettings          := LBL.StyledSettings - [TStyledSetting.Style];
        LBL.StyledSettings          := LBL.StyledSettings - [TStyledSetting.FontColor];
      end;

  finally
    ListBox1.EndUpdate;
  end;
end;

procedure TForm1.OnItemClick(Sender: TObject);
begin
  TabControl1.SetActiveTabWithTransitionAsync(TabItem2,TTabTransition.Slide,TTabTransitionDirection.Normal,Procedure
   begin
       Name.Text     := Persons[Listbox1.ItemIndex].name;
       Title.Text          := Persons[Listbox1.ItemIndex].Title;
       Address.Text        := Persons[Listbox1.ItemIndex].Address;
       Mail.Text           := Persons[Listbox1.ItemIndex].mail;
       Tel.Text            := Persons[Listbox1.ItemIndex].tel;

       Back.Visible       := true;
   end);
end;

end.
