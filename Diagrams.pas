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

var
  ShowLoadValues: Boolean = False;

implementation

uses
  Windows, Math, GraphUtil, SysUtils, Classes;

type
  TAoP = array of TPoint;

  TCustomControlHelper = class helper for TGraphicControl
    function GetCanvas: TCanvas;
  end;

procedure SetupRotatedFonts(ACanvas: TCanvas; AAngle: Integer; AFontName: string = '');
var
  lf: LOGFONT;
begin
  FillChar(lf, SizeOf(lf), Byte(0));
  lf.lfHeight := ACanvas.Font.Height;
  lf.lfEscapement :=  10 * AAngle;
  lf.lfOrientation := 10 * AAngle;
  lf.lfCharSet := DEFAULT_CHARSET;
  lf.lfQuality := CLEARTYPE_NATURAL_QUALITY;
  StrCopy(lf.lfFaceName, PChar(ACanvas.Font.Name));
  if AFontName <> EmptyStr then StrCopy(lf.lfFaceName, PChar(AFontName));

  ACanvas.Font.Handle := CreateFontIndirect(lf);
end;

//procedure DrawTextRotated(ACanvas: TCanvas; ARect: TRect; AAngle: Integer; AColor: TColor; AText: string);
//var
//  lf: LOGFONT; // Windows native font structure
//begin
////  ACanvas.Brush.Style := bsClear; // Set the brush style to transparent.
////  FillChar(lf, SizeOf(lf), Byte(0));
////  lf.lfHeight := ACanvas.Font.Height;
////  lf.lfEscapement :=  10 * AAngle; // Degrees to rotate
////  lf.lfOrientation := 10 * AAngle;
////  lf.lfCharSet := DEFAULT_CHARSET;
////  lf.lfQuality := ANTIALIASED_QUALITY;
////  StrCopy(lf.lfFaceName, PChar(ACanvas.Font.Name));
//
//
//  ACanvas.Font.Color := AColor;
////  ACanvas.TextOut(AX, AY, AText); // Output the rotated font.
//  ACanvas.TextRect(ARect, AText, [tfBottom, tfSingleLine]);
//end;

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
  DIAGRAM_HEIGHT          = 100;
  DIAGRAM_SPACING         = 100;
  DIAGRAM_MARGINS         = 10;
  DIAGRAM_TOP_MARGIN      = 50;
  DIAGRAM_LEFT_MARGIN     = 30;
  DIAGRAM_RIGHT_MARGIN    = 30;
  DIAGRAM_NODE_SIZE       = 4;

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

  procedure PaintNode(ACanvas: TCanvas; APoint: TPoint; AColor: TColor; AFill: TColor = clDefault);
  begin
    ACanvas.Pen.Width := 2;
    ACanvas.Pen.Color := AColor;
    ACanvas.Pen.Style := psSolid;
    ACanvas.Brush.Color := TColor(IfThen(AFill = clDefault, AColor, AFill));
    ACanvas.Brush.Style := bsSolid;

    ACanvas.Ellipse(APoint.X - DIAGRAM_NODE_SIZE, APoint.Y - DIAGRAM_NODE_SIZE, APoint.X + DIAGRAM_NODE_SIZE, APoint.Y + DIAGRAM_NODE_SIZE);

    ACanvas.Brush.Style := bsClear;
    ACanvas.Ellipse(APoint.X - DIAGRAM_NODE_SIZE, APoint.Y - DIAGRAM_NODE_SIZE, APoint.X + DIAGRAM_NODE_SIZE, APoint.Y + DIAGRAM_NODE_SIZE);
  end;

  procedure PaintSupport(ACanvas: TCanvas; AColor: TColor; AZ: Double; ARadial: Boolean);
  const
    SUPPORT_SIZE    = 8 * 2;
  var
    pts: array [0 .. 2] of TPoint;
    delta: Integer;
  begin
    delta := SUPPORT_SIZE div 4;
    pts[0] := Map(AZ, 0);
    pts[1] := Point(pts[0].X - System.Round(0.5 * SUPPORT_SIZE), pts[0].Y + System.Round(0.867 * SUPPORT_SIZE));
    pts[2] := Point(pts[1].X + SUPPORT_SIZE, pts[1].Y);

    ACanvas.Pen.Color := AColor;
    ACanvas.Pen.Width := 2;
    ACanvas.Brush.Color := clWhite;
    ACanvas.Brush.Style := bsSolid;

    ACanvas.Polygon(pts);
    ACanvas.Polyline([Point(pts[1].X - delta, pts[1].Y), Point(pts[2].X + delta, pts[2].Y)]);
    if ARadial then
      ACanvas.Polyline([Point(pts[1].X - delta, pts[1].Y + delta), Point(pts[2].X + delta, pts[2].Y + delta)]);
  end;

  procedure PaintForce(ACanvas: TCanvas; AColor: TColor; AZ: Double; AFx, AFy: Double; AY: Double = 0);
  var
    pt: TPoint;
  begin
    pt := Map(AZ, 0);
    Inc(pt.Y, Sign(AY) * 25);

    // jeśli siła jest przyłożona poza wałem to rysuję punkt
    if AY <> 0 then PaintNode(ACanvas, pt, clBlack, clWindow);

    ACanvas.Pen.Width := 3;
    ACanvas.Pen.Color := AColor;
    ACanvas.Pen.Style := psSolid;
    ACanvas.Brush.Color := AColor;
    ACanvas.Brush.Style := bsSolid;

    // oś pozioma
    if AFx < 0 then ACanvas.Polygon([Point(pt.X - 5, pt.Y), Point(pt.X - 14, pt.Y - 3), Point(pt.X - 14, pt.Y - 1), Point(pt.X - 25, pt.Y - 1), Point(pt.X - 25, pt.Y + 1), Point(pt.X - 14, pt.Y + 1), Point(pt.X - 14, pt.Y + 3)]);
    if AFx > 0 then ACanvas.Polygon([Point(pt.X + 5, pt.Y), Point(pt.X + 14, pt.Y - 3), Point(pt.X + 14, pt.Y - 1), Point(pt.X + 25, pt.Y - 1), Point(pt.X + 25, pt.Y + 1), Point(pt.X + 14, pt.Y + 1), Point(pt.X + 14, pt.Y + 3)]);

