unit UMain_Client;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DBXDataSnap, Data.DBXCommon,
  IPPeerClient, Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Datasnap.DBClient, Datasnap.DSConnect, Data.SqlExpr, Data.FMTBcd,dbxjson,system.json;

type
  TCallBackClient = class(TDBXCallBack)
    function execute(const arg:tjsonvalue):tjsonvalue; override;
  end;

  TForm168 = class(TForm)
    SQLConnection1: TSQLConnection;
    DSProviderConnection1: TDSProviderConnection;
    dept_cds: TClientDataSet;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    insaquery: TClientDataSet;
    DataSource2: TDataSource;
    DBGrid2: TDBGrid;
    SqlServerMethod1: TSqlServerMethod;
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button6Click(Sender: TObject);
    procedure dept_cdsReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form168: TForm168;


implementation

uses Uclientclass, Vcl.RecError;
var
  demo:TServerMethods1Client;
{$R *.dfm}

procedure TForm168.Button1Click(Sender: TObject);
begin
  dept_cds.CancelUpdates;
end;

procedure TForm168.Button2Click(Sender: TObject);
begin
  dept_cds.RevertRecord;
end;

procedure TForm168.Button3Click(Sender: TObject);
begin
   dept_cds.ApplyUpdates(-1);
end;

procedure TForm168.Button4Click(Sender: TObject);
begin
  dept_cds.SaveToFile('sample.xml', dfXML);
end;

procedure TForm168.Button5Click(Sender: TObject);
begin
 dept_cds.LoadFromFile('sample.xml');
end;

procedure TForm168.Button6Click(Sender: TObject);
begin
  button6.caption := inttostr(demo.GetCount(dept_cds.Fields[0].asstring));
end;

procedure TForm168.Button7Click(Sender: TObject);
var
  CallBackID:TCallBackClient;
begin
//  sqlServerMethod1.Close;
//  sqlServerMethod1.Params[0].AsString :=  'hi';
//  sqlServerMethod1.ExecuteMethod;
  CallBackId := TCallBackClient.Create;
  button7.Caption := demo.EchoString('hi',callbackid);
end;

procedure TForm168.DataSource1DataChange(Sender: TObject; Field: TField);
begin
   insaquery.Close;
   insaquery.Params[0].AsString := dept_cds.Fields[0].asstring;
   insaquery.Open;
end;

procedure TForm168.dept_cdsReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  action := HandleReconcileError(dataset,updatekind,e);
end;

procedure TForm168.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  demo.Free;
end;

procedure TForm168.FormCreate(Sender: TObject);
begin
  demo := TServerMethods1Client.Create(sqlconnection1.DBXConnection);
end;

{ TCallBackClient }

function TCallBackClient.execute(const arg: tjsonvalue): tjsonvalue;
var
  Data:TJSONValue;
begin
  Data := TJSONValue(arg.Clone);
  showMessage('콜백함수:' + TJSONObject(data).Get(0).jsonvalue.value);
  result :=data;
end;

end.
