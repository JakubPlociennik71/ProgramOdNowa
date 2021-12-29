unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.StdActns, Vcl.Menus, System.Actions, Vcl.ActnList, Vcl.ToolWin,
  System.ImageList, Vcl.ImgList, Vcl.ExtActns, Loads, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    tvTree: TTreeView;
    mmMenu: TMainMenu;
    alActions: TActionList;
    ilImages: TImageList;
    actSaveRaport: TFileSaveAs;
    pmPopup: TPopupMenu;
    actSila: TAction;
    actSilaPozaWalem: TAction;
    actMoment: TAction;
    actTorque: TAction;
    actPrzesuwna: TAction;
    actStala: TAction;
    SiaPozaWaem1: TMenuItem;
    Momentgncy1: TMenuItem;
    Momentskrcajcy1: TMenuItem;
    Zmianapooeniapodporyprzesuwnej1: TMenuItem;
    Zmianapooeniapodprystaej1: TMenuItem;
    ScrollBox1: TScrollBox;
    pbDiagrams: TPaintBox;
    splLeft: TSplitter;
    splRight: TSplitter;
    pnlLeft: TPanel;
    actSilaEdit: TAction;
    Zamianapodpr1: TMenuItem;
    actWyniki: TAction;
    actUsunWszystko: TAction;
    miUsunWszystko: TMenuItem;
    actUsunObc: TAction;
    miUsunObc: TMenuItem;
    actMomentEdit: TAction;
    actTorqueEdit: TAction;
    actSilaPozaWalemEdit: TAction;
    miSaveRaport: TMenuItem;
    actNaprezenia: TAction;
    actWspRed: TAction;
    mmRaport: TMemo;
    actRodzajNapr: TAction;
    procedure FormCreate(Sender: TObject);
    procedure actSilaExecute(Sender: TObject);
    procedure actSilaPozaWalemExecute(Sender: TObject);
    procedure actMomentExecute(Sender: TObject);
    procedure actTorqueExecute(Sender: TObject);
    procedure actPrzesuwnaExecute(Sender: TObject);
    procedure actStalaExecute(Sender: TObject);
    procedure pbDiagramsPaint(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure tvTreeDblClick(Sender: TObject);
    procedure actSilaEditExecute(Sender: TObject);
    procedure Zamianapodpr1Click(Sender: TObject);
    procedure actWynikiExecute(Sender: TObject);
    procedure actUsunObcExecute(Sender: TObject);
    procedure actMomentEditExecute(Sender: TObject);
    procedure actTorqueEditExecute(Sender: TObject);
    procedure actSilaPozaWalemEditExecute(Sender: TObject);
    procedure alActionsUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure actNaprezeniaExecute(Sender: TObject);
    procedure actWspRedExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actSaveRaportAccept(Sender: TObject);
    procedure actRodzajNaprExecute(Sender: TObject);
    procedure actUsunWszystkoExecute(Sender: TObject);
    procedure tvTreeCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
      State: TCustomDrawState; var DefaultDraw: Boolean);
  private
    function Equivalent(AZ: Double): Double;
    function Diameter(AZ: Double): Double;

    procedure PaintDiagrams;
    procedure OnChange(ASender: TObject);
    procedure Raport;

    procedure UpdateTreeData;
  public
    reduction: double;
    naprezeniaG, naprezeniaS: double;
    normalne: boolean;

    // obsługa drzewka
    fPodpory, fPodporaA, fPodporaB: TTreeNode;
    fObciazenia: TTreeNode;
    fMaterial,fNaprezeniaG,fNaprezeniaS,fPrzewObc,fWspRed: TTreeNode;
    fRaport: TStringList;
    fPrzewazajace: string;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses UITypes, Math, StrUtils, Diagrams, Unit2, Unit3, Unit4, Unit5, Unit6, Unit10, Unit11, Unit13;

procedure TForm1.actMomentEditExecute(Sender: TObject);
var
  m: TMoment;
  mx, my, z: Double;
