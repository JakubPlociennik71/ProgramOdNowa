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
  Windows, Math, GraphUtil, SysUtils, Classes, StrUtils;

type
  TAoP = array of TPoint;

  TCustomControlHelper = class helper for TGraphicControl
    function GetCanvas: TCanvas;
  end;

procedure SetupRotatedFonts(ACanvas: TCanvas; AAngle: Integer; AColor: TColor; ASize: Integer; AFontName: string = '');
var
  lf: LOGFONT;
begin
  FillChar(lf, SizeOf(lf), Byte(0));
//  lf.lfHeight := ASize; // ACanvas.Font.Height;
  lf.lfEscapement :=  10 * AAngle;
  lf.lfOrientation := 10 * AAngle;
  lf.lfCharSet := DEFAULT_CHARSET;
  lf.lfQuality := CLEARTYPE_NATURAL_QUALITY;
  StrCopy(lf.lfFaceName, PChar(ACanvas.Font.Name));
  if AFontName <> EmptyStr then StrCopy(lf.lfFaceName, PChar(AFontName));

  ACanvas.Font.Handle := CreateFontIndirect(lf);
  ACanvas.Font.Color := AColor;
  ACanvas.Font.Size := ASize;
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
  DIAGRAM_HEIGHT          = 100;
  DIAGRAM_SPACING         = 50;
  DIAGRAM_MARGINS         = 10;
  DIAGRAM_TOP_MARGIN      = 50;
  DIAGRAM_LEFT_MARGIN     = 50;
  DIAGRAM_RIGHT_MARGIN    = 40;
  DIAGRAM_NODE_SIZE       = 4;
  DIAGRAM_SUPPORT_SIZE    = 20;

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

  var
    prevnodepoint: TPoint;

  procedure PaintNode(ACanvas: TCanvas; APoint: TPoint; AColor, AFill: TColor; AText: string = '');
  var
    pt: TPoint;
    s: TSize;
  begin
    ACanvas.Pen.Width := 2;
    ACanvas.Pen.Color := AColor;
    ACanvas.Pen.Style := psSolid;
    ACanvas.Brush.Color := AFill;
    ACanvas.Brush.Style := bsSolid;

    // kreślenie punktu
    ACanvas.Ellipse(APoint.X - DIAGRAM_NODE_SIZE, APoint.Y - DIAGRAM_NODE_SIZE, APoint.X + DIAGRAM_NODE_SIZE, APoint.Y + DIAGRAM_NODE_SIZE);
    ACanvas.Brush.Style := bsClear;
    ACanvas.Ellipse(APoint.X - DIAGRAM_NODE_SIZE, APoint.Y - DIAGRAM_NODE_SIZE, APoint.X + DIAGRAM_NODE_SIZE, APoint.Y + DIAGRAM_NODE_SIZE);

    // i opisu
    if AText <> EmptyStr then begin
      s := ACanvas.TextExtent(AText);
      pt := Point(APoint.X + 5, APoint.Y - IfThen(APoint.Distance(prevnodepoint) > 3, s.cy));
//      pt := Point(APoint.X + IfThen(APoint.X - prevnodepoint.X > 3, -5 - s.cx, 5), APoint.Y - 5 - s.cy);
      ACanvas.TextOut(pt.X, pt.Y, AText);
    end;

    prevnodepoint := APoint;
  end;

  procedure PaintSupport(ACanvas: TCanvas; AColor: TColor; AZ: Double; ARadial: Boolean);
  var
    pts: array [0 .. 2] of TPoint;
    delta: Integer;
  begin
    delta := DIAGRAM_SUPPORT_SIZE div 4;
    pts[0] := Map(AZ, 0);
    pts[1] := Point(pts[0].X - System.Round(0.5 * DIAGRAM_SUPPORT_SIZE), pts[0].Y + System.Round(0.867 * DIAGRAM_SUPPORT_SIZE));
    pts[2] := Point(pts[1].X + DIAGRAM_SUPPORT_SIZE, pts[1].Y);

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
    pt, pt1: TPoint;
  begin
    pt := Map(AZ, 0);
    Inc(pt.Y, Sign(AY) * 25);

    // jeśli siła jest przyłożona poza wałem to rysuję punkt
    ACanvas.Pen.Width := 3;
    ACanvas.Pen.Color := AColor;
    ACanvas.Pen.Style := psSolid;
    ACanvas.Brush.Color := AColor;
    ACanvas.Brush.Style := bsSolid;
    if AY <> 0 then begin
      pt1 := Map(AZ, 0);
      ACanvas.MoveTo(pt1.X, pt1.Y);
      ACanvas.LineTo(pt.X, pt.Y);
      PaintNode(ACanvas, pt, clBlack, clWindow);
      ACanvas.Brush.Color := AColor;
    end;

    // oś pozioma
    if AFx > 0 then ACanvas.Polygon([Point(pt.X - 5, pt.Y), Point(pt.X - 14, pt.Y - 3), Point(pt.X - 14, pt.Y - 1), Point(pt.X - 25, pt.Y - 1), Point(pt.X - 25, pt.Y + 1), Point(pt.X - 14, pt.Y + 1), Point(pt.X - 14, pt.Y + 3)]);
    if AFx < 0 then ACanvas.Polygon([Point(pt.X + 5, pt.Y), Point(pt.X + 14, pt.Y - 3), Point(pt.X + 14, pt.Y - 1), Point(pt.X + 25, pt.Y - 1), Point(pt.X + 25, pt.Y + 1), Point(pt.X + 14, pt.Y + 1), Point(pt.X + 14, pt.Y + 3)]);