//    // oś pozioma
//    if AFx < 0 then ACanvas.Polygon([Point(pt.X - 5, pt.Y - 6), Point(pt.X - 14, pt.Y - 9), Point(pt.X - 14, pt.Y - 7), Point(pt.X - 25, pt.Y - 7), Point(pt.X - 25, pt.Y - 5), Point(pt.X - 14, pt.Y - 5), Point(pt.X - 14, pt.Y - 3)]);
//    if AFx > 0 then ACanvas.Polygon([Point(pt.X + 5, pt.Y - 6), Point(pt.X + 14, pt.Y - 9), Point(pt.X + 14, pt.Y - 7), Point(pt.X + 25, pt.Y - 7), Point(pt.X + 25, pt.Y - 5), Point(pt.X + 14, pt.Y - 5), Point(pt.X + 14, pt.Y - 3)]);

    // oś pionowa
    if AFy < 0 then ACanvas.Polygon([Point(pt.X, pt.Y - 5), Point(pt.X - 3, pt.Y - 14), Point(pt.X - 1, pt.Y - 14), Point(pt.X - 1, pt.Y - 25), Point(pt.X + 1, pt.Y - 25), Point(pt.X + 1, pt.Y - 14), Point(pt.X + 3, pt.Y - 14)]);
    if AFy > 0 then ACanvas.Polygon([Point(pt.X, pt.Y + 5), Point(pt.X - 3, pt.Y + 14), Point(pt.X - 1, pt.Y + 14), Point(pt.X - 1, pt.Y + 25), Point(pt.X + 1, pt.Y + 25), Point(pt.X + 1, pt.Y + 14), Point(pt.X + 3, pt.Y + 14)]);
  end;

  procedure PaintDiagram(ACanvas: TCanvas; AColor: TColor; AData, ANodes: TAoP; ALoads: TAoD);
  const
    LINE_WIDTH = 2;
  var
    pt: TPoint;
    idx: Integer;
    col: TColor;
  begin
    // wypełniam tło wykresu
    col := ColorBlendRGB(AColor, clWindow, 0.95);
    ACanvas.Pen.Style := psSolid;
    ACanvas.Pen.Color := ColorToRGB(AColor);
    ACanvas.Pen.Width := 2;
    ACanvas.Brush.Color := col;
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

    {$ ENDREGION}
    {$ENDREGION}

    // rysuję punkty charakterystyczne wykresu
    for pt in ANodes do
      PaintNode(ACanvas, pt, ColorToRGB(AColor));

    // oraz dodaję opis
    if ShowLoadValues then begin
      ACanvas.Brush.Color := col;
      ACanvas.Brush.Style := bsClear;
      ACanvas.Font.Color := clWindowText;
      ACanvas.Font.Size := 6;

      SetupRotatedFonts(ACanvas, 60);
      for idx := 0 to High(ANodes) do
        ACanvas.TextOut(ANodes[idx].X, ANodes[idx].Y - 5, Format('%.4g', [ALoads[idx]]));
    end;

    // ToDo: Usunąć po testach
    PaintSupport(ACanvas, clBlack, Shaft.SupportA.Z, False);
    PaintSupport(ACanvas, clBlack, Shaft.SupportB.Z, True);
    PaintForce(ACanvas, clBlack, Shaft[0].Z, 100, 50, 100);
    PaintForce(ACanvas, clBlack, Shaft[1].Z, -100, -50, -100);
  end;

  procedure PaintDottedLines(ACanvas: TCanvas; AValues: TAoD);
  var
    value: Double;
    pt: TPoint;
  begin
    // ustawiam szarą linię punktową
    ACanvas.Pen.Width := 0;
    ACanvas.Pen.Color := clGray;
    ACanvas.Pen.Style := psDot;
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
  rct, r: TRect;
  sdata, ldata: TAoP;