begin
  m := (TObject(tvTree.Selected.Data) as TMoment);

  Form4.Init(m);
  if Form4.ShowModal <> mrOK then Exit;

  // konwertuję dane tekstowe na liczbowe
  mx := StrToFloat(Form4.edtMomentX.Text);
  my := StrToFloat(Form4.edtMomentY.Text);
  z := StrToFloat(Form4.edtZ.Text);

  // aktualizuję wartość oraz położenie siły
  m.MomentX:=mx;
  m.MomentY:=my;
  m.Z := z;
end;

procedure TForm1.actMomentExecute(Sender: TObject);
var
  m: TMoment;
begin
  Form4.Init;

  if Form4.ShowModal <> mrOK then Exit;

  // tworzę moment na podstawie danych z okienka
  m := Shaft.AddMoment(StrToFloat(Form4.edtMomentX.Text), StrToFloat(Form4.edtMomentY.Text), StrToFloat(Form4.edtZ.Text));

  // jeśli udało się utworzyć siłę to dodaję odpowiedni węzeł do drzewka i aktualizuję dane
  tvTree.Selected := tvTree.Items.AddChildObject(fObciazenia, EmptyStr, m);
  UpdateTreeData;
end;

procedure TForm1.actNaprezeniaExecute(Sender: TObject);
begin
  Form11.Init(naprezeniaG,naprezeniaS);

  if Form11.ShowModal <> mrOK then Exit;

  if (StrToFloat(Form11.edtKg.Text) > 0) and (StrToFloat(Form11.edtKs.Text) > 0) then begin
    naprezeniaG:=StrToFloat(Form11.edtKg.Text);
    naprezeniaS:=StrToFloat(Form11.edtKs.Text);
    UpdateTreeData;
  end else
    ShowMessage('Wpisano wartość mniejszą od 0');
end;

procedure TForm1.actPrzesuwnaExecute(Sender: TObject);
begin
  Form6.edtZ.Text := FloatToStr(Shaft.SupportB.Z);

  if Form6.ShowModal <> mrOK then Exit;

  Shaft.SupportB.Z := StrToFloat(Form6.edtZ.Text);
end;

procedure TForm1.actRodzajNaprExecute(Sender: TObject);
begin
  Form13.init(normalne);

  if Form13.ShowModal <> mrOK then Exit;

   if Form13.rbGnace.Checked then begin
    normalne := True;
    fPrzewazajace := 'Gnące';
  end else begin
    normalne := false;
    fPrzewazajace := 'Skręcające';
  end;

  UpdateTreeData;
end;

procedure TForm1.actSaveRaportAccept(Sender: TObject);
begin
  Raport;
  fRaport.SaveToFile(actSaveRaport.Dialog.FileName);
end;

procedure TForm1.actSilaEditExecute(Sender: TObject);
// edycja zaznaczonej sily
var
  f: TForce;
  fx, fy, fz, z: Double;
begin
  // odczytuję zaznaczoną siłę
  f := (TObject(tvTree.Selected.Data) as TForce);

  // inicjalizuję dane zgodnie z zaznaczoną siłą, oraz otwieram okienko
  Form2.Init(f);
  if Form2.ShowModal <> mrOK then Exit;

  // konwertuję dane tekstowe na liczbowe
  fx := StrToFloat(Form2.edtFx.Text);
  fy := StrToFloat(Form2.edtFy.Text);
  fz := StrToFloat(Form2.edtFz.Text);
  z := StrToFloat(Form2.edtZ.Text);

  // aktualizuję wartość oraz położenie siły
  f.Force := P3D(fx, fy, fz);
  f.Z := z;
end;

procedure TForm1.actSilaExecute(Sender: TObject);
var
  f: TForce;
begin
  Form2.Init;

  if Form2.ShowModal <> mrOK then Exit;

  // tworzę siłę na podstawie danych z okienka
  f := Shaft.AddForce(P3D(StrToFloat(Form2.edtFx.Text), StrToFloat(Form2.edtFy.Text), StrToFloat(Form2.edtFz.Text)), StrToFloat(Form2.edtZ.Text));

  // jeśli udało się utworzyć siłę to dodaję odpowiedni węzeł do drzewka i aktualizuję dane
  tvTree.Selected := tvTree.Items.AddChildObject(fObciazenia, EmptyStr, f);
  UpdateTreeData;
end;

