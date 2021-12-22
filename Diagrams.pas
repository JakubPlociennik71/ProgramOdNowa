unit Diagrams;

interface

uses Types, Loads, Graphics;

procedure PrepareMap(ADataXMin, ADataYMin, ADataXMax, ADataYMax: Double; ACanvasXMin, ACanvasYMin, ACanvasXMax, ACanvasYMax: Integer); overload;
procedure PrepareMap(ADataXMin, ADataYMin, ADataXMax, ADataYMax: Double; ACanvasRect: TRect); overload;

function Map(ADataX, ADataY: Double): TPoint;

procedure Diagram(ACanvas: TCanvas; AColor: TColor; AXValues, AYValues: TAoD);

implementation

uses
  Math, GraphUtil;

type
  TAoP = array of TPoint;

var
  fDataXMin, fDataYMin: Double;       // współrzędne lewego, dolnego narożnika okna do rysowania
  fDataXMax, fDataYMax: Double;       // współrzędne prawego, górnego narożnika okna do rysowania
  fCanvasXMin, fCanvasYMin: Integer;  // współrzędne lewego, rórneto narożnika obszaru na kontrolce (oś Y jest obrócona więc Y = 0 będzie u góry)
  fCanvasXMax, fCanvasYMax: Integer;  // współrzędne prawego, górnego narożnika obszaru na kontrolce

procedure PrepareMap(ADataXMin, ADataYMin, ADataXMax, ADataYMax: Double; ACanvasXMin, ACanvasYMin, ACanvasXMax, ACanvasYMax: Integer);
begin
  fDataXMin := MinValue([0, ADataXMin, ADataXMax]);
  fDataYMin := MinValue([0, ADataYMin, ADataYMax]);
  fDataXMax := MaxValue([0, ADataXMin, ADataXMax]);
  fDataYMax := MaxValue([0, ADataYMin, ADataYMax]);

  fCanvasXMin := ACanvasXMin;
  fCanvasYMin := ACanvasYMin;
  fCanvasXMax := ACanvasXMax;
  fCanvasYMax := ACanvasYMax;
end;

procedure PrepareMap(ADataXMin, ADataYMin, ADataXMax, ADataYMax: Double; ACanvasRect: TRect);
begin
  PrepareMap(ADataXMin, ADataYMin, ADataXMax, ADataYMax, ACanvasRect.Left, ACanvasRect.Top, ACanvasRect.Right, ACanvasRect.Bottom);
end;

function Map(ADataX, ADataY: Double): TPoint;
var
  sx, sy: Double;
begin
  sx := fDataXMax - fDataXMin;
  sy := fDataYMax - fDataYMin;

  if sx > 0 then sx := (fCanvasXMax - fCanvasXMin - 1) / sx;
  if sy > 0 then sy := (fCanvasYMin - fCanvasYMax + 1) / sy;

  Result.X := IfThen(sx <> 0, System.Round(fCanvasXMin + (ADataX - fDataXMin) * sx), (fCanvasXMin + fCanvasXMax) div 2);
  Result.Y := IfThen(sy <> 0, System.Round(fCanvasYMax + (ADataY - fDataYMin) * sy), (fCanvasYMin + fCanvasYMax) div 2) - 1;
end;

procedure Diagram(ACanvas: TCanvas; AColor: TColor; AXValues, AYValues: TAoD);
var
  pts: TAoP;
  idx: Integer;
  pt: TPoint;
begin
  Assert(Length(AXValues) = Length(AYValues), 'Tablice AXValues i AYValues muszą być tej samej długości');
  Assert(Length(AXValues) > 0, 'Tablice nie mogą być puste');

  // kasuję tło
  ACanvas.Brush.Color := clWindow;
  ACanvas.FillRect(Rect(fCanvasXMin, fCanvasYMin, fCanvasXMax, fCanvasYMax));

  // przygotowuję tablicę punktów do rysowania wielokąta
  SetLength(pts, Length(AXValues) + 1);
  for idx := 0 to High(AXValues) do
    pts[idx] := Map(AXValues[idx], AYValues[idx]);
  pts[High(pts)] := pts[0];

  // rysuję wykres
  ACanvas.Pen.Color := AColor;
  ACanvas.Brush.Color := ColorBlendRGB(AColor, clWindow, 0.5);
  ACanvas.Polygon(pts);

  // na koniec rysuję osie
  pt := Map(0, 0);
  ACanvas.Pen.Color := clBlack;
  if InRange(pt.X, fCanvasXMin, fCanvasXMax) then begin
    ACanvas.MoveTo(pt.X, fCanvasYMin);
    ACanvas.LineTo(pt.X, fCanvasYMax);
  end;

  if InRange(pt.Y, fCanvasYMin, fCanvasYMax) then begin
    ACanvas.MoveTo(fCanvasXMin, pt.Y);
    ACanvas.LineTo(fCanvasXMax, pt.Y);
  end;
end;

end.
