unit Loads;

interface

uses System.Classes, Math, Generics.Collections, Generics.Defaults;

const
  EPSILON = 1e-12;  // wartość wykorzystywana do obliczeń obciążeń
  PRECISION = -6;   // wyniki zaokrąglam do 6 miejsca po przecinku

type
  TAoD = TArray<Double>;

  TP3D = record X, Y, Z: Double; end;

  TAoP3D = TArray<TP3D>;

  TShaft = class;

  TLoad = class
  private
    fShaft: TShaft;
    fPoint: TP3D;      // punkty przyłożenia obciążenia
    fForce: TP3D;      // siła działająca w punkcie fPoint
    fTorque: Double;   // moment skręcający (skupiony)
    fMomentX: Double;  // moment gnący dla płaszczyzny XZ (skupiony)
    fMomentY: Double;  // moment gnący dla płaszczyzny YZ (skupiony)
    procedure Changed;
    function CalculateTorque: Double;
    function CalculateMomentX(AZ: Double): Double;
    function CalculateMomentY(AZ: Double): Double;
    procedure SetPoint(const APoint: TP3D);
    procedure SetTorque(const ATorque: Double);
    procedure SetMomentX(const AMomentXZ: Double);
    procedure SetMomentY(const AMomentYZ: Double);
  protected
    constructor Create(AShaft: TShaft; APoint, AForce: TP3D; ATorque, AMomentXZ, AMomentYZ: Double);
    function GetForce: TP3D; virtual;
    procedure SetForce(const AForce: TP3D);
    procedure SetZ(const AZ: Double); virtual;
    procedure SetX(const AZ: Double); virtual;
    procedure SetY(const AZ: Double); virtual;
    property Point: TP3D read fPoint write SetPoint;
    property Force: TP3D read GetForce;
    property Torque: Double read fTorque write SetTorque;
    property MomentX: Double read fMomentX write SetMomentX;
    property MomentY: Double read fMomentY write SetMomentY;
    property Fx: Double read fForce.X;
    property Fy: Double read fForce.Y;
    property Fz: Double read fForce.Z;
  public
    property X: Double read fPoint.X write SetX;
    property Y: Double read fPoint.Y write SetY;
    property Z: Double read fPoint.Z write SetZ;
  end;

  TForce = class(TLoad)
    property Point;
    property Force write SetForce;
    property Fx;
    property Fy;
    property Fz;
  end;

  TMoment = class(TLoad)
    property MomentX;
    property MomentY;
  end;

  TTorque = class(TLoad)
    property Torque;
  end;

  TReaction = class(TLoad)
  protected
    function GetForce: TP3D; override;
    procedure SetZ(const AZ: Double); override;
  public
    property Force;
    property Fx;
    property Fy;
    property Fz;
  end;

  TLoadConfig = (lcCoplanarX, lcCoplanarY, lcSpatial);

  TShaft = class(TObjectList<TLoad>)
  type
    TLoadCalculator = reference to function (ALoad: TLoad; AZ: Double): Double;
  private
    fSupportA: TReaction;         // podpora stała (obciążenia pod dowolnym kątem)
    fSupportB: TReaction;         // podpora ruchoma (obciążenie promieniowe)
    fOnChange: TNotifyEvent;      // procedure obsługi zdarzenia, wywoływana po wykonaniu obliczeń
    fUpdating: Integer;           // licznik wywołań zwiększany po wywołaniu BeginUpdate, a zmniejszany po wywołaniu EndUpdate
    fUpdateRequest: Boolean;      // flaga przechowująca informacje o tym, że dane lub obliczenia uległy zmianie
    fMinZValue: Double;
    fMaxZValue: Double;
    fConfig: TLoadConfig;         // przechowuje konfigurację obciążeń (płaski układ sił, przestrzenny układ sił)
    function Calculate(ACalculator: TLoadCalculator; AZ: Double): Double;
    procedure Update;
    procedure ValidityCheck;
    function GetReaction(AIdx: Integer): TP3D;
  public
    constructor Create; overload;
    destructor Destroy; override;
    // funkcje pomocnicze
    procedure BeginUpdate;
    procedure EndUpdate;
    function IsUpdating: Boolean;
    procedure Clear; reintroduce;
    // podpory
    procedure PlaceSupports(AAZ, ABZ: Double);
    procedure SwapSupports;
    // obciążenia
    function AddForce(AForce: TP3D; AZ: Double): TForce; overload;
    function AddForce(AForce, APoint: TP3D): TForce; overload;
    function AddForce(AFt, AFr, AFa: Double; AR, APhi, AZ: Double): TForce; overload;
    function AddTorque(ATorque: Double; AZ: Double): TTorque;
    function AddMoment(AMomentX, AMomentY: Double; AZ: Double): TMoment;
    procedure DeleteLoad(ALoad: TLoad);
    // lista punktów przyłożenia obciążeń (sortowana rosnąco wg współrzędnej Z)
    function ZPositions: TAoD;

    // siły i momenty
    function Axial(AZ: Double): Double;
    function ShearX(AZ: Double): Double;
    function ShearY(AZ: Double): Double;
    function Shear(AZ: Double): Double;
    function MomentX(AZ: Double): Double;
    function MomentY(AZ: Double): Double;
    function Moment(AZ: Double): Double;
    function Torque(AZ: Double): Double;
    // właściwości
    property Config: TLoadConfig read fConfig;
    property MinZValue: Double read fMinZValue;
    property MaxZValue: Double read fMaxZValue;
    property SupportA: TReaction read fSupportA;
    property SupportB: TReaction read fSupportB;
    property ReactionA: TP3D index 0 read GetReaction;
    property ReactionB: TP3D index 1 read GetReaction;
    property OnChange: TNotifyEvent read fOnChange write fOnChange;
  end;

  function Round(AValue: Double): Double;
  function P3D(AX, AY, AZ: Double): TP3D; overload;
  function P3D(AX, AY: Double): TP3D; overload;
  function P3D(AZ: Double): TP3D; overload;
  function Polar(AR, APhi: Double): TP3D; overload;
  function Polar(AR, APhi, AZ: Double): TP3D; overload;