procedure TForm1.actSilaPozaWalemEditExecute(Sender: TObject);
var
  f: TForce;
  fx, fy, fz,x,y, z: Double;
begin
  // odczytuję zaznaczoną siłę
  f := (TObject(tvTree.Selected.Data) as TForce);

  // inicjalizuję dane zgodnie z zaznaczoną siłą, oraz otwieram okienko
  Form3.Init(f);
  if Form3.ShowModal <> mrOK then Exit;

  // konwertuję dane tekstowe na liczbowe
  fx := StrToFloat(Form3.edtFx.Text);
  fy := StrToFloat(Form3.edtFy.Text);
  fz := StrToFloat(Form3.edtFz.Text);
  x := StrToFloat(Form3.edtX.Text);
  y := StrToFloat(Form3.edtY.Text);
  z := StrToFloat(Form3.edtZ.Text);

  // aktualizuję wartość oraz położenie siły
  f.Force := P3D(fx, fy, fz);
  f.Z := z;
  f.X := x;
  f.Y := y;
end;

procedure TForm1.actSilaPozaWalemExecute(Sender: TObject);
var
  f: TForce;
begin
  Form3.Init;

  if Form3.ShowModal <> mrOK then Exit;

  // tworzę siłę na podstawie danych z okienka
  f := Shaft.AddForce(P3D(StrToFloat(Form3.edtFx.Text), StrToFloat(Form3.edtFy.Text), StrToFloat(Form3.edtFz.Text)),P3D(StrToFloat(Form3.edtx.Text), StrToFloat(Form3.edty.Text), StrToFloat(Form3.edtz.Text)));

  // jeśli udało się utworzyć siłę to dodaję odpowiedni węzeł do drzewka i aktualizuję dane
  tvTree.Selected := tvTree.Items.AddChildObject(fObciazenia, EmptyStr, f);
  UpdateTreeData;
end;

procedure TForm1.actStalaExecute(Sender: TObject);
begin
  Form6.edtZ.Text := FloatToStr(Shaft.SupportA.Z);

  if Form6.ShowModal <> mrOK then Exit;

  Shaft.SupportA.Z := StrToFloat(Form6.edtZ.Text);
end;

procedure TForm1.actTorqueEditExecute(Sender: TObject);
var
  t: TTorque;
  tx,z: Double;
begin
  t := (TObject(tvTree.Selected.Data) as TTorque);

  Form5.Init(t);
  if Form5.ShowModal <> mrOK then Exit;

  // konwertuję dane tekstowe na liczbowe
  tx := StrToFloat(Form5.edtTorque.Text);
  z := StrToFloat(Form5.edtZ.Text);

  // aktualizuję wartość oraz położenie siły
  t.Torque:=tx;
  t.Z := z;
end;

procedure TForm1.actTorqueExecute(Sender: TObject);
var
  t: TTorque;
begin
  Form5.Init;

  if Form5.ShowModal <> mrOK then Exit;

  // tworzę siłę na podstawie danych z okienka
  t := Shaft.AddTorque(StrToFloat(Form5.edtTorque.Text), StrToFloat(Form5.edtZ.Text));

  // jeśli udało się utworzyć siłę to dodaję odpowiedni węzeł do drzewka i aktualizuję dane
  tvTree.Selected := tvTree.Items.AddChildObject(fObciazenia, EmptyStr, t);
  UpdateTreeData;
end;

procedure TForm1.actWspRedExecute(Sender: TObject);
begin
  Form10.Init(reduction);

  if Form10.ShowModal <> mrOK then Exit;

  reduction := IfThen(Form10.rbDwukierunkowy.Checked, sqrt(3) / 2, sqrt(3) / 4);
  UpdateTreeData;
end;

procedure TForm1.actWynikiExecute(Sender: TObject);
begin
  Raport;
  mmRaport.Lines.Assign(fRaport);
end;

procedure TForm1.actUsunObcExecute(Sender: TObject);
begin
  Shaft.DeleteLoad(TObject(TVTree.Selected.Data) as TLoad) ;
  tvTree.Selected.Delete;
end;

procedure TForm1.actUsunWszystkoExecute(Sender: TObject);
begin
  Shaft.Clear;
  fObciazenia.DeleteChildren;
  UpdateTreeData;
end;

