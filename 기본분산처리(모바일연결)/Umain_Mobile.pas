unit Umain_Mobile;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  Data.DBXDataSnap, Data.DBXCommon, IPPeerClient, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.DB, Data.Bind.DBScope, Datasnap.DBClient,
  Datasnap.DSConnect, Data.SqlExpr, FMX.ListView, FMX.TabControl, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, System.Actions, FMX.ActnList,
  FMX.Gestures;

type
  TForm169 = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    Edit1: TEdit;
    Button1: TButton;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    ListView1: TListView;
    SQLConnection1: TSQLConnection;
    DSProviderConnection1: TDSProviderConnection;
    Dept_cds: TClientDataSet;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    insaquery_cds: TClientDataSet;
    DataSource1: TDataSource;
    ListView2: TListView;
    BindSourceDB2: TBindSourceDB;
    LinkFillControlToField1: TLinkFillControlToField;
    GestureManager1: TGestureManager;
    ActionList1: TActionList;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure SQLConnection1BeforeConnect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form169: TForm169;


implementation

uses Uclientclass;
var
   demo: TServerMethods1Client;
{$R *.fmx}

procedure TForm169.Button1Click(Sender: TObject);
begin
  button1.Text := inttostr(demo.getcount(dept_cds.Fields[0].AsString));
end;

procedure TForm169.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  insaquery_cds.Close;
  insaquery_cds.Params[0].AsString :=
  dept_cds.Fields[0].AsString;
  insaquery_cds.Open;
end;

procedure TForm169.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  demo.Free;
end;

procedure TForm169.FormCreate(Sender: TObject);
begin
  try
    sqlconnection1.open;
    dept_cds.Open;
  except
    on e:exception do
       showmessage(e.message);
  end;
  demo := TServerMethods1Client.Create(sqlconnection1.DBXConnection);
end;

procedure TForm169.SQLConnection1BeforeConnect(Sender: TObject);
begin
{$ifdef ios or ifdef android }
  sqlconnection1.Params.values['host name'] := Edit1.Text;
{$endif}
end;

end.
