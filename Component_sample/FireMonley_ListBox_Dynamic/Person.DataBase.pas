unit Person.DataBase;

interface

Uses
  System.Generics.Collections
, System.Generics.Defaults
, System.RTTI
;

Const
  Vornamen   : Array of String = ['Frank','Peter','Klaus','Olaf','Sabine','Claudia','Helene'];
  Nachnamen  : Array of String = ['Schmitz','Meyer','Schulze','Petersen','Schumacher','Freudenberg'];
  Strassen   : Array of String = ['Bonngasse','Konrad-Adenauer Allee','Friesenplatz','Frauenhofer Str.','Bahnhofstr.','Graf-Galen-Str.'];
  PLZ        : Array of String = ['53881 Euskirchen','53111 Bonn','33181 Bad W?nenberk','37081 G?tingen','48662 Ahaus','38350 Helmsted','13505 Berlin'];
  Telefon    : Array of String = ['0228 / 1239823','0226 / 9482983','0221 / 9929384','030 / 22736726','02255 / 37476276','0173 / 312982937','0172 / 66646762'];


Type
  TAdressen = Record
                public
                  Key          : String;
                  Vorname,
                  Nachname,
                  Strasse,
                  Tel,
                  ZahlungsArt,
                  PLZOrt       : byte;
                  HausNr       : Word;

                  Function SortKey : String;
                private
                  function Getanrede: Integer;
                  function Getfirstname: String;
                  function Getname: String;
                  function GetNumber: String;
                  function Getstreet: String;
                  function GetTeletype: Integer;
                  function GetTown: String;
                  function GetZip: String;
                public
                  Property anrede : Integer read Getanrede;
                  Property firstname : String read Getfirstname;
                  Property name : String read Getname;
                  Property street : String read Getstreet;
                  Property zip : String read GetZip;
                  Property town : String read GetTown;
                  Property Teletype : Integer read GetTeletype;
                  Property Number : String read GetNumber;
              end;

  TPersonDB = Class
    private
      fAdressen : TArray<TAdressen>;
      fDic      : TDictionary<String,Integer>;

      Function NewAdresse : TAdressen;
      Function NewKey: String;
    public
      Constructor Create;
      Destructor  Destroy;override;
      Function Load(ID : Integer) : String;overload;
      Function Load(Key : String) : String;overload;
      Function LoadPerson(ID : Integer) : TAdressen;
      Function GetKeys : TArray<TValue>;
      Function Count : Integer;
  end;

implementation

Uses
  System.SysUtils
;

{ TPersonDB }

function TPersonDB.Count: Integer;
begin
  Result := Length(fAdressen);
end;

constructor TPersonDB.Create;
var
  i : Integer;

begin
  Inherited Create;

  Setlength(fAdressen,20);
  fDic      := TDictionary<String,Integer>.Create;

  Randomize;

  for i:=0 to high(fAdressen) do
    begin
      fAdressen[i] := NewAdresse;
      fDic.Add(fAdressen[i].Key,I);
    end;
end;

destructor TPersonDB.Destroy;
begin
  fDic.Free;

  inherited;
end;

function TPersonDB.GetKeys: TArray<TValue>;
var
  lAllPairs : TArray<TPair<String,String>>;
  I         : Integer;
  lComparer : IComparer<TPair<String,String>>;
begin
  Setlength(lAllPairs,length(fAdressen));

  for i:=0 to high(lAllPairs) do
    begin
      lAllPairs[i].Key   := fAdressen[i].SortKey;
      lAllPairs[i].Value := fAdressen[i].Key;
    end;

  lComparer := TComparer<TPair<String,String>>.Construct(Function (Const L,R : TPair<String,String>) : Integer
                  begin
                    if L.Key > R.Key
                      then Result := 1
                      else if L.Key = R.Key
                             then Result := 0
                             else Result := -1;
                  end);

  TArray.Sort<TPair<String,String>>(lAllPairs,lComparer);

  Setlength(Result,length(lAllPairs));
  for i:=0 to high(lAllPairs) do
    begin
      Result[i] := TValue.From(lAllPairs[i].Value);
    end;