procedure TForm1.alActionsUpdate(Action: TBasicAction; var Handled: Boolean);
var
  load: TLoad;
begin
  load := nil;

  if Assigned(TVTree.Selected) then load := TObject(TVTree.Selected.Data) as TLoad;
  actusunObc.Enabled := Assigned(load) and ((load is TForce) or (load is TMoment) or (load is TTorque));

  actUsunWszystko.Enabled := Shaft.Count > 0;
  actSaveRaport.Enabled := fRaport.Count > 0;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Shaft.Clear;
end;

function TForm1.Equivalent(AZ: Double): Double;
var
  m, t: Double;
begin
  if not InRange(AZ, Shaft.MinZValue, Shaft.MaxZValue) then Exit(0);

  m := Shaft.Moment(AZ);
  t := Shaft.Torque(AZ);

  if normalne then
    Result := Sqrt(Sqr(m) + Sqr(t * reduction))
  else
    Result := Sqrt(Sqr(m / reduction) + Sqr(t));
end;

function TForm1.Diameter(AZ: Double): Double;
begin
  if not InRange(Az, Shaft.MinZValue, Shaft.MaxZValue) then Exit(0);

  if normalne then
    Result := Power((32 * Equivalent(AZ)) / (Pi * naprezeniaG), 1/3)
  else
    Result := Power((16 * Equivalent(AZ)) / (Pi * naprezeniaS), 1/3);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  fRaport:=TStringList.Create;

  normalne := True;
  fPrzewazajace := 'Gnące';
  naprezeniaG := 62.5;
  naprezeniaS := 62.5;
  reduction := Sqrt(3) / 2;

  // tworzenie i konfiguracja drzewka
  fMaterial:= tvTree.Items.AddChild(nil, 'Dane materiałowe');
  fPodpory := tvTree.Items.AddChild(nil, 'Podpory');
  fObciazenia := tvTree.Items.AddChild(nil, 'Obciążenia');

  fNaprezeniaG:=tvTree.Items.AddChild(fMaterial, 'Naprężenia dopuszczalne na zginanie kg [MPa]');
  fNaprezeniaS:=tvTree.Items.AddChild(fMaterial, 'Naprężenia dopuszczalne na skręcanie ks [MPa]');
  fWspRed :=tvTree.Items.AddChild(fMaterial, 'Współczynnik redukcyjny');
  fPrzewObc :=tvTree.Items.AddChild(fMaterial, 'Przeważające naprężenia');

  fPodporaA := tvTree.Items.AddChild(fPodpory, 'Stała');    // podpora A
  fPodporaB := tvTree.Items.AddChild(fPodpory, 'Ruchoma');  // podpora B

  UpdateTreeData;
  TvTree.FullExpand;

  // przypisanie procedury obsługiwanej po zmianie danych wałka
  Shaft.OnChange := OnChange;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  fRaport.Free;
end;

procedure TForm1.OnChange(ASender: TObject);
begin
  PaintDiagrams;
  UpdateTreeData;
end;

procedure TForm1.PaintDiagrams;
const
  SECTION_COUNT = 256;

  procedure AddSeries(var ASeries: TSeries; AName: string; AColor: TColor; ACalculator: TDataCalculator);
  begin
    SetLength(ASeries.Data, Length(ASeries.Data) + 1);
    ASeries.Data[High(ASeries.Data)].Name := AName;
    ASeries.Data[High(ASeries.Data)].Color := AColor;
    ASeries.Data[High(ASeries.Data)].SectionData := PrepareData(ASeries.SectionPos, ACalculator);
    ASeries.Data[High(ASeries.Data)].LoadData := PrepareData(ASeries.LoadPos, ACalculator);
  end;

var
  series: TSeries;
