unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  Data.Bind.GenData, Fmx.Bind.GenData, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.ObjectScope, FMX.ListView, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.ScrollBox, FMX.Memo, FMX.Layouts;

type
  TForm2 = class(TForm)
    ListView1: TListView;
    PrototypeBindSource1: TPrototypeBindSource;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    Layout1: TLayout;
    ToolBar1: TToolBar;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure ListView1Resize(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    procedure Log(Value: string);
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.Button1Click(Sender: TObject);
var
  I: Integer;
  W, POX, Ratio: Single;
  Obj: TCommonObjectAppearance;
begin
  Memo1.Lines.Clear;

  // ListView Item area width
  W := ListView1.Width - ListView1.ItemSpaces.Left - ListView1.ItemSpaces.Right;
  Log('ListView Item area width');
  Log(W.ToString);

  Log('');
  // Appearance Object list
  for Obj in ListView1.ItemAppearanceObjects.ItemObjects.Objects do
  begin
    Log(Obj.Name);
    Log(' - W: ' + Obj.Width.ToString);
    Log(' - PO.X: ' + Obj.PlaceOffset.X.ToString);
  end;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  Layout1.Visible := not Layout1.Visible;
end;

procedure TForm2.Button3Click(Sender: TObject);
  function GetTextItem2: TCustomTextObjectAppearance;
  var
    Obj: TCommonObjectAppearance;
  begin
    Result := nil;
    for Obj in ListView1.ItemAppearanceObjects.ItemObjects.Objects do
    begin
      if not (Obj is TCustomTextObjectAppearance) then
        Continue;

      if Obj.Name = 'Text2' then
      begin
        Result := Obj as TCustomTextObjectAppearance;
        Break;
      end;
    end;
  end;
var
  Text2: TCustomTextObjectAppearance;
begin
  // Text2 항목 찾기
  Text2 := GetTextItem2;

  if not Assigned(Text2) then
    Exit;

  Text2.TextColor := TAlphaColorRec.Green;
  Text2.Font.Style := [TFontStyle.fsBold, TFontStyle.fsItalic];
//  Text2.re
end;

// 리스트뷰 크기 변경 시 컨트롤 위치/크기 너비에 맞춰 변경
procedure TForm2.ListView1Resize(Sender: TObject);
var
  L, R, W, Ratio: Single;
  Obj: TCommonObjectAppearance;
begin
  W := ListView1.Width - ListView1.ItemSpaces.Left - ListView1.ItemSpaces.Right;
  L := W;
  R := 0;

  for Obj in ListView1.ItemAppearanceObjects.ItemObjects.Objects do
  begin
    // 가장 왼쪽의 이미지 제외
    if Obj is TCustomImageObjectAppearance then
      Continue;

    // 가장 왼쪽 위치
    if Obj.PlaceOffset.X < L then
      L := Obj.PlaceOffset.X;
    // 가장 오른쪽 위치
    if (Obj.PlaceOffset.X + Obj.Width) > R then
      R := Obj.PlaceOffset.X + Obj.Width;
  end;

  Ratio := (W-L) / (R-L); // (변경된 너비 / 원래너비)
  for Obj in ListView1.ItemAppearanceObjects.ItemObjects.Objects do
  begin
//    if Obj.PlaceOffset.X < L then
    if Obj is TCustomImageObjectAppearance then
      Continue;

    Obj.PlaceOffset.X := ((Obj.PlaceOffset.X - L)  * Ratio) + L;
    Obj.Width := Obj.Width * Ratio;
  end;
end;

procedure TForm2.Log(Value: string);
begin
  Memo1.Lines.Add(Value)
end;

end.