//  function Find_Max(Tab: array of double;size:integer): Double;

type
  TDataCalculator = function (AZ: Double): Double of object;

  function PrepareZValues(AZValues: TAoD; ACount: Integer = 0): TAoD;
  function PrepareData(AZValues: TAoD; ACalculator: TDataCalculator): TAoD;

var
  Shaft: TShaft;

implementation

function Round(AValue: Double): Double;
begin
  Result := SimpleRoundTo(AValue, PRECISION);
end;

function P3D(AX, AY, AZ: Double): TP3D;
begin
  Result.X := AX;
  Result.Y := AY;
  Result.Z := AZ;
end;

function P3D(AX, AY: Double): TP3D;
begin
  Result.X := AX;
  Result.Y := AY;
  Result.Z := 0;
end;

function P3D(AZ: Double): TP3D;
begin
  Result.X := 0;
  Result.Y := 0;
  Result.Z := AZ;
end;

function Polar(AR, APhi: Double): TP3D;
begin
  Result := Polar(AR, APhi, 0);
end;

function Polar(AR, APhi, AZ: Double): TP3D;
var
  s, c: Double;
begin
  SinCos(DegToRad(APhi), s, c);
  Result := P3D(AR * c, AR * s, AZ);
end;

function Zero3D: TP3D;
begin
  Result.X := 0;
  Result.Y := 0;
  Result.Z := 0;
end;

function PrepareZValues(AZValues: TAoD; ACount: Integer = 0): TAoD;
// przygotowuje listę pozycji przekojów wzdłuż długości wału.
// Jeśli ACount = 0 to generowane będą jedynie przekroje charakterystyczne

  procedure AddValue(var AValues: TAoD; AValue: Double);
  begin
    if (Length(AValues) > 0) and (AValue - AValues[High(AValues)] <= EPSILON) then Exit;

    SetLength(AValues, Length(AValues) + 1);
    AValues[High(AValues)] := AValue;
  end;