begin
  // przygotowanie danych dla wykresóω
  SetLength(series.Data, 0);
  series.ZValues := Shaft.ZPositions;
  series.SectionPos := PrepareZValues(series.ZValues, SECTION_COUNT);
  series.LoadPos := PrepareZValues(series.ZValues);

  // serie danych
  AddSeries(series, 'F [N]', clBlue, Shaft.Axial);

  if Shaft.Config in [lcCoplanarY, lcSpatial] then AddSeries(series, 'Ty [N]', clGreen, Shaft.ShearY);
  if Shaft.Config in [lcCoplanarX, lcSpatial] then AddSeries(series, 'Tx [N]', clGreen, Shaft.ShearX);
  if Shaft.Config in [lcSpatial] then AddSeries(series, 'T [N]', clGreen, Shaft.Shear);

  if Shaft.Config in [lcCoplanarY, lcSpatial] then AddSeries(series, 'Mgy [Nm]', clRed, Shaft.MomentY);
  if Shaft.Config in [lcCoplanarX, lcSpatial] then AddSeries(series, 'Mgx [Nm]', clRed, Shaft.MomentX);
  if Shaft.Config in [lcSpatial] then AddSeries(series, 'Mg [Nm]', clRed, Shaft.Moment);

  AddSeries(series, 'Ms [Nm]', clRed, Shaft.Torque);

  AddSeries(series, 'Mz [Nm]', clNavy, Equivalent);
  AddSeries(series, 'd [mm]', clMaroon, Diameter);

  // rysowanie
  Diagrams.PaintDiagrams(pbDiagrams, series);
end;

procedure TForm1.pbDiagramsPaint(Sender: TObject);
begin
  PaintDiagrams;
end;

procedure TForm1.Raport;
const
  SECTION_COUNT = 25;
var
  fa, fb: TReaction;
  z, m, krok, p: Double;
  load: TLoad;
  points: TAoD;
  section, idx: Integer;
  today: TDateTime;

  procedure AddValues(AFormat: string; AZ, ALeft, ARight: Double);
  begin
    if not SameValue(ALeft, ARight) then fRaport.Add(Format(AFormat,[AZ, ALeft]));
    fRaport.Add(Format(AFormat,[AZ, ARight]));
  end;

