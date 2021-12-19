unit Loads;

interface

uses System.Classes, Math, Generics.Collections, Generics.Defaults;

const
  EPSILON = 1e-12;
  PRECISION = -6;   // wyniki zaokrąglam do 6 miejsca po przecinku

type
  // przyjmujemy układ współrzędnych jak w Kurmazie, czyli:
  // oś Z w prawo, oś Y w górę, a oś X wychodzi z ekranu

  TAoD = TArray<Double>;

  TP3D = record X, Y, Z: Double; end;

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
    property Point: TP3D read fPoint write SetPoint;
    property Force: TP3D read GetForce;
    property Torque: Double read fTorque write SetTorque;
    property MomentX: Double read fMomentX write SetMomentX;
    property MomentY: Double read fMomentY write SetMomentY;
  public
    property X: Double read fPoint.X;
    property Y: Double read fPoint.Y;
    property Z: Double read fPoint.Z write SetZ;
  end;

  TForce = class(TLoad)
    property Point;
    property Force write SetForce;
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
  end;

  TShaft = class(TObjectList<TLoad>)
  type
    TLimit = (ltLeftLimit, ltRightLimit);
    TLoadCalculator = reference to function (ALoad: TLoad; AZ: Double): Double;
 private
    fAngularReaction: TReaction;  // podpora stała (obciążenia pod dowolnym kątem)
    fRadialReaction: TReaction;   // podpora ruchoma (obciążenie promieniowe)
    fOnChange: TNotifyEvent;      // procedure obsługi zdarzenia, wywoływana po wykonaniu obliczeń
    fUpdating: Integer;           // licznik wywołań zwiększany po wywołaniu BeginUpdate, a zmniejszany po wywołaniu EndUpdate
    fUpdateRequest: Boolean;      // flaga przechowująca informacje o tym, że dane lub obliczenia uległy zmianie
    function Calculate(ACalculator: TLoadCalculator; AZ: Double; ACalcKind: TLimit): Double;
    procedure UpdateReactions;    // oblicza reakcje podporowa
    procedure Update;
    procedure ValidityCheck;
  public
    constructor Create; overload;
    destructor Destroy; override;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure Clear; reintroduce;
    function IsUpdating: Boolean;

    // definiowanie obciążeń
    function AddForce(AForce: TP3D; AZ: Double): TForce; overload;
    function AddForce(AForce, APoint: TP3D): TForce; overload;
    function AddTorque(ATorque: Double; AZ: Double): TTorque;
    function AddMoment(AMomentX, AMomentY: Double; AZ: Double): TMoment;
    procedure DeleteLoad(ALoad: TLoad);
    // lista punktów przyłożenia obciążeń (sortowana rosnąco wg współrzędnej Z)
    function ZPositions: TAoD;
    // siły i momenty
    function Axial(AZ: Double; ACalcKind: TLimit = ltRightLimit): Double;
    function ShearX(AZ: Double; ACalcKind: TLimit = ltRightLimit): Double;
    function ShearY(AZ: Double; ACalcKind: TLimit = ltRightLimit): Double;
    function Shear(AZ: Double; ACalcKind: TLimit = ltRightLimit): Double;
    function MomentX(AZ: Double; ACalcKind: TLimit = ltRightLimit): Double;
    function MomentY(AZ: Double; ACalcKind: TLimit = ltRightLimit): Double;
    function Moment(AZ: Double; ACalcKind: TLimit = ltRightLimit): Double;
    function Torque(AZ: Double; ACalcKind: TLimit = ltRightLimit): Double;
    // właściwości
    property AngularReaction: TReaction read fAngularReaction;
    property RadialReaction: TReaction read fRadialReaction;
    property OnChange: TNotifyEvent read fOnChange write fOnChange;
  end;

  function Round(AValue: Double): Double;
  function P3D(AX, AY, AZ: Double): TP3D; overload;
  function P3D(AX, AY: Double): TP3D; overload;
  function P3D(AZ: Double): TP3D; overload;

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