//    // oś pozioma
//    if AFx < 0 then ACanvas.Polygon([Point(pt.X - 5, pt.Y - 6), Point(pt.X - 14, pt.Y - 9), Point(pt.X - 14, pt.Y - 7), Point(pt.X - 25, pt.Y - 7), Point(pt.X - 25, pt.Y - 5), Point(pt.X - 14, pt.Y - 5), Point(pt.X - 14, pt.Y - 3)]);
//    if AFx > 0 then ACanvas.Polygon([Point(pt.X + 5, pt.Y - 6), Point(pt.X + 14, pt.Y - 9), Point(pt.X + 14, pt.Y - 7), Point(pt.X + 25, pt.Y - 7), Point(pt.X + 25, pt.Y - 5), Point(pt.X + 14, pt.Y - 5), Point(pt.X + 14, pt.Y - 3)]);

    // oś pionowa
    if AFy < 0 then ACanvas.Polygon([Point(pt.X, pt.Y - 5), Point(pt.X - 3, pt.Y - 14), Point(pt.X - 1, pt.Y - 14), Point(pt.X - 1, pt.Y - 25), Point(pt.X + 1, pt.Y - 25), Point(pt.X + 1, pt.Y - 14), Point(pt.X + 3, pt.Y - 14)]);
    if AFy > 0 then ACanvas.Polygon([Point(pt.X, pt.Y + 5), Point(pt.X - 3, pt.Y + 14), Point(pt.X - 1, pt.Y + 14), Point(pt.X - 1, pt.Y + 25), Point(pt.X + 1, pt.Y + 25), Point(pt.X + 1, pt.Y + 14), Point(pt.X + 3, pt.Y + 14)]);
  end;

  procedure PaintMoment(ACanvas: TCanvas; AColor: TColor; AZ: Double; AValue: Double);
  var
    pt: TPoint;
    pts: array [0 .. 7] of TPoint;
    s: Integer;
  begin
    if AValue = 0 then Exit;

    pt := Map(AZ, 0);
    s := IfThen(AValue > 0, 1, -1);

    pts[0] := pt;
    pts[1] := Point(pt.X - s * 10, pt.Y - 18);
    pts[2] := Point(pt.X - s * 3, pt.Y - 21);
    pts[3] := Point(pt.X + s * 3, pt.Y - 21);
    pts[4] := Point(pt.X + s * 10, pt.Y - 18);

    pts[5] := Point(pt.X + s * 5, pt.Y - 22);
    pts[6] := Point(pt.X + s * 12, pt.Y - 17);
    pts[7] := Point(pt.X + s * 3, pt.Y - 18);

    ACanvas.Pen.Width := 3;
    ACanvas.Pen.Color := AColor;
    ACanvas.Pen.Style := psSolid;

    ACanvas.Polyline(pts);
  end;

  procedure PaintTorque(ACanvas: TCanvas; AColor: TColor; AZ: Double; AValue: Double);
  var
    pt: TPoint;
    pts: array [0 .. 13] of TPoint;
    s: Integer;
  begin
    if AValue = 0 then Exit;

    pt := Map(AZ, 0);
    s := IfThen(AValue > 0, 1, -1);

    pts[0] := pt;
    pts[1] := Point(pt.X - s * 7, pt.Y + 13);
    pts[2] := Point(pt.X - s * 10, pt.Y);

    pts[3] := Point(pt.X - s * 8, pt.Y - 10);
    pts[4] := Point(pt.X - s * 6, pt.Y - 15);
    pts[5] := Point(pt.X - s * 2, pt.Y - 18);
    pts[6] := Point(pt.X + s * 2, pt.Y - 18);
    pts[7] := Point(pt.X + s * 6 , pt.Y - 15);
    pts[8] := Point(pt.X + s * 8, pt.Y - 10);

    pts[9] := Point(pt.X + s * 10, pt.Y);
    pts[10] := Point(pt.X + s * 7, pt.Y + 13);

    pts[11] := Point(pt.X + s * 6, pt.Y + 5);
    pts[12] := Point(pt.X + s * 7, pt.Y + 13);
    pts[13] := Point(pt.X + s * 12, pt.Y + 6);

    ACanvas.Pen.Width := 3;
    ACanvas.Pen.Color := AColor;
    ACanvas.Pen.Style := psSolid;

    ACanvas.Polyline(pts);
  end;

  procedure PaintLoads(ACanvas: TCanvas; AShaft: TShaft; AYZ: Boolean);
  var
    pt1, pt2: TPoint;
    load: TLoad;
  begin
    pt1 := Map(AShaft.MinZValue, 0);
    pt2 := Map(AShaft.MaxZValue, 0);

    ACanvas.Pen.Width := 1;
    ACanvas.Pen.Style := psSolid;
    ACanvas.Pen.Color := clBlack;
    ACanvas.Brush.Color := clBlack;
    ACanvas.Brush.Style := bsSolid;

    // rysowanie osi
    ACanvas.MoveTo(pt1.X - 10, pt1.Y);
    ACanvas.LineTo(pt2.X + 20, pt1.Y);
    ACanvas.MoveTo(pt1.X, pt1.Y - 50);
    ACanvas.LineTo(pt1.X, pt1.Y + 50);

    // groty i opisy
    ACanvas.Polygon([Point(pt2.X + 15, pt2.Y - 3), Point(pt2.X + 28, pt2.Y), Point(pt2.X + 15, pt2.Y + 3)]);
    ACanvas.Polygon([Point(pt1.X - 3, pt1.Y - 40), Point(pt1.X, pt1.Y - 53), Point(pt1.X + 3, pt1.Y - 40)]);

    // i opisy
    // konfiguracja fontów do opisu wykresu
    SetupRotatedFonts(ACanvas, 0, clBlack, 8);
    ACanvas.Brush.Style := bsClear;
    ACanvas.TextOut(pt2.X + 20, pt2.Y - 18, 'Z');
    ACanvas.TextOut(pt1.X - 15, pt1.Y - 55, IfThen(AYZ, 'Y', 'X'));

    // rysowanie belki
    ACanvas.Pen.Width := 3;
    ACanvas.MoveTo(pt1.X, pt1.Y);
    ACanvas.LineTo(pt2.X, pt2.Y);

    // rysowanie obciążeń
    for load in Shaft do
      if load is TForce then PaintForce(ACanvas, clBlack, load.Z, TForce(load).FZ, IfThen(AYZ, TForce(load).FY, TForce(load).FX), load.Y) else
      if load is TMoment then PaintMoment(ACanvas, clBlack, load.Z, IfThen(AYZ, TMoment(load).MomentY, TMoment(load).MomentX)) else
      if load is TTorque then PaintTorque(ACanvas, clBlack, load.Z, IfThen(AYZ, TTorque(load).Torque));

    // na koniec rysuję także podpory i reakcje w podporach
    PaintSupport(ACanvas, clBlack, Shaft.SupportA.Z, False);
    PaintSupport(ACanvas, clBlack, Shaft.SupportB.Z, True);

    PaintForce(ACanvas, clRed, AShaft.SupportA.Z, AShaft.SupportA.Force.Z, IfThen(AYZ, AShaft.SupportA.Force.Y, AShaft.SupportA.Force.X));
    PaintForce(ACanvas, clRed, AShaft.SupportB.Z, 0, IfThen(AYZ, AShaft.SupportB.Force.Y, AShaft.SupportB.Force.X));
  end;

  procedure PaintSections(ACanvas: TCanvas; AValues: TAoD);
  var
    value: Double;
    pt: TPoint;
  begin
    // ustawiam szarą linię punktową
    ACanvas.Pen.Width := 0;
    ACanvas.Pen.Color := clLtGray;
    ACanvas.Pen.Style := psDot;
    ACanvas.Brush.Style := bsClear;

    // i rysuję granice przedziałów
    for value in AValues do begin
      pt := Map(value, 0);
      ACanvas.MoveTo(pt.X, DIAGRAM_MARGINS);
      ACanvas.LineTo(pt.X, AControl.ClientHeight - DIAGRAM_MARGINS);
    end;
  end;

  procedure PaintName(ACanvas: TCanvas; ARect: TRect; AColor: TColor; AName: string);
  var
    s: TSize;
    rct: TRect;
  begin
    rct := Rect(5, ARect.Top, DIAGRAM_LEFT_MARGIN - 15, ARect.Bottom);
    ACanvas.Brush.Style := bsClear;
    SetupRotatedFonts(ACanvas, 90, AColor, 8);
    s := ACanvas.TextExtent(AName);