begin
  fRaport.Clear;

  // Jeśli nie ma obciążeń to nie ma po co generować raportu
  if Shaft.Count = 0 then Exit;


  //Aktualna data
  today := Now;
  fRaport.Add('Raport wygenerowano dnia  '+DateToStr(today));
  fRaport.Add('O godzinie  '+TimeToStr(today));
  fRaport.Add('');
  // Dane materiałowe
  fRaport.Add('1. Dane materiałowe');
  fRaport.Add(Format('  Dopuszczalne naprężenia na zginanie kg [MPa]: %.1f',[naprezeniaG]));
  fRaport.Add(Format('  Dopuszczalne naprężenia na skręcanie ks [MPa]: %.1f',[naprezeniaS]));
  fRaport.Add('');

  // Obciązenia
  fRaport.Add('2. Obciążenia');
  for load in  Shaft do begin
    if load is TForce then fRaport.Add(Format('  Siła [kN]: (%.3f; %.3f; %.3f); Położenie [m]: (%.3f; %.3f; %.3f)',
      [TForce(Load).Fx,TForce(Load).Fy,TForce(Load).Fz,TForce(Load).X,TForce(Load).Y,TForce(Load).Z]));

    if load is TMoment then fRaport.Add(Format('  Moment gnący [Nm]: (%.3f; %.3f); Położenie Z [m]: %.3f',
      [TMoment(Load).MomentX,TMoment(Load).MomentY,TMoment(Load).Z]));

    if load is TTorque then fRaport.Add(Format('  Moment skręcający [Nm]: %.3f); Położenie Z [m]: %.3f',
      [TTorque(Load).Torque,TTorque(Load).Z]));
  end;
  fRaport.Add('');

  // Reakcje
  fa := Shaft.SupportA;
  fb := Shaft.SupportB;
  fRaport.Add('3. Reakcje');
  fRaport.Add(Format('  Podpora stała Ra [kN]: (%.2f; %.2f; %.2f); Położenie Z [m]: %.3f', [fa.Fx, fa.Fy, fa.Fz, fa.Z]));
  fRaport.Add(Format('  Podpora ruchoma Rb [kN]: (%.2f; %.2f); Położenie Z [m]: %.3f', [fb.Fx, fb.Fy, fb.Z]));
  fRaport.Add('');

  // Obliczenia w przekrojach charakterystycznych
  points := Shaft.ZPositions;
  section := 1;
  fRaport.Add('4. Obliczenia w przekrojach charakterystycznych');
  fRaport.Add(' 4.1 Siły tnące (siła F w [kN], odległość Z w [m])');
  if Shaft.Config in [lcCoplanarX, lcSpatial] then begin
    fRaport.Add(Format('  4.1.%d Płaszczyzna XZ', [section]));
    for z in points do AddValues('    Z: %.3f; F: %.3f', z, Shaft.ShearX(z - EPSILON), Shaft.ShearX(z));
    fRaport.Add('');
    Inc(section);
  end;

  if Shaft.Config in [lcCoplanarY, lcSpatial] then begin
    fRaport.Add(Format('  4.1.%d Płaszczyzna YZ', [section]));
    for z in points do AddValues('    Z: %.3f; F: %.3f', z, Shaft.ShearY(z - EPSILON), Shaft.ShearY(z));
    fRaport.Add('');
    Inc(section);
  end;

  if Shaft.Config in [lcSpatial] then begin
    fRaport.Add(Format('  4.1.%d Wypadkowa', [section]));
    for z in points do AddValues('    Z: %.3f; F: %.3f', z, Shaft.Shear(z - EPSILON), Shaft.Shear(z));
    fRaport.Add('');
  end;

  // momenty gnące
  section := 1;
  fRaport.Add(' 4.2 Momenty gnące (momenty Mg w [Nm], odległość Z w [m])');
  if Shaft.Config in [lcCoplanarX, lcSpatial] then begin
    fRaport.Add(Format('  4.2.%d Płaszczyzna XZ', [section]));
    for z in points do AddValues('    Z: %.3f; Mg: %.2f', z, Shaft.MomentX(z - EPSILON) * 1000, Shaft.MomentX(z) * 1000);
    fRaport.Add('');
    Inc(section);
  end;

  if Shaft.Config in [lcCoplanarY, lcSpatial] then begin
    fRaport.Add(Format('  4.2.%d Płaszczyzna YZ', [section]));
    for z in points do AddValues('    Z: %.3f; Mg: %.2f', z, Shaft.MomentY(z - EPSILON) * 1000, Shaft.MomentY(z) * 1000);
    fRaport.Add('');
    Inc(section);
  end;

  if Shaft.Config in [lcSpatial] then begin
    fRaport.Add(Format('4.2.%d Wypadkowy', [section]));
    for z in points do AddValues('    Z: %.3f; Mg: %.2f', z, Shaft.Moment(z - EPSILON) * 1000, Shaft.Moment(z) * 1000);
    fRaport.Add('');
  end;

  fRaport.Add('4.3 Momenty skręcające (momenty Ms w [Nm], odległość Z w [m])');
  for z in points do AddValues('    Z: %.3f; Ms: %.2f', z, Shaft.Torque(z - EPSILON) * 1000, Shaft.Torque(z) * 1000);
  fRaport.Add('');

  fRaport.Add('4.4. Moment zredukowany (moment Mz w [Nm], odległość Z w [m])');

  fRaport.Add(Format('    Przeważające naprężenia dla obliczeń: %.s', [fPrzewazajace]));
  fRaport.Add(Format('    Współczynnik redukcyjny: (%.2f', [reduction]));

  for z in points do AddValues('    Z: %.3f; F: %.2f', z, Equivalent(z - EPSILON) * 1000, Equivalent(z) * 1000);
  fRaport.Add('');

  fRaport.Add('4.5 Średnica teoretyczna (średnica D w [mm], odległość Z w [m])');
  for z in points do AddValues('    Z: %.3f; F: %.2f', z, Diameter(z - EPSILON) * 100, Diameter(z) * 100);
  fRaport.Add('');

  // Zarys teoretyczny wałka
  idx := 0;
  m := MaxValue(points);
  z := MinValue(points);
  krok := (m - z) / SECTION_COUNT;
  fRaport.Add('5. Zarys teoretyczny wałka (średnica D w [mm], odległość Z w [m])');
  while CompareValue(z, m) <= 0 do begin
    // obsługa granic przedziałów
    if CompareValue(z, points[idx] - EPSILON) >= 0 then begin
      // obsługa punktów charakterystycznych o wartości Z mniejszej niż aktualna pozycja
      p := points[idx];
      while (idx < Length(points)) and (CompareValue(z, points[idx]) >= 0) do begin
        p := points[idx];
        AddValues('    Z: %.3f; D: %.2f', p, Diameter(p - EPSILON) * 100, Diameter(p) * 100);
        Inc(idx);
      end;

      // na koniec dodawany jest wpis akualnej pozycji
      if (CompareValue(z, p) > 0) then
        fRaport.Add(Format('    Z: %.3f; D: %.2f',[z, Diameter(z) * 100]));
    end else
      fRaport.Add(Format('    Z: %.3f; D: %.2f',[z, Diameter(z) * 100]));

    // przejście do następnego przekroju
    z := z + krok;
  end;