function Zero3D: TP3D;
begin
  Result.X := 0;
  Result.Y := 0;
  Result.Z := 0;
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
  if Self is TReaction then Exit;

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
  valid := ((fShaft.fAngularReaction = Self) and (fShaft.fRadialReaction.Z <> AZ)) or ((fShaft.fRadialReaction = Self) and (fShaft.fAngularReaction.Z <> AZ));
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

function TShaft.Axial(AZ: Double; ACalcKind: TLimit): Double;
// zwraca wypadkową siłę osiową dla przekroju AZ
begin
  Result := Calculate(
    function (ALoad: TLoad; AZ: Double): Double
    begin
      Result := ALoad.Force.Z;
    end, AZ, ACalcKind);
end;

procedure TShaft.BeginUpdate;
// zwiększa licznik fUpdating co wpływa na aktualizację reakcji (jest możliwa tylko jeśli fUpdating = 0)
begin
  Inc(fUpdating);
end;

function TShaft.Calculate(ACalculator: TLoadCalculator; AZ: Double; ACalcKind: TLimit): Double;
// zwraca wypadkową siłę osiową Fz (Fa) w przekroju AZ
const
  DELTAS: array [TLimit] of Double = (-EPSILON, EPSILON);
var
  load: TLoad;
begin
  Result := 0;

  // uwględnieni obczlień granicznych (wartość w punkcie, granica lewostronna, granica prawostronna)
  AZ := AZ + DELTAS[ACalcKind];

  // obciążenia
  for load in ToArray do
    if load.Z <= AZ then
      Result := Result + ACalculator(load, AZ);

  // podpory
  if fAngularReaction.Z <= AZ then
    Result := Result + ACalculator(fAngularReaction, AZ);

  if fRadialReaction.Z <= AZ then
    Result := Result + ACalculator(fRadialReaction, AZ);

  // wynik zaokrąglam do kilku miejsc po przecinku
  Result := Round(Result);
end;

procedure TShaft.Clear;
// czyszczenie danych
begin
  inherited Clear;

  fAngularReaction.fPoint := Zero3D;
  fAngularReaction.fForce := Zero3D;
  fRadialReaction.fPoint := P3D(1);
  fRadialReaction.fForce := Zero3D;
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
  fAngularReaction := TReaction.Create(Self, P3D(0), Zero3D, 0, 0, 0);
  fRadialReaction := TReaction.Create(Self, P3D(1), Zero3D, 0, 0, 0);
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

  fAngularReaction.Free;
  fRadialReaction.Free;

  inherited;
end;

procedure TShaft.EndUpdate;
// dekrementuje wartość licznika fUpdating
begin
  Assert(fUpdating > 0);
  Dec(fUpdating);

  if fUpdating < 1 then Update;
end;

function TShaft.IsUpdating: Boolean;
// zwraca True jeśli trwa aktualizacja danych
begin
  Result := fUpdating > 0;
end;

function TShaft.Moment(AZ: Double; ACalcKind: TLimit): Double;
// zwraca wypadkowy moment gnący dla przekroju AZ
begin
  Result := Sqrt(Sqr(MomentX(AZ, ACalcKind)) + Sqr(MomentY(AZ, ACalcKind)));
end;

function TShaft.MomentX(AZ: Double; ACalcKind: TLimit): Double;
// zwraca wypadkowy moment gnący w płaszczyźnie XZ dla przekroju AZ
begin
  ValidityCheck;
  Result := Calculate(
    function (ALoad: TLoad; AZ: Double): Double
    begin
      Result := ALoad.CalculateMomentX(AZ);
    end, AZ, ACalcKind);
end;

function TShaft.MomentY(AZ: Double; ACalcKind: TLimit): Double;
// zwraca wypadkowy moment gnący w płaszczyźnie YZ dla przekroju AZ
begin
  ValidityCheck;
  Result := Calculate(
    function (ALoad: TLoad; AZ: Double): Double
    begin
      Result := ALoad.CalculateMomentY(AZ);
    end, AZ, ACalcKind);
end;

function TShaft.Shear(AZ: Double; ACalcKind: TLimit): Double;
// zwraca wypadkową siłę tnącą dla przekroju AZ
begin
  Result := Sqrt(Sqr(ShearX(AZ, ACalcKind)) + Sqr(ShearY(AZ, ACalcKind)));