var
  pts: TAoD;
  idx: Integer;
  dx, x: Double;
begin
  Assert(ACount <> 1, 'Nieprawidłowa liczba przedziałów');

  // podstawowe, charakterystyczne przekroje
  pts:=Shaft.ZPositions;

  SetLength(Result, 0);
  if ACount > 1 then begin
    // generowanie przekrojów z zadanym skokiem
    dx := (pts[High(pts)] - pts[0]) / (ACount - 1);
    x := pts[0];

    idx := 0;
    while x <= pts[High(pts)] do begin
      if x >= pts[idx] - EPSILON then begin
        AddValue(Result, pts[idx] - EPSILON);
        AddValue(Result, pts[idx] + EPSILON);
        Inc(idx);
      end;
      AddValue(Result, x);

      x := x + dx;
    end;
    AddValue(Result, pts[High(pts)] - EPSILON);
    AddValue(Result, pts[High(pts)] + EPSILON);
  end else begin
    // generowanie listy samych przekrojów charakterystycznych
    for x in pts do begin
      AddValue(Result, x - EPSILON);
      AddValue(Result, x + EPSILON);
    end;
  end;

end;

function PrepareData(AZValues: TAoD; ACalculator: TDataCalculator): TAoD;
// przygotowuje listę wartości obciążeń dla przekrojów wału podanych w AZValues
var
  idx: Integer;
begin
  SetLength(Result, Length(AZValues));
  for idx := 0 to High(AZValues) do
    Result[idx] := ACalculator(AZValues[idx]);
end;

{ TLoad }

function TLoad.CalculateMomentX(AZ: Double): Double;
begin
  Result := Force.X * (AZ - Z) + Force.Z * X + MomentX;
end;

function TLoad.CalculateMomentY(AZ: Double): Double;
begin
  Result := Force.Y * (AZ - Z) + Force.Z * Y + MomentY;
end;

function TLoad.CalculateTorque: Double;
begin
  Result := Force.X * Y - Force.Y * X + Torque;
end;

procedure TLoad.Changed;
begin
//  if Self is TReaction then Exit;

  fShaft.Update;
end;

constructor TLoad.Create(AShaft: TShaft; APoint, AForce: TP3D; ATorque, AMomentXZ, AMomentYZ: Double);
begin
  fShaft := AShaft;
  fPoint := APoint;
  fForce := AForce;
  fTorque := ATorque;
  fMomentX := AMomentXZ;
  fMomentY := AMomentYZ;
end;

function TLoad.GetForce: TP3D;
begin
  Result := fForce;
end;

procedure TLoad.SetForce(const AForce: TP3D);
begin
  fForce := AForce;
  Changed;
end;

procedure TLoad.SetMomentX(const AMomentXZ: Double);
begin
  fMomentX := AMomentXZ;
  Changed;
end;

procedure TLoad.SetMomentY(const AMomentYZ: Double);
begin
  fMomentY := AMomentYZ;
  Changed;
end;

procedure TLoad.SetPoint(const APoint: TP3D);
begin
  fPoint := APoint;
  Changed;
end;

procedure TLoad.SetTorque(const ATorque: Double);
begin
  fTorque := ATorque;
  Changed;
end;

procedure TLoad.SetZ(const AZ: Double);
begin
  fPoint.Z := AZ;
  Changed;
end;

procedure TLoad.SetX(const AZ: Double);
begin
  fPoint.X := AZ;
  Changed;
end;

procedure TLoad.SetY(const AZ: Double);
begin
  fPoint.Y := AZ;
  Changed;
end;



{ TReaction }

function TReaction.GetForce: TP3D;
begin
  fShaft.ValidityCheck;
  Result := inherited;
end;

procedure TReaction.SetZ(const AZ: Double);
// zmiana położenia podpór
var
  valid: Boolean;
begin
  // warunek sprawdzający czy zmiana nie doprowadzi do sytuacji, w której podpory znajdą się w tym samym miejscu
  valid := ((fShaft.fSupportA = Self) and (fShaft.fSupportB.Z <> AZ)) or ((fShaft.fSupportB = Self) and (fShaft.fSupportA.Z <> AZ));
  Assert(valid, 'Podpora stała i ruchoma nie mogą się znajdować w tym samym miejscu');

  inherited;