//    ACanvas.TextRect(rct, AName, [tfBottom, tfCenter, tfSingleLine]);
    ACanvas.TextOut(rct.Right - s.cy, rct.Bottom - (rct.Height - s.cx) div 2, AName);
  end;

  procedure PaintDiagram(ACanvas: TCanvas; AColor: TColor; AData, ANodes: TAoP; ALoads: TAoD);
  const
    LINE_WIDTH = 2;
  var
    pt: TPoint;
    idx: Integer;
    col: TColor;
  begin
    // konfiguracja fontów do opisu wykresu
    SetupRotatedFonts(ACanvas, 0, AColor, 8);

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
    for idx := 0 to High(ANodes) do begin
      pt := ANodes[idx];
      PaintNode(ACanvas, pt, ColorToRGB(AColor), clWindow, IntToStr(idx + 1));
    end;

    // oraz dodaję opis
    if ShowLoadValues then begin
      ACanvas.Brush.Color := col;
      ACanvas.Brush.Style := bsClear;
      ACanvas.Font.Color := clWindowText;

      SetupRotatedFonts(ACanvas, 60, clWindowText, 6);
      for idx := 0 to High(ANodes) do
        ACanvas.TextOut(ANodes[idx].X, ANodes[idx].Y - 5, Format('%.4g', [ALoads[idx]]));
    end;
  end;