begin
  Assert(Length(ASeries.SectionPos) >= 2, 'Wykres musi zawierać co najmniej 2 punkty');
  Assert(Length(ASeries.LoadPos) >= 2, 'Wykres musi zawierać co najmniej 2 punkty');
  Assert(Length(ASeries.Data) > 0, 'Wykres musi zawierać co najmniej 1 serię danych');

  // ustawiam wysokość kontrolki tak aby mogła pomieścić wszystkie wykresy i kasuję tło
  can := AControl.GetCanvas;
  AControl.Height := Length(ASeries.Data) * (DIAGRAM_HEIGHT + DIAGRAM_SPACING) + DIAGRAM_TOP_MARGIN + DIAGRAM_MARGINS - DIAGRAM_SPACING;
  ClearRect(can, AControl.ClientRect, clWindow);

  // obszar przeznaczony na pojedynczy wykres
  rct := Rect(DIAGRAM_LEFT_MARGIN, DIAGRAM_TOP_MARGIN, AControl.ClientWidth - DIAGRAM_RIGHT_MARGIN, DIAGRAM_HEIGHT + DIAGRAM_TOP_MARGIN);

  // rysuję wykresy
  for idx := 0 to High(ASeries.Data) do begin
    PrepareMap(MinValue(ASeries.LoadPos), MinValue(ASeries.Data[idx].LoadData), MaxValue(ASeries.LoadPos), MaxValue(ASeries.Data[idx].LoadData), rct);
    PrepareData(ASeries.SectionPos, ASeries.Data[idx].SectionData, sdata);
    PrepareData(ASeries.LoadPos, ASeries.Data[idx].LoadData, ldata);
    PaintDiagram(can, ASeries.Data[idx].Color, sdata, ldata, ASeries.Data[idx].LoadData);

    // dodaję opis
    r := Rect(5, rct.Top, DIAGRAM_LEFT_MARGIN - 5, rct.Bottom);
    can.Brush.Style := bsClear;
    can.Font.Color := ASeries.Data[idx].Color;
    can.Font.Size := 8;
    SetupRotatedFonts(can, 90);
    can.TextRect(r, ASeries.Data[idx].Name, [tfBottom, tfSingleLine]);

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
