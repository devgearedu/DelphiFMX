unit ListBoxStyle;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts, FMX.ListBox, FMX.TabControl, FMX.Controls.Presentation, FMX.Edit
, Person.DataBase, FMX.StdCtrls, FMX.Objects,System.Rtti;


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
        LBI.StyleLookup             := 'MyListItemStyle';
        LBI.Height                  := 110;
        LBI.OnClick                 := OnItemClick;
        LBI.Tag                     := i;
        LBI.ItemData.Accessory      := TListBoxItemData.TAccessory.aMore;
        if i mod 2 = 0 then
           LBI.StylesData['RectangleStyle.Fill.color']  := TAlphacolorRec.Cyan
        else
           LBI.StylesData['RectangleStyle.Fill.color']  := TAlphacolorRec.Pink;

        LBI.StylesData['Rectanglestyle.fill.Kind']      := TValue.From<TBrushKind>(TBrushKind.Solid);

        LBI.StylesData['RectagleStyle.width']          := 12;
        LBI.StylesData['Label1item'] := '이름' + inttostr(i+1);
        LBI.StylesData['Label2item'] := '직업군 ' + inttostr(i+1);;
        LBI.StylesData['Label3item'] := '서울시 강남구 반포동 사평대로' + inttostr(i+i);
        LBI.StylesData['Label4item'] := '메일 주소' + inttostr(i+i) + '@naver.com';
        LBI.StylesData['Label5item'] := '전화번호 010-' + inttostr(i+1);

        persons[i].Name              :=  LBI.StylesData['Label1item'].asstring;
        persons[i].Title             :=  LBI.StylesData['Label2item'].AsString;
        persons[i].Address           :=  LBI.StylesData['Label3item'].AsString;
        persons[i].mail              :=  LBI.StylesData['Label4item'].AsString;
        persons[i].Tel               :=  LBI.StylesData['Label5item'].AsString;
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
