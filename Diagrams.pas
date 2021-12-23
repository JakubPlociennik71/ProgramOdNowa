unit Diagrams;

interface

uses Types, Loads, Graphics, Controls;

type
  TSeries = record
    ZValues: TAoD;
    SectionPos: TAoD;
    LoadPos: TAoD;
    Data: array of record
      Name: string;
      Color: TColor;
      SectionData: TAoD;
      LoadData: TAoD;
    end;
  end;

  procedure PaintDiagrams(AControl: TGraphicControl; ASeries: TSeries);

implementation

uses
  Windows, Math, GraphUtil, SysUtils;

type
  TAoP = array of TPoint;

  TCustomControlHelper = class helper for TGraphicControl
    function GetCanvas: TCanvas;
  end;

procedure DrawTextRotated(ACanvas: TCanvas; ARect: TRect; AAngle: Integer; AColor: TColor; AText: string);
var
  lf: LOGFONT; // Windows native font structure
begin
  ACanvas.Brush.Style := bsClear; // Set the brush style to transparent.
  FillChar(lf, SizeOf(lf), Byte(0));
  lf.lfHeight := ACanvas.Font.Height;
  lf.lfEscapement :=  10 * AAngle; // Degrees to rotate
  lf.lfOrientation := 10 * AAngle;
  lf.lfCharSet := DEFAULT_CHARSET;
  lf.lfQuality := ANTIALIASED_QUALITY;
  StrCopy(lf.lfFaceName, PChar(ACanvas.Font.Name));

  ACanvas.Font.Handle := CreateFontIndirect(lf);
  ACanvas.Font.Color := AColor;
//  ACanvas.TextOut(AX, AY, AText); // Output the rotated font.
  ACanvas.TextRect(ARect, AText, [tfBottom, tfSingleLine]);
end;

var
  fDataXMin, fDataYMin: Double;       // współrzędne lewego, dolnego narożnika okna do rysowania
  fDataXMax, fDataYMax: Double;       // współrzędne prawego, górnego narożnika okna do rysowania
  fCanvasXMin, fCanvasYMin: Integer;  // współrzędne lewego, rórneto narożnika obszaru na kontrolce (oś Y jest obrócona więc Y = 0 będzie u góry)
  fCanvasXMax, fCanvasYMax: Integer;  // współrzędne prawego, górnego narożnika obszaru na kontrolce

procedure PrepareMap(ADataXMin, ADataYMin, ADataXMax, ADataYMax: Double; ACanvasRect: TRect);
begin
  fDataXMin := MinValue([0, ADataXMin, ADataXMax]);
  fDataYMin := MinValue([0, ADataYMin, ADataYMax]);
  fDataXMax := MaxValue([0, ADataXMin, ADataXMax]);
  fDataYMax := MaxValue([0, ADataYMin, ADataYMax]);

  fCanvasXMin := ACanvasRect.Left;
  fCanvasYMin := ACanvasRect.Top;
  fCanvasXMax := ACanvasRect.Right;
  fCanvasYMax := ACanvasRect.Bottom;
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

