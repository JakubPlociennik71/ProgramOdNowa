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
    FileExit1: TFileExit;
    FileOpen1: TFileOpen;
    pmPopup: TPopupMenu;
    FileOpen2: TFileOpen;
    actSila: TAction;
    Sia1: TMenuItem;
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
    HelpContents1: THelpContents;
    pbDiagrams: TPaintBox;
    splLeft: TSplitter;
    splRight: TSplitter;
    pnlLeft: TPanel;
    actSilaEdit: TAction;
    Zamianapodpr1: TMenuItem;
    actWyniki: TAction;
    actUsunWszystko: TAction;
    Usuwszystkieobcienia1: TMenuItem;
    actUsunObc: TAction;
    Usuobcienie1: TMenuItem;
    actMomentEdit: TAction;
    actTorqueEdit: TAction;
    actSilaPozaWalemEdit: TAction;
    Zapiszwyikidopliku1: TMenuItem;
    actWspEdit: TAction;
    actWspBezp: TAction;
    actNaprezeniaG: TAction;
    actWspRed: TAction;
    mmRaport: TMemo;

    procedure UsunClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure actSilaExecute(Sender: TObject);
    procedure actSilaPozaWalemExecute(Sender: TObject);
    procedure actMomentExecute(Sender: TObject);
    procedure actTorqueExecute(Sender: TObject);
    procedure actPrzesuwnaExecute(Sender: TObject);
    procedure actStalaExecute(Sender: TObject);
    procedure Wybrwspczynnikaredukujcego1Click(Sender: TObject);
    procedure pbPaintBoxPaint(Sender: TObject);
    procedure pbDiagramsPaint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure tvTreeDblClick(Sender: TObject);
    procedure actSilaEditExecute(Sender: TObject);
    procedure Zamianapodpr1Click(Sender: TObject);
    procedure actWynikiExecute(Sender: TObject);
    procedure actUsunWszystkoExecute(Sender: TObject);
    procedure actUsunObcExecute(Sender: TObject);
    procedure actMomentEditExecute(Sender: TObject);
    procedure actTorqueEditExecute(Sender: TObject);
    procedure actSilaPozaWalemEditExecute(Sender: TObject);
    procedure alActionsUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure actWspBezpExecute(Sender: TObject);
    procedure actNaprezeniaGExecute(Sender: TObject);
    procedure actWspRedExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actSaveRaportAccept(Sender: TObject);
  private
    function Equivalent(AZ: Double): Double;
    function Diameter(AZ: Double): Double;

    procedure PaintDiagrams;
    procedure OnChange(ASender: TObject);
    procedure Raport;

    procedure UpdateTreeData;
  public
    sila_Y_x: TAoD;
    sila_Y_y:TAoD;
    sila_X_x: TAoD;
    sila_X_y: TAoD;
    sila_x: TAoD;
    sila_y: TAoD;
    moment_y: TAoD;
    torque_y: TAoD;
    diameter_y: TAoD;
    safety_factor: double;
    reduction: double;
    d: integer;
    points: TAoD;
    naprezeniaG,naprezeniaS: double;
    start: integer;
    normalne: boolean;
    licznik_obciazen: integer;
    path: string;
    // obsługa drzewka
    fPodpory, fPodporaA, fPodporaB: TTreeNode;
    fObciazenia: TTreeNode;
    fMaterial,fNaprezeniaG,fNaprezeniaS,fWspRed: TTreeNode;
    //fWspolBezp: TTreeNode;
    fRaport: TStringList;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses UITypes, Math, Diagrams, Unit2, Unit3, Unit4, Unit5, Unit6, Unit7, Unit8, Unit9, Unit10, Unit11,
  Unit12,StrUtils;

procedure TForm1.actMomentEditExecute(Sender: TObject);
var
  m: TMoment;
  mx, my, z: Double;
begin
  m := (TObject(tvTree.Selected.Data) as TMoment);

  Form4.Init(m);
  if Form4.ShowModal <> mrOK then Exit;

  // konwertuję dane tekstowe na liczbowe
  mx := StrToFloat(Form4.edtFx.Text);
  my := StrToFloat(Form4.edtFy.Text);
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
  m := Shaft.AddMoment(StrToFloat(Form4.edtFx.Text), StrToFloat(Form4.edtFy.Text), StrToFloat(Form4.edtZ.Text));

  // jeśli udało się utworzyć siłę to dodaję odpowiedni węzeł do drzewka i aktualizuję dane
  tvTree.Selected := tvTree.Items.AddChildObject(fObciazenia, EmptyStr, m);
  UpdateTreeData;
end;