var
  can: TCanvas;
  idx: Integer;
  rct: TRect;
  sdata, ldata: TAoP;
begin
  Assert(Length(ASeries.SectionPos) >= 2, 'Wykres musi zawierać co najmniej 2 punkty');
  Assert(Length(ASeries.LoadPos) >= 2, 'Wykres musi zawierać co najmniej 2 punkty');
  Assert(Length(ASeries.Data) > 0, 'Wykres musi zawierać co najmniej 1 serię danych');

  // ustawiam wysokość kontrolki tak aby mogła pomieścić wszystkie wykresy i kasuję tło
  can := AControl.GetCanvas;
  AControl.Height := (Length(ASeries.Data) + 2) * (DIAGRAM_HEIGHT + DIAGRAM_SPACING) + DIAGRAM_TOP_MARGIN + DIAGRAM_MARGINS - DIAGRAM_SPACING;
  ClearRect(can, AControl.ClientRect, clWindow);

  // obszar przeznaczony na pojedynczy wykres
  rct := Rect(DIAGRAM_LEFT_MARGIN, DIAGRAM_TOP_MARGIN, AControl.ClientWidth - DIAGRAM_RIGHT_MARGIN, DIAGRAM_HEIGHT + DIAGRAM_TOP_MARGIN);

  // dodaję linie reprezentujące granice przedziałów
  PaintSections(can, ASeries.ZValues);

  // schemat obciążeń w płaszczyznach YZ oraz XZ
  PrepareMap(Shaft.MinZValue, -1, Shaft.MaxZValue, 1, rct);
  PaintName(can, rct, clWindowText, 'YZ');
  PaintLoads(can, Shaft, True);
  rct.Offset(0, DIAGRAM_HEIGHT + DIAGRAM_SPACING);

  PrepareMap(Shaft.MinZValue, -1, Shaft.MaxZValue, 1, rct);
  PaintName(can, rct, clWindowText, 'XZ');
  PaintLoads(can, Shaft, False);
  rct.Offset(0, DIAGRAM_HEIGHT + DIAGRAM_SPACING);

  // rysuję wykresy
  rct.Height := DIAGRAM_HEIGHT;
  for idx := 0 to High(ASeries.Data) do begin
    PrepareMap(MinValue(ASeries.LoadPos), MinValue(ASeries.Data[idx].LoadData), MaxValue(ASeries.LoadPos), MaxValue(ASeries.Data[idx].LoadData), rct);

    // opis
    PaintName(can, rct, ASeries.Data[idx].Color, ASeries.Data[idx].Name);

    // wykres
    prevnodepoint := Point(-100, 0);
    PrepareData(ASeries.SectionPos, ASeries.Data[idx].SectionData, sdata);
    PrepareData(ASeries.LoadPos, ASeries.Data[idx].LoadData, ldata);
    PaintDiagram(can, ASeries.Data[idx].Color, sdata, ldata, ASeries.Data[idx].LoadData);

    // przechodzę do następnego wykresu
    rct.Offset(0, DIAGRAM_HEIGHT + DIAGRAM_SPACING);
  end;
end;

{ TCustomControlHelper }

function TCustomControlHelper.GetCanvas: TCanvas;
begin
  Result := Self.Canvas;
end;

end.
