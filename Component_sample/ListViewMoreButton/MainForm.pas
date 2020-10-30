unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView, FMX.Layouts, FMX.Edit;

type
  TForm2 = class(TForm)
    ListView1: TListView;
    btnListViewMore: TButton;
    ToolBar1: TToolBar;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ListView1ScrollViewChange(Sender: TObject);
    procedure btnListViewMoreClick(Sender: TObject);
    procedure ListView1Resized(Sender: TObject);
  private
    { Private declarations }
    procedure AddItem(ACount: Integer);
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

{ TForm2 }

procedure TForm2.AddItem(ACount: Integer);
var
  I: Integer;
  Item: TListViewItem;
begin
  for I := 0 to ACOunt - 1 do
  begin
    Item := ListView1.Items.Add;
    Item.Text := 'Item ' + ListView1.Items.Count.ToString;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  AddItem(24);
  btnListViewMore.Visible := False;
end;

procedure TForm2.btnListViewMoreClick(Sender: TObject);
begin
  AddItem(6);
  btnListViewMore.Visible := False;
end;

procedure TForm2.ListView1Resized(Sender: TObject);
begin
  ListView1ScrollViewChange(Sender);
end;

procedure TForm2.ListView1ScrollViewChange(Sender: TObject);
var
  LastItemBottom, ListViewBottom: Single;
begin
  LastItemBottom := ListView1.GetItemRect(ListView1.ItemCount - 1).Bottom;
  ListViewBottom := ListView1.LocalRect.Bottom;

  btnListViewMore.Visible := ((LastItemBottom - ListViewBottom) < 30);
end;

end.