end;

{ TShaft }

function TShaft.AddForce(AForce: TP3D; AZ: Double): TForce;
// dodaje siłę obciążającą
begin
  Result := TForce.Create(Self, P3D(AZ), AForce, 0, 0, 0);
  Add(Result);
  Update;
end;

function TShaft.AddForce(AForce, APoint: TP3D): TForce;
// dodaje siłę obciążającą
begin
  Result := TForce.Create(Self, APoint, AForce, 0, 0, 0);
  Add(Result);
  Update;
end;

function TShaft.AddForce(AFt, AFr, AFa, AR, APhi, AZ: Double): TForce;
// dodaje siłę obciążającą zdefiniowaną za pomocą: siły obwodowej (Ft), siły promieniowej (Fr) i siły osiowej (Fa)
var
  c, s: Double;
begin
  Assert(AR <> 0, 'Długość promienia AR musi być różna od 0');

  // obliczenie współrzędny wersorów obróconego układu współrzędnych ηζ w układzie XY
  SinCos(DegToRad(APhi), s, c);

  // konwersja siły i punktu jej przyczepienia z układu ηζ do układu XY
  Result := AddForce(P3D(AFr * c - AFt * s, AFr * s + AFt * c, AFa), P3D(AR * c, AR * s, AZ));
end;

function TShaft.AddMoment(AMomentX, AMomentY, AZ: Double): TMoment;
// dodaje moment gnący
begin
  Result := TMoment.Create(Self, P3D(AZ), Zero3D, 0, AMomentX, AMomentY);
  Add(Result);
  Update;
end;

function TShaft.AddTorque(ATorque, AZ: Double): TTorque;
begin
  Result := TTorque.Create(Self, P3D(AZ), Zero3D, ATorque, 0, 0);
  Add(Result);
  Update;
end;

function TShaft.Axial(AZ: Double): Double;
// zwraca wypadkową siłę osiową dla przekroju AZ
begin
  Result := Calculate(
    function (ALoad: TLoad; AZ: Double): Double
    begin
      Result := ALoad.Force.Z;
    end, AZ);
end;

procedure TShaft.BeginUpdate;
// zwiększa licznik fUpdating co wpływa na aktualizację reakcji (jest możliwa tylko jeśli fUpdating = 0)
begin
  Inc(fUpdating);
end;

function TShaft.Calculate(ACalculator: TLoadCalculator; AZ: Double): Double;
// zwraca wypadkową siłę osiową Fz (Fa) w przekroju AZ
var
  load: TLoad;
begin
  Result := 0;

  // jeśli pozycja AZ jest spoza zakresu to zwracam wartość 0
  if not InRange(AZ, fMinZValue, fMaxZValue) then Exit;

  // obciążenia
  for load in ToArray do
    if load.Z <= AZ then
      Result := Result + ACalculator(load, AZ);

  // podpory
  if fSupportA.Z <= AZ then
    Result := Result + ACalculator(fSupportA, AZ);

  if fSupportB.Z <= AZ then
    Result := Result + ACalculator(fSupportB, AZ);

  // wynik zaokrąglam do kilku miejsc po przecinku
  Result := Round(Result);
end;

procedure TShaft.Clear;
// czyszczenie danych
begin
  inherited Clear;

  fSupportA.fPoint := Zero3D;
  fSupportA.fForce := Zero3D;
  fSupportB.fPoint := P3D(1);
  fSupportB.fForce := Zero3D;
  Update;
end;

constructor TShaft.Create;
begin
  // komparator wykorzystywany przy sortowaniu tablicy
  Create(TComparer<TLoad>.Construct(
    function (const ALeft, ARight: TLoad): Integer
    begin
      Result := TComparer<Double>.Default.Compare(ALeft.Z, ARight.Z);
    end),
  True);

  // domyślne położenie podpór
  fSupportA := TReaction.Create(Self, P3D(0), Zero3D, 0, 0, 0);
  fSupportB := TReaction.Create(Self, P3D(1), Zero3D, 0, 0, 0);
  Update;