procedure TForm1.actNaprezeniaGExecute(Sender: TObject);
begin
  Form11.Init(naprezeniaG,naprezeniaS);
  if Form11.ShowModal <> mrOK then Exit;

  if (StrToFloat(Form11.edtKg.Text)<=0) or (StrToFloat(Form11.edtKs.Text)<=0)  then ShowMessage('Wpisano wartość mniejszą od 0') else begin
    naprezeniaG:=StrToFloat(Form11.edtKg.Text);
    naprezeniaS:=StrToFloat(Form11.edtKs.Text);
    UpdateTreeData;
  end;



end;

procedure TForm1.actPrzesuwnaExecute(Sender: TObject);
begin
  Form6.edtZ.Text := FloatToStr(Shaft.SupportB.Z);

  if Form6.ShowModal <> mrOK then Exit;

  Shaft.SupportB.Z := StrToFloat(Form6.edtZ.Text);
end;

procedure TForm1.actSaveRaportAccept(Sender: TObject);
begin
  raport;
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
  tx := StrToFloat(Form5.edtFx.Text);
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
  t := Shaft.AddTorque(StrToFloat(Form5.edtFx.Text), StrToFloat(Form5.edtZ.Text));

  // jeśli udało się utworzyć siłę to dodaję odpowiedni węzeł do drzewka i aktualizuję dane
  tvTree.Selected := tvTree.Items.AddChildObject(fObciazenia, EmptyStr, t);
  UpdateTreeData;
end;

procedure TForm1.actUsunWszystkoExecute(Sender: TObject);
begin
  Shaft.Clear;
  fObciazenia.DeleteChildren;
  UpdateTreeData;

end;

procedure TForm1.actWspBezpExecute(Sender: TObject);
begin
  Form9.Init(safety_factor);

  if Form9.ShowModal <> mrOK then Exit;

  if StrToFloat(Form9.Edit1.Text)<=0 then ShowMessage('Wpisano wartość mniejszą od 0') else begin
    safety_factor:= StrToFloat(Form9.Edit1.Text);
    UpdateTreeData;
  end;

end;

procedure TForm1.actWspRedExecute(Sender: TObject);
begin
  Form10.init(reduction);

  if Form10.ShowModal <> mrOK then Exit;

  reduction:=IfThen(Form10.RadioButton1.Checked,sqrt(3)/2,sqrt(3)/4);
  UpdateTreeData;
end;

procedure TForm1.actWynikiExecute(Sender: TObject);
var
  fa,fb: TP3D;
  z,m,krok: double;
begin
  Raport;
  mmRaport.Lines.Assign(fRaport);

end;



procedure TForm1.actUsunObcExecute(Sender: TObject);
var
  load: TLoad;
begin

  load:= TObject(TVTree.Selected.Data) as TLoad;
  Shaft.DeleteLoad(load) ;
  tvTree.Selected.Delete;
end;

procedure TForm1.alActionsUpdate(Action: TBasicAction; var Handled: Boolean);
var
load: TLoad;
begin

  Load:=nil;
  if assigned(TVTree.selected) then  Load:=   TObject(TVTree.Selected.Data) as TLoad;
  actusunObc.Enabled:=assigned(Load) and ((Load is TForce)or (Load is TMoment)or (Load is TTorque));
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Shaft.SwapSupports;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Shaft.Clear;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  fa,fb: TP3D;
  z,m,krok: double;
begin
  fa:=Shaft.SupportA.Force;
  fb:=Shaft.SupportB.Force;

end;


procedure TForm1.Button4Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Form3.Show;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Form4.Show;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  Form5.Show;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  Form7.Show;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  Form6.Show;
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
    Result := Sqrt(Sqr(m/reduction)  + Sqr(t));
end;

function TForm1.Diameter(AZ: Double): Double;
begin
  if not InRange(Az, Shaft.MinZValue, Shaft.MaxZValue) then Exit(0);

  if normalne then
    Result := Power((32 * Equivalent(Az)) / (Pi * naprezeniaG), 1/3)
  else
    Result := Power((16 * Equivalent(Az)) / (Pi * naprezeniaS), 1/3);
end;