procedure PaintDiagrams(AControl: TGraphicControl; ASeries: TSeries);
const
  DIAGRAM_HEIGHT      = 100;
  DIAGRAM_SPACING     = 15;
  DIAGRAM_MARGINS     = 10;
  DIAGRAM_LEFT_MARGIN = 30;

  procedure PrepareData(AXValues, AYValues: TAoD; var AData: TAoP);
  var
    idx: Integer;
  begin
    SetLength(AData, Length(AXValues));
    for idx := 0 to High(AData) do
      AData[idx] := Map(AXValues[idx], AYValues[idx]);
  end;

  procedure ClearRect(ACanvas: TCanvas; ARect: TRect; AColor: TColor);
  begin
    ACanvas.Brush.Style := bsSolid;
    ACanvas.Brush.Color := ColorToRGB(AColor);
    ACanvas.FillRect(ARect);
  end;

  procedure PaintDiagram(ACanvas: TCanvas; AColor: TColor; AData, ANodes: TAoP);
  const
    LINE_WIDTH = 2;
    NODE_SIZE  = 3;
  var
    pt: TPoint;
  begin
    // wypełniam tło wykresu
    ACanvas.Pen.Style := psSolid;
    ACanvas.Pen.Color := ColorToRGB(AColor);
    ACanvas.Pen.Width := 2;
    ACanvas.Brush.Color := ColorBlendRGB(AColor, clWindow, 0.95);
    ACanvas.Brush.Style := bsSolid;
    ACanvas.Polygon(AData);

    // dodaję pionowe kreskowanie
    ACanvas.Brush.Color := ColorBlendRGB(AColor, clWindow, 0.6);
    ACanvas.Brush.Style := bsVertical;
    ACanvas.Polygon(AData);

    // i poprawiam kontur wykresu
    ACanvas.Polyline(AData);

    {$REGION 'Rysowanie osi dla wykresów'
//    pt := Map(0, 0);
//    ACanvas.Pen.Color := clBlack;
//    ACanvas.Pen.Width := 1;
//
//    if InRange(pt.X, fCanvasXMin, fCanvasXMax) then begin
//      ACanvas.MoveTo(pt.X, fCanvasYMin);
//      ACanvas.LineTo(pt.X, fCanvasYMax);
//    end;
//
//    if InRange(pt.Y, fCanvasYMin, fCanvasYMax) then begin
//      ACanvas.MoveTo(fCanvasXMin, pt.Y);
//      ACanvas.LineTo(fCanvasXMax, pt.Y);
//    end;
    {$ENDREGION}

    // oraz rysuję punkty charakterystyczne wykresu
    ACanvas.Pen.Color := ColorToRGB(AColor);
    ACanvas.Pen.Width := 1;
    ACanvas.Brush.Color := ColorToRGB(AColor);
    ACanvas.Brush.Style := bsSolid;
    for pt in ANodes do
      ACanvas.Ellipse(pt.X - NODE_SIZE, pt.Y - NODE_SIZE, pt.X + NODE_SIZE, pt.Y + NODE_SIZE);
  end;

  procedure PaintDottedLines(ACanvas: TCanvas; AValues: TAoD);
  var
    value: Double;
    pt: TPoint;
  begin
    // ustawiam szarą linię punktową
    ACanvas.Pen.Style := psDot;
    ACanvas.Pen.Color := clGray;
    ACanvas.Brush.Style := bsClear;

    // i rysuję granice przedziałów
    for value in AValues do begin
      pt := Map(value, 0);
      ACanvas.MoveTo(pt.X, DIAGRAM_MARGINS);
      ACanvas.LineTo(pt.X, AControl.ClientHeight - DIAGRAM_MARGINS);
    end;
  end;

var
  can: TCanvas;
  idx: Integer;
  rct: TRect;
  sdata, ldata: TAoP;
  ts: TSize;
begin
  Assert(Length(ASeries.SectionPos) >= 2, 'Wykres musi zawierać co najmniej 2 punkty');
  Assert(Length(ASeries.LoadPos) >= 2, 'Wykres musi zawierać co najmniej 2 punkty');
  Assert(Length(ASeries.Data) > 0, 'Wykres musi zawierać co najmniej 1 serię danych');

  // ustawiam wysokość kontrolki tak aby mogła pomieścić wszystkie wykresy i kasuję tło
  can := AControl.GetCanvas;
  AControl.Height := Length(ASeries.Data) * (DIAGRAM_HEIGHT + DIAGRAM_SPACING) + 2 * DIAGRAM_MARGINS - DIAGRAM_SPACING;
  ClearRect(can, AControl.ClientRect, clWindow);

  // obszar przeznaczony na pojedynczy wykres
  rct := Rect(DIAGRAM_LEFT_MARGIN, DIAGRAM_MARGINS, AControl.ClientWidth - DIAGRAM_MARGINS, DIAGRAM_HEIGHT + DIAGRAM_MARGINS);

  // rysuję wykresy
  for idx := 0 to High(ASeries.Data) do begin
    PrepareMap(MinValue(ASeries.LoadPos), MinValue(ASeries.Data[idx].LoadData), MaxValue(ASeries.LoadPos), MaxValue(ASeries.Data[idx].LoadData), rct);
    PrepareData(ASeries.SectionPos, ASeries.Data[idx].SectionData, sdata);
    PrepareData(ASeries.LoadPos, ASeries.Data[idx].LoadData, ldata);
    PaintDiagram(can, ASeries.Data[idx].Color, sdata, ldata);

    // dodaję opis
    DrawTextRotated(can, Rect(DIAGRAM_MARGINS, rct.Top, DIAGRAM_LEFT_MARGIN, rct.Bottom), 90, ASeries.Data[idx].Color, ASeries.Data[idx].Name);



    // przechodzę do następnego wykresu
    rct.Offset(0, DIAGRAM_HEIGHT + DIAGRAM_SPACING);
  end;

  // na koniec dodaję jeszcze linie reprezentujące granice przedziałów
  PaintDottedLines(can, ASeries.ZValues);
end;

{ TCustomControlHelper }

function TCustomControlHelper.GetCanvas: TCanvas;
begin
  Result := Self.Canvas;
end;

end.