end;

procedure TShaft.DeleteLoad(ALoad: TLoad);
// usuwa wybrane obciążenie
begin
  Remove(ALoad);
  Update;
end;

destructor TShaft.Destroy;
// destruktor
begin
  inherited Clear;

  fSupportA.Free;
  fSupportB.Free;

  inherited;
end;

procedure TShaft.EndUpdate;
// dekrementuje wartość licznika fUpdating
begin
  Assert(fUpdating > 0);
  Dec(fUpdating);

  if fUpdating < 1 then Update;
end;

function TShaft.GetReaction(AIdx: Integer): TP3D;
// zwraca wartość reakcji (AIdx = 0 -> podpora stała, AIdx = 1 -> podpora ruchoma)
begin
  Result := fSupportA.Force;
  if AIdx = 1 then Result := fSupportB.Force;
end;

function TShaft.IsUpdating: Boolean;
// zwraca True jeśli trwa aktualizacja danych
begin
  Result := fUpdating > 0;
end;

function TShaft.Moment(AZ: Double): Double;
// zwraca wypadkowy moment gnący dla przekroju AZ
begin
  Result := Round(Sqrt(Sqr(MomentX(AZ)) + Sqr(MomentY(AZ))));
end;

function TShaft.MomentX(AZ: Double): Double;
// zwraca wypadkowy moment gnący w płaszczyźnie XZ dla przekroju AZ
begin
  ValidityCheck;
  Result := Calculate(
    function (ALoad: TLoad; AZ: Double): Double
    begin
      Result := ALoad.CalculateMomentX(AZ);
    end, AZ);
end;

function TShaft.MomentY(AZ: Double): Double;
// zwraca wypadkowy moment gnący w płaszczyźnie YZ dla przekroju AZ
begin
  ValidityCheck;
  Result := Calculate(
    function (ALoad: TLoad; AZ: Double): Double
    begin
      Result := ALoad.CalculateMomentY(AZ);
    end, AZ);
end;

procedure TShaft.PlaceSupports(AAZ, ABZ: Double);
// zmienia położenie podpór
begin
  Assert(AAZ <> ABZ, 'Podpory nie mogą się znajdować w tym samym miejscu');

  fSupportA.fPoint.Z := AAZ;
  fSupportB.fPoint.Z := ABZ;
  Update;
end;

function TShaft.Shear(AZ: Double): Double;
// zwraca wypadkową siłę tnącą dla przekroju AZ
begin
  Result := Round(Sqrt(Sqr(ShearX(AZ)) + Sqr(ShearY(AZ))));
end;

function TShaft.ShearX(AZ: Double): Double;
// zwraca wypadkową siłę tnącą w osi X dla przekroju AZ
begin
  ValidityCheck;
  Result := Calculate(
    function (ALoad: TLoad; AZ: Double): Double
    begin
      Result := ALoad.Force.X;
    end, AZ);
end;

function TShaft.ShearY(AZ: Double): Double;
// zwraca wypadkową siłę tnącą w osi Y dla przekroju AZ
begin
  ValidityCheck;
  Result := Calculate(
    function (ALoad: TLoad; AZ: Double): Double
    begin
      Result := ALoad.Force.Y;
    end, AZ);
end;

procedure TShaft.SwapSupports;
// zamiania podpory miejscami
var
  tmp: Double;
begin
  tmp := fSupportA.Z;
  fSupportA.fPoint.Z := fSupportB.fPoint.Z;
  fSupportB.fPoint.Z := tmp;
  Update;
end;

function TShaft.Torque(AZ: Double): Double;
// zwraca wypadkowy moment skręcający dla przekroju AZ (moment skręcający w płaszczyźnie
// XY powodujący obrót wału zgodnie z ruchem wskazówek zegara przyjęto jako dodatni
begin
  ValidityCheck;
  Result := Calculate(
    function (ALoad: TLoad; AZ: Double): Double
    begin
      Result := ALoad.CalculateTorque;
    end, AZ);