procedure TForm1.FormCreate(Sender: TObject);
var Node:TTreeNode;
begin

  fRaport:=TStringList.Create;

  start:=0;
  normalne:=true;
  naprezeniaG:=62.5;
  naprezeniaS:=62.5;
  reduction:=sqrt(3)/2;
  safety_factor:=4;

  // tworzenie i konfiguracja drzewka

  fMaterial:= tvTree.Items.AddChild(nil, 'Dane materiałowe');
  fPodpory := tvTree.Items.AddChild(nil, 'Podpory');
  fObciazenia := tvTree.Items.AddChild(nil, 'Obciążenia');

  //fWspolBezp:=tvTree.Items.AddChild(fMaterial, 'Współczynnik bezpieczeństwa');
  fNaprezeniaG:=tvTree.Items.AddChild(fMaterial, 'Naprężenia dopuszczalne na zginanie kg [MPa]');
  fNaprezeniaS:=tvTree.Items.AddChild(fMaterial, 'Naprężenia dopuszczalne na skręcanie ks [MPa]');
  fWspRed :=tvTree.Items.AddChild(fMaterial, 'Współczynnik redukcyjny');

  fPodporaA := tvTree.Items.AddChild(fPodpory, 'Stała');    // podpora A
  fPodporaB := tvTree.Items.AddChild(fPodpory, 'Ruchoma');  // podpora B



  UpdateTreeData;
  TvTree.FullExpand;





  // przypisanie procedury obsługiwanej po zmianie danych wałka
  Shaft.OnChange := OnChange;
  //ListBox1.Items.Add('Wyniki Obliczeń: ');
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

  AddSeries(series, 'Ty [N]', clGreen, Shaft.ShearY);
  AddSeries(series, 'Tx [N]', clGreen, Shaft.ShearX);
  AddSeries(series, 'T [N]', clGreen, Shaft.Shear);

  AddSeries(series, 'Mgy [Nm]', clRed, Shaft.MomentY);
  AddSeries(series, 'Mgx [Nm]', clRed, Shaft.MomentX);
  AddSeries(series, 'Mg [Nm]', clRed, Shaft.Moment);

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

procedure TForm1.pbPaintBoxPaint(Sender: TObject);
begin
  PaintDiagrams;
end;

procedure TForm1.Raport;
var

  fa,fb: TReaction;
  z,m,krok: double;
  load: TLoad;
begin
  fRaport.Clear;

  //Dane materiałowe
  fRaport.Add('1.Dane materiałowe');
  //fRaport.Add('');
  fRaport.Add(Format(' -Dopuszczalne naprężenia na zginanie kg [MPa]: %.0f',[naprezeniaG]));
  fRaport.Add(Format(' -Dopuszczalne naprężenia na skręcanie ks [MPa]: %.0f',[naprezeniaS]));
  fRaport.Add('');
  //Obciązenia
  fRaport.Add('2.Obciążenia');
  //fRaport.Add('');
  for load in  Shaft do begin
    if load is TForce then fRaport.Add(Format('  Siła [kN]: (%.3f; %.3f; %.3f); Położenie [m]: (%.3f; %.3f; %.3f)',
      [TForce(Load).Fx,TForce(Load).Fy,TForce(Load).Fz,TForce(Load).X,TForce(Load).Y,TForce(Load).Z]));

    if load is TMoment then fRaport.Add(Format('  Moment gnący [Nm]: (%.3f; %.3f); Położenie Z [m]: %.3f',
      [TMoment(Load).MomentX,TMoment(Load).MomentY,TMoment(Load).Z]));

    if load is TTorque then fRaport.Add(Format('  Moment skręcający [Nm]: %.3f); Położenie Z [m]: %.3f',
      [TTorque(Load).Torque,TTorque(Load).Z]));
  end;
//Reakcje
  fRaport.Add('');
  fRaport.Add('3.Reakcje');
  //fRaport.Add('');
  fa:=Shaft.SupportA;
  fb:=Shaft.SupportB;
  fRaport.Add(Format('  Podpora stała Ra [kN]: (%.2f; %.2f; %.2f); Położenie Z [m]: %.3f',
    [fa.Fx,fa.Fy,fa.Fz,fa.Z]));

  fRaport.Add(Format('  Podpora ruchoma Rb [kN]: (%.2f; %.2f); Położenie Z [m]: %.3f',
    [fa.Fx,fa.Fy,fa.Z]));
  fRaport.Add('');