end;

function TShaft.ShearX(AZ: Double; ACalcKind: TLimit): Double;
// zwraca wypadkową siłę tnącą w osi X dla przekroju AZ
begin
  ValidityCheck;
  Result := Calculate(
    function (ALoad: TLoad; AZ: Double): Double
    begin
      Result := ALoad.Force.X;
    end, AZ, ACalcKind);
end;

function TShaft.ShearY(AZ: Double; ACalcKind: TLimit): Double;
// zwraca wypadkową siłę tnącą w osi Y dla przekroju AZ
begin
  ValidityCheck;
  Result := Calculate(
    function (ALoad: TLoad; AZ: Double): Double
    begin
      Result := ALoad.Force.Y;
    end, AZ, ACalcKind);
end;

function TShaft.Torque(AZ: Double; ACalcKind: TLimit): Double;
// zwraca wypadkowy moment skręcający dla przekroju AZ
begin
  ValidityCheck;
  Result := Calculate(
    function (ALoad: TLoad; AZ: Double): Double
    begin
      // Moment skręcający w płaszczyźnie XY powodujący obrót wału
      // zgodnie z ruchem wskazówek zegara przyjęto jako dodatni
      Result := ALoad.CalculateTorque; //  ALoad.Force.X * ALoad.Y - ALoad.Force.Y * ALoad.X + ALoad.Torque;
    end, AZ, ACalcKind);
end;

procedure TShaft.Update;
// wywoływane zawsze po zmianie obciążeń
begin
  // ustawiam flagę żądania aktualizacji reakcji
  fUpdateRequest := True;

  // jeśli trwa aktualizacja, np. dodawanie większej liczby obciążeń to aktualizację odkładam na później
  if fUpdating > 0 then Exit;

  // sortuję obciążenia, obliczam reakcje, obsługuję zdarzenie (jeśli jest taka potrzeba) i kasuję flagę żądania aktualizacji
  Sort;
  if fUpdateRequest then UpdateReactions;
  if fUpdateRequest and Assigned(fOnChange) then fOnChange(Self);
  fUpdateRequest := False;
end;

procedure TShaft.UpdateReactions;
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
    max := max - load.CalculateMomentX(fAngularReaction.Z);
    may := may - load.CalculateMomentY(fAngularReaction.Z);

    // obliczenie dla podpory ruchomej
    mbx := mbx - load.CalculateMomentX(fRadialReaction.Z);
    mby := mby - load.CalculateMomentY(fRadialReaction.Z);
  end;

  // zapamiętanie reakcji podporowych
  dz := fRadialReaction.Z - fAngularReaction.Z;
  fAngularReaction.fForce := P3D(Round(mbx / dz), Round(mby / dz), Round(mfz));
  fRadialReaction.fForce := P3D(Round(-max / dz), Round(-may / dz), Round(0));
end;

procedure TShaft.ValidityCheck;
// sprawdza czy reacje są zaktualizowane; jeśli nie to wyrzuca Assert'a
begin
  Assert(not IsUpdating, 'Trwa aktualizacja danych więc reakcje mogą być nieaktualne');
end;

function TShaft.ZPositions: TAoD;
// zwraca listę współrzędnych Z niebezpiecznych przekrojów (czyli tych, w których przyłożone jest jakieś obciążenie)

  procedure AddZ(AZ: Double);
  var
    z: Double;
  begin
    // jeśli wartość była już wcześniej dodana to sprawdzam następną wartość
    for z in Result do
      if z = AZ then Break;

    // dodaję wartość do wyników
    SetLength(Result, Length(Result) + 1);
    Result[High(Result)] := AZ;
  end;

var
  load: TLoad;
begin
  // tworzę tablicę wyników
  SetLength(Result, 0);
  for load in ToArray do AddZ(load.Z);
  AddZ(fAngularReaction.Z);
  AddZ(fRadialReaction.Z);

  TArray.Sort<Double>(Result);
end;

initialization
  Shaft := TShaft.Create;

finalization
  Shaft.Free;

end.