end;

procedure TShaft.Update;
// wywoływane zawsze po zmianie obciążeń

  procedure CalculateReactions;
  // aktualizuje wartości reakcji
  var
    load: TLoad;
    mfz, max, may, mbx, mby, dz: Double;
  begin
    // inicjalizuję wartości reakcji
    mfz := 0;
    max := 0;
    may := 0;
    mbx := 0;
    mby := 0;

    // wyznaczanie reakcji podporowych
    for load in ToArray do begin
      // obliczenie dla podpory stałej
      mfz := mfz - load.Force.Z;
      max := max - load.CalculateMomentX(fSupportA.Z);
      may := may - load.CalculateMomentY(fSupportA.Z);

      // obliczenie dla podpory ruchomej
      mbx := mbx - load.CalculateMomentX(fSupportB.Z);
      mby := mby - load.CalculateMomentY(fSupportB.Z);
    end;

    // zapamiętanie reakcji podporowych
    dz := fSupportB.Z - fSupportA.Z;
    fSupportA.fForce := P3D(Round(mbx / dz), Round(mby / dz), Round(mfz));
    fSupportB.fForce := P3D(Round(-max / dz), Round(-may / dz), Round(0));
  end;

var
  zvals: TAoD;
  xexists, yexists: Boolean;
  load: TLoad;
begin
  // ustawiam flagę żądania aktualizacji reakcji
  fUpdateRequest := True;

  // jeśli trwa aktualizacja, np. dodawanie większej liczby obciążeń to aktualizację odkładam na później
  if fUpdating > 0 then Exit;

  // sortuję obciążenia i aktualizuję zakres zmienności Z
  Sort;

  // aktualizuję minimalną i maksymalną wartość współrzędnej Z
  zvals := ZPositions;
  fMinZValue := zvals[0];
  fMaxZValue := zvals[High(zvals)];

  // sprawdzam czy przypadkiem układ sił nie jest układem płaskim. W takiej sytuacji nie trzeba rysować wszystkich wykresów
  xexists := False;
  yexists := False;
  for load in ToArray do begin
    xexists := xexists or ((load is TForce) and (TForce(load).Fx <> 0)) or ((load is TMoment) and (TMoment(load).MomentX <> 0));
    yexists := yexists or ((load is TForce) and (TForce(load).Fy <> 0)) or ((load is TMoment) and (TMoment(load).MomentY <> 0));
  end;

  if xexists and yexists then fConfig := lcSpatial else
  if xexists then fConfig := lcCoplanarX else
  fConfig := lcCoplanarY;

  // obliczam reakcje, obsługuję zdarzenie (jeśli jest taka potrzeba) i kasuję flagę żądania aktualizacji
  if fUpdateRequest then CalculateReactions;
  if fUpdateRequest and Assigned(fOnChange) then fOnChange(Self);
  fUpdateRequest := False;
end;

procedure TShaft.ValidityCheck;
// sprawdza czy reacje są zaktualizowane; jeśli nie to wyrzuca Assert'a
begin
  Assert(not IsUpdating, 'Trwa aktualizacja danych więc reakcje mogą być nieaktualne');
end;

function TShaft.ZPositions: TAoD;
// zwraca listę granic przedziałów

  procedure AddZ(AZ: Double);
  var
    z: Double;
  begin
    // jeśli wartość była już wcześniej dodana to sprawdzam następną wartość
    for z in Result do
      if z = AZ then Exit;

    // dodaję wartość do wyników
    SetLength(Result, Length(Result) + 1);
    Result[High(Result)] := AZ;
  end;

var
  load: TLoad;
begin
  // tworzę posortowaną tablicę wyników
  SetLength(Result, 0);
  for load in ToArray do AddZ(load.Z);
  AddZ(fSupportA.Z);
  AddZ(fSupportB.Z);
  TArray.Sort<Double>(Result);
end;

initialization
  Shaft := TShaft.Create;

finalization
  Shaft.Free;

end.