//Obliczenia w przekrojach charakterystycznych
  fRaport.Add('4.Obliczenia w przekrojach charakterystycznych');
  //fRaport.Add('');
  fRaport.Add('4.1 Siły tnące (siła F w [kN], odległość Z w [m])');
  fRaport.Add('4.1.1 Siły tnące w płaszczyźnie XZ');
  points:=Shaft.ZPositions;

  for z in points do begin

    fRaport.Add(Format('  Z: %.3f; F: %.3f',[z,Shaft.ShearX(z)]));
    fRaport.Add(Format('  Z: %.3f; F: %.3f',[z,Shaft.ShearX(z-epsilon)]));


  end;

  fRaport.Add('');
  fRaport.Add('4.1.1 Siły tnące w płaszczyźnie XY');
   for z in points do begin

    fRaport.Add(Format('  Z: %.3f; F: %.3f',[z,Shaft.ShearY(z)]));
    fRaport.Add(Format('  Z: %.3f; F: %.3f',[z,Shaft.ShearY(z-epsilon)]));


  end;

  fRaport.Add('');
  fRaport.Add('4.1.1 Siły tnące');
   for z in points do begin

    fRaport.Add(Format('  Z: %.3f; F: %.3f',[z,Shaft.Shear(z)]));
    fRaport.Add(Format('  Z: %.3f; F: %.3f',[z,Shaft.Shear(z-epsilon)]));


  end;

  fRaport.Add('4.2 Momenty gnące (momenty M w [Nm], odległość Z w [m])');
  fRaport.Add('4.2.1 Momenty gnące w płaszczyźnie XZ');

  for z in points do begin

    fRaport.Add(Format('  Z: %.3f; M: %.3f',[z,Shaft.MomentX(z)*1000]));
    fRaport.Add(Format('  Z: %.3f; M: %.3f',[z,Shaft.MomentX(z-epsilon)*1000]));


  end;

  fRaport.Add('');
  fRaport.Add('4.2.2 Momenty gnące w płaszczyźnie XY');

  for z in points do begin

    fRaport.Add(Format('  Z: %.3f; M: %.3f',[z,Shaft.MomentY(z)*1000]));
    fRaport.Add(Format('  Z: %.3f; M: %.3f',[z,Shaft.MomentY(z-epsilon)*1000]));


  end;

  fRaport.Add('');
  fRaport.Add('4.2.3 Momenty gnące');

  for z in points do begin

    fRaport.Add(Format('  Z: %.3f; M: %.3f',[z,Shaft.Moment(z)*1000]));
    fRaport.Add(Format('  Z: %.3f; M: %.3f',[z,Shaft.Moment(z-epsilon)*1000]));


  end;

  fRaport.Add('');
  fRaport.Add('4.3 Momenty skręcające(momenty M w [Nm], odległość Z w [m])');

  for z in points do begin

    fRaport.Add(Format('  Z: %.3f; Ms: %.3f',[z,Shaft.Torque(z)*1000]));
    fRaport.Add(Format('  Z: %.3f; Ms: %.3f',[z,Shaft.Torque(z-epsilon)*1000]));


  end;

  fRaport.Add('');
  fRaport.Add('4.4. Moment zredukowany (moment Mz w [Nm], odległość Z w [m])');

  for z in points do begin

    fRaport.Add(Format('  Z: %.3f; Mz: %.3f',[z,Equivalent(z)*1000]));
    fRaport.Add(Format('  Z: %.3f; Mz: %.3f',[z,Equivalent(z-epsilon)*1000]));


  end;

  fRaport.Add('');
  fRaport.Add('4.5 Średnica teoretyczna (średnica w [mm], odległość Z w [m])');

  for z in points do begin

    fRaport.Add(Format(' -Z: %.3f ; Mz: %.3f',[z,Diameter(z)*100]));
    fRaport.Add(Format(' -Z: %.3f ; Mz: %.3f',[z,Diameter(z-epsilon)*100]));


  end;

  fRaport.Add('');
  fRaport.Add('5 Średnica teoretyczna w 30 równo oddalonych od siebie przekrojach');
  fRaport.Add('(średnica w [mm], odległość Z w [m])');
  m:=maxValue(points);
  krok:=m/30;
  z:=0;
  While (z <= m) do
  begin

    fRaport.Add(Format('  Z: %.3f; Mz: %.3f',[z,Diameter(z)*100]));
    fRaport.Add(Format('  Z: %.3f; Mz: %.3f',[z,Diameter(z-epsilon)*100]));

    z:=z+krok;
  end;

end;


procedure TForm1.tvTreeDblClick(Sender: TObject);
var
  sel: TTreeNode;
begin
  sel := (Sender as TTreeView).Selected;

  if sel = fNaprezeniaG then actNaprezeniaG.Execute else
  if sel = fNaprezeniaS then actNaprezeniaG.Execute else
  if sel = fWspRed then actWspRed.Execute else

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
  //raport;
  actWyniki.Execute;

end;

procedure TForm1.UsunClick(Sender: TObject);
//var
//  ob: TLoad;
begin
  if tvTree.Selected.Enabled = false then
    MessageDlg('Nie można usunąć', mtInformation, [mbOk], 0)
  else
    tvTree.Selected.Delete;
end;

procedure TForm1.Wybrwspczynnikaredukujcego1Click(Sender: TObject);
begin


  if Form10.ShowModal <> mrOK then Exit;

  if Form10.RadioButton1.Checked = true then begin
    Form1.reduction:=sqrt(3)/2;



  end ;

  if Form10.RadioButton2.Checked = true then begin
    Form1.reduction:=sqrt(3)/4;
  end;


end;

procedure TForm1.Zamianapodpr1Click(Sender: TObject);
begin
  Shaft.SwapSupports;
end;

end.
