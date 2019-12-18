unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client, Datasnap.Provider,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.UI, FireDAC.Phys.IBBase,dbxjson;

type
  TServerMethods1 = class(TDSServerModule)
    FDConnection1: TFDConnection;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    dept: TFDTable;
    deptProvider: TDataSetProvider;
    InsaQuery: TFDQuery;
    InsaQuertyProvider: TDataSetProvider;
    totQuery: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string; Callback:TDBXCallback): string;
    function ReverseString(Value: string): string;
    function GetCount(value:string):integer;
  end;

implementation


{$R *.dfm}


uses System.StrUtils;

function TServerMethods1.EchoString(Value: string; Callback:TDBXCallback):  string;
var
  Msg:TJSONObject;
  Pair:TJSONPair;
begin
  Msg := TJSONObject.Create;
  Pair := TJSONPair.Create('Echo', value);
  Pair.Owned := true;
  Msg.AddPair(Pair);
  callback.Execute(Msg);
  Result := Value;
end;

function TServerMethods1.GetCount(value: string): integer;
begin
  totQuery.close;
  totQuery.Params[0].asstring := value;
  totQuery.open;
  result := totQuery.FieldByName('total').AsInteger;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