end;

function TPersonDB.Load(Key: String): String;
var
 idx : Integer;
begin
  if not(fDic.TryGetValue(Key,Idx)) then
    exit('');

  Result := Load(idx);
end;

function TPersonDB.LoadPerson(ID: Integer): TAdressen;
begin
  Result := fAdressen[ID];
end;

function TPersonDB.Load(ID: Integer) : String;
var
  lAdresse : TAdressen;
begin
  lAdresse := fAdressen[ID];

  case Vornamen[lAdresse.Vorname][1] of
    'F' : Result := 'Anrede;Herr;';
    'P' : Result := 'Anrede;Herr;';
    'K' : Result := 'Anrede;Herr;';
    'O' : Result := 'Anrede;Herr;';
    'S' : Result := 'Anrede;Frau;';
    'C' : Result := 'Anrede;Frau;';
    'H' : Result := 'Anrede;Frau;';
  end;  // of Case

  case Telefon[lAdresse.Tel][4] of
    '2','3' : Result := Result + 'TelType;1;';
    '5'     : Result := Result + 'TelType;2;';
        else  Result := Result + 'TelType;0;'
  end; // of case

  Result := Result + 'Vorname;'+Vornamen[lAdresse.Vorname] + ';Name;' +Nachnamen[lAdresse.Nachname] + ';Strasse;' + Strassen[lAdresse.Strasse] + ';HausNr;'+lAdresse.HausNr.ToString + ';Ort;' + PLZ[lAdresse.PLZOrt]+';Telefon;'+Telefon[lAdresse.Tel];
end;

function TPersonDB.NewAdresse: TAdressen;
begin
  Result.Vorname  := Random(High(Vornamen));
  Result.Nachname := Random(High(Nachnamen));
  Result.Strasse  := Random(High(Strassen));
  Result.PLZOrt   := Random(High(PLZ));
  Result.Tel      := Random(High(Telefon));
  Result.HausNr   := Random(500);
  Result.Key      := NewKey;
end;

function TPersonDB.NewKey: String;
var
  GUID : TGUID;
begin
  GUID := TGUID.NewGuid;

  SetLength(Result, 36);
  StrLFmt(PChar(Result), 36,'%.8x-%.4x-%.4x-%.2x%.2x-%.2x%.2x%.2x%.2x%.2x%.2x',   // do not localize
    [Guid.D1, Guid.D2, Guid.D3, Guid.D4[0], Guid.D4[1], Guid.D4[2], Guid.D4[3], Guid.D4[4], Guid.D4[5], Guid.D4[6], Guid.D4[7]]);
end;


{ TAdressen }

function TAdressen.Getanrede: Integer;
begin
  Result := -1;

  case Vornamen[Vorname][1] of
    'F',
    'P',
    'K',
    'O'  : Result := 0;
    'S',
    'C',
    'H'  : Result := 1;
  end;  // of Case
end;

function TAdressen.Getfirstname: String;
begin
  Result := Vornamen[Vorname];
end;

function TAdressen.Getname: String;
begin
  Result := Nachnamen[Nachname];
end;

function TAdressen.GetNumber: String;
begin
  Result := Telefon[Tel];
end;

function TAdressen.Getstreet: String;
begin
  Result := Strassen[Strasse] + ' '+ HausNr.ToString
end;

function TAdressen.GetTeletype: Integer;
begin
  case Telefon[Tel][4] of
    '2','3' : Result := 1;
    '5'     : Result := 2
        else  Result := 0;
  end; // of case
end;

function TAdressen.GetTown: String;
begin
  Result := Copy(PLZ[PLZOrt],6,255);
end;

function TAdressen.GetZip: String;
begin
  Result := Copy(PLZ[PLZOrt],1,5);
end;

function TAdressen.SortKey: String;
begin
  Result := Nachnamen[Nachname]+Vornamen[Vorname]+Strassen[Strasse];
end;

end.