end;

procedure TForm1.tvTreeCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
  State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if not Assigned(Node.Parent) then
    Sender.Canvas.Font.Style := [fsBold]
  else
    Sender.Canvas.Font.Style := [];
end;

procedure TForm1.tvTreeDblClick(Sender: TObject);
var
  sel: TTreeNode;
begin
  sel := (Sender as TTreeView).Selected;

  if sel = fNaprezeniaG then actNaprezenia.Execute else
  if sel = fNaprezeniaS then actNaprezenia.Execute else
  if sel = fWspRed then actWspRed.Execute else
  if sel = fPrzewObc then actRodzajNapr.Execute else

  if sel = fPodporaA then actStala.Execute else
  if sel = fPodporaB then actPrzesuwna.Execute else

  if TObject(sel.Data) is TForce then actSilaPozaWalemEdit.Execute;
  if TObject(sel.Data) is TMoment then actMomentEdit.Execute;
  if TObject(sel.Data) is TTorque then actTorqueEdit.Execute;
end;

procedure TForm1.UpdateTreeData;
// aktualizuję informacje dotyczące położenia podpór
var
  node: TTreeNode;
  load: TLoad;
begin
  // aktualizacja informacji o danych materiałowych
  fNaprezeniaG.Text:= Format('Dopuszczalne naprężenia na zginanie kg [MPa]: %.1f', [naprezeniaG]);
  fNaprezeniaS.Text:= Format('Dopuszczalne naprężenia na skręcanie ks [MPa]: %.1f', [naprezeniaS]);
  fWspRed.Text:= Format('Współczynnik redukcyjny: %s', [IfThen(abs(reduction - sqrt(3)/2)<0.01, '√3/2', '√3/4')]);
  fPrzewObc.Text:= Format('Przeważające naprężenia: %s', [fPrzewazajace]);
  // aktualizacja informacji o podporach
  fPodporaA.Text := Format('Stała Ra: (%.2f; %.2f; %.2f), Położenie Z: %.2f', [Shaft.SupportA.Fx, Shaft.SupportA.Fy, Shaft.SupportA.Fz, Shaft.SupportA.Z]);
  fPodporaB.Text := Format('Przesuwna Rb: (%.2f; %.2f), Położenie Z: %.2f', [Shaft.SupportB.Fx, Shaft.SupportB.Fy, Shaft.SupportB.Z]);

  // aktualizacja informacji o obciążeniach
  node := fObciazenia.getFirstChild;
  while Assigned(node) do begin
    load := TLoad(node.Data);

    if load is TForce then node.Text := Format('Siła F: (%.2f; %.2f; %.2f), Położenie Z: %.2f, Położenie X: %.2f, Położenie Y: %.2f', [TForce(load).Fx, TForce(load).Fy, TForce(load).Fz, TForce(load).Z,TForce(load).X,TForce(load).Y]);
    if load is TMoment then node.Text := Format('Moment M: (%.2f; %.2f), Położenie Z: %.2f', [TMoment(load).MomentX, TMoment(load).MomentY,TMoment(load).Z]);
    if load is TTorque then node.Text := Format('Moment skręcający M: (%.2f ), Położenie Z: %.2f', [TTorque(load).Torque, TTorque(load).Z]);

    node := node.getNextSibling;
  end;

  //Generowanie raportu po każdej zmianie
  actWyniki.Execute;
end;

procedure TForm1.Zamianapodpr1Click(Sender: TObject);
begin
  Shaft.SwapSupports;
end;

end.
