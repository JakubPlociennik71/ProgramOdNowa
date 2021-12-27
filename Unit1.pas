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
    Action1: TAction;
    FileSaveAs1: TFileSaveAs;
    FileExit1: TFileExit;
    FileOpen1: TFileOpen;
    Action2: TAction;
    ControlAction1: TControlAction;
    ControlAction11: TMenuItem;
    Exit1: TMenuItem;
    Open1: TMenuItem;
    Open2: TMenuItem;
    ListBox1: TListBox;
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
    Wspczynnikbezpieczestwa1: TMenuItem;
    Wybrwspczynnikaredukujcego1: TMenuItem;
    Wybrwaciwocimateriaowych1: TMenuItem;
    HelpContents1: THelpContents;
    pbDiagrams: TPaintBox;
    splLeft: TSplitter;
    splRight: TSplitter;
    pnlLeft: TPanel;
    actSilaEdit: TAction;
    Zamianapodpr1: TMenuItem;
    actWyniki: TAction;
    Wynikioblicze1: TMenuItem;
    actUsunWszystko: TAction;
    Usuwszystkieobcienia1: TMenuItem;
    acyUsunObc: TAction;
    Usuobcienie1: TMenuItem;
    actMomentEdit: TAction;
    actTorqueEdit: TAction;
    actSilaPozaWalemEdit: TAction;

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
    procedure Wspczynnikbezpieczestwa1Click(Sender: TObject);
    procedure Wybrwspczynnikaredukujcego1Click(Sender: TObject);
    procedure pbPaintBoxPaint(Sender: TObject);
    procedure Wybrwaciwocimateriaowych1Click(Sender: TObject);
    procedure pbDiagramsPaint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure tvTreeDblClick(Sender: TObject);
    procedure actSilaEditExecute(Sender: TObject);
    procedure Zamianapodpr1Click(Sender: TObject);
    procedure actWynikiExecute(Sender: TObject);
    procedure actUsunWszystkoExecute(Sender: TObject);
    procedure acyUsunObcExecute(Sender: TObject);
    procedure actMomentEditExecute(Sender: TObject);
    procedure actTorqueEditExecute(Sender: TObject);
    procedure actSilaPozaWalemEditExecute(Sender: TObject);
  private
    function Equivalent(AZ: Double): Double;
    function Diameter(AZ: Double): Double;

    procedure PaintDiagrams;
    procedure OnChange(ASender: TObject);

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
    naprezenia: double;
    start: integer;
    normalne: boolean;
    licznik_obciazen: integer;

    // obsługa drzewka
    fPodpory, fPodporaA, fPodporaB: TTreeNode;
    fObciazenia: TTreeNode;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses UITypes, Math, Diagrams, Unit2, Unit3, Unit4, Unit5, Unit6, Unit7, Unit8, Unit9, Unit10, Unit11;

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

procedure TForm1.actPrzesuwnaExecute(Sender: TObject);
begin
  Form6.edtZ.Text := FloatToStr(Shaft.SupportB.Z);

  if Form6.ShowModal <> mrOK then Exit;

  Shaft.SupportB.Z := StrToFloat(Form6.edtZ.Text);
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
  if Form2.ShowModal <> mrOK then Exit;

  // konwertuję dane tekstowe na liczbowe
  fx := StrToFloat(Form3.edtFx.Text);
  fy := StrToFloat(Form3.edtFy.Text);
  fz := StrToFloat(Form3.edtFz.Text);
  x := StrToFloat(Form3.edtX.Text);
  y := StrToFloat(Form3.edtY.Text);
  z := StrToFloat(Form3.edtZ.Text);

  // aktualizuję wartość oraz położenie siły
  //f.Force := (P3D(fx, fy, fz),P3d(x,y,z));
  //f.Z := z;

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
  tx := StrToFloat(Form4.edtFx.Text);
  z := StrToFloat(Form4.edtZ.Text);

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
  t := Shaft.AddTorque(StrToFloat(Form2.edtFx.Text), StrToFloat(Form2.edtZ.Text));

  // jeśli udało się utworzyć siłę to dodaję odpowiedni węzeł do drzewka i aktualizuję dane
  tvTree.Selected := tvTree.Items.AddChildObject(fObciazenia, EmptyStr, t);
  UpdateTreeData;
end;

procedure TForm1.actUsunWszystkoExecute(Sender: TObject);
begin
  Shaft.Clear;
end;

procedure TForm1.actWynikiExecute(Sender: TObject);
var
  fa,fb: TP3D;
  z: double;
begin
  fa:=Shaft.SupportA.Force;
  fb:=Shaft.SupportB.Force;

  ListBox1.Items.Add('Wartości reakcji w podporze stałej (X,Y,Z):');
  ListBox1.Items.Add(FloatToStr(fa.X)+';  '+FloatToStr(fa.Y)+';  '+FloatToStr(fa.Z));
  ListBox1.Items.Add('Wartości reakcji w podporze przesuwnej (X,Y,Z):');
  ListBox1.Items.Add(FloatToStr(fb.X)+';  '+FloatToStr(fb.Y)+';  '+FloatToStr(fb.Z));

  points:=Shaft.ZPositions;
  for z in points do begin
     ListBox1.Items.Add('Wartości siły X w punkcie'+' '+FloatToStr(z)+' w kN');
     ListBox1.Items.Add(FloatToStr(Shaft.ShearX(z))) ;
     ListBox1.Items.Add('Wartości siły Y w punkcie'+' '+FloatToStr(z)+' w kN');
     ListBox1.Items.Add(FloatToStr(Shaft.ShearY(z))) ;
     ListBox1.Items.Add('Wartości siły  w punkcie'+' '+FloatToStr(z)+' w kN');
     ListBox1.Items.Add(FloatToStr(Shaft.Shear(z))) ;
     ListBox1.Items.Add('Wartości momentu X  w punkcie'+' '+FloatToStr(z)+' w kNm');
     ListBox1.Items.Add(FloatToStr(Shaft.MomentX(z))) ;
     ListBox1.Items.Add('Wartości momentu Y  w punkcie'+' '+FloatToStr(z)+' w kNm');
     ListBox1.Items.Add(FloatToStr(Shaft.MomentY(z))) ;
     ListBox1.Items.Add('Wartości momentu w punkcie'+' '+FloatToStr(z)+' w kNm');
     ListBox1.Items.Add(FloatToStr(Shaft.Moment(z))) ;
     ListBox1.Items.Add('Wartości momentu skrecajacego  w punkcie'+' '+FloatToStr(z)+' w kNm');
     ListBox1.Items.Add(FloatToStr(Shaft.Torque(z))) ;
     ListBox1.Items.Add('Wartości momentu zredukowanego  w punkcie'+' '+FloatToStr(z)+' w kNm');
     ListBox1.Items.Add(FloatToStr(Equivalent(z)));
     ListBox1.Items.Add('Wartości srednicy  w punkcie'+' '+FloatToStr(z)+' w m');
     ListBox1.Items.Add(FloatToStr(Diameter(z)));
  end;
end;

procedure TForm1.acyUsunObcExecute(Sender: TObject);
begin
  if tvTree.Selected.Enabled = false then
    MessageDlg('Nie można usunąć', mtInformation, [mbOk], 0)
  else
    tvTree.Selected.Delete;
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
  z: double;
begin
  fa:=Shaft.SupportA.Force;
  fb:=Shaft.SupportB.Force;

  ListBox1.Items.Add('Wartości reakcji w podporze stałej (X,Y,Z):');
  ListBox1.Items.Add(FloatToStr(fa.X)+';  '+FloatToStr(fa.Y)+';  '+FloatToStr(fa.Z));
  ListBox1.Items.Add('Wartości reakcji w podporze przesuwnej (X,Y,Z):');
  ListBox1.Items.Add(FloatToStr(fb.X)+';  '+FloatToStr(fb.Y)+';  '+FloatToStr(fb.Z));

  points:=Shaft.ZPositions;
  for z in points do begin
     ListBox1.Items.Add('Wartości siły X w punkcie'+' '+FloatToStr(z)+' w kN');
     ListBox1.Items.Add(FloatToStr(Shaft.ShearX(z))) ;
     ListBox1.Items.Add('Wartości siły Y w punkcie'+' '+FloatToStr(z)+' w kN');
     ListBox1.Items.Add(FloatToStr(Shaft.ShearY(z))) ;
     ListBox1.Items.Add('Wartości siły  w punkcie'+' '+FloatToStr(z)+' w kN');
     ListBox1.Items.Add(FloatToStr(Shaft.Shear(z))) ;
     ListBox1.Items.Add('Wartości momentu X  w punkcie'+' '+FloatToStr(z)+' w kNm');
     ListBox1.Items.Add(FloatToStr(Shaft.MomentX(z))) ;
     ListBox1.Items.Add('Wartości momentu Y  w punkcie'+' '+FloatToStr(z)+' w kNm');
     ListBox1.Items.Add(FloatToStr(Shaft.MomentY(z))) ;
     ListBox1.Items.Add('Wartości momentu w punkcie'+' '+FloatToStr(z)+' w kNm');
     ListBox1.Items.Add(FloatToStr(Shaft.Moment(z))) ;
     ListBox1.Items.Add('Wartości momentu skrecajacego  w punkcie'+' '+FloatToStr(z)+' w kNm');
     ListBox1.Items.Add(FloatToStr(Shaft.Torque(z))) ;
     ListBox1.Items.Add('Wartości momentu zredukowanego  w punkcie'+' '+FloatToStr(z)+' w kNm');
     ListBox1.Items.Add(FloatToStr(Equivalent(z)));
     ListBox1.Items.Add('Wartości srednicy  w punkcie'+' '+FloatToStr(z)+' w m');
     ListBox1.Items.Add(FloatToStr(Diameter(z)));
  end;
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
    Result := Sqrt(Sqr(m) + Sqr(t * reduction / 2))
  else
    Result := Sqrt(Sqr(m) / Sqr(reduction) + Sqr(t));
end;

function TForm1.Diameter(AZ: Double): Double;
begin
  if not InRange(Az, Shaft.MinZValue, Shaft.MaxZValue) then Exit(0);

  if normalne then
    Result := Power((32 * Equivalent(Az)) / (Pi * naprezenia/safety_factor), 1/3)
  else
    Result := Power((16 * Equivalent(Az)) / (Pi * naprezenia/safety_factor), 1/3);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // tworzenie i konfiguracja drzewka
  fPodpory := tvTree.Items.AddChild(nil, 'Podpory');
  fPodpory.Enabled:=false;
  fObciazenia := tvTree.Items.AddChild(nil, 'Obciążenia');
  fObciazenia.Enabled:=false;
  fPodporaA := tvTree.Items.AddChild(fPodpory, 'Stała');    // podpora A
  fPodporaA.Enabled:=false;
  fPodporaB := tvTree.Items.AddChild(fPodpory, 'Ruchoma');  // podpora B
  fPodporaB.Enabled:=false;
  UpdateTreeData;


  start:=0;
  normalne:=true;
  naprezenia:=250;
  reduction:=sqrt(3)/2;
  safety_factor:=4;

  // przypisanie procedury obsługiwanej po zmianie danych wałka
  Shaft.OnChange := OnChange;
  ListBox1.Items.Add('Wyniki Obliczeń: ');
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

procedure TForm1.tvTreeDblClick(Sender: TObject);
var
  sel: TTreeNode;
begin
  sel := (Sender as TTreeView).Selected;

  if sel = fPodporaA then actStala.Execute else
  if sel = fPodporaB then actPrzesuwna.Execute else

  if TObject(sel.Data) is TForce then actSilaEdit.Execute;
end;

procedure TForm1.UpdateTreeData;
// aktualizuję informacje dotyczące położenia podpór
var
  node: TTreeNode;
  load: TLoad;
begin
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

procedure TForm1.Wspczynnikbezpieczestwa1Click(Sender: TObject);
//var
//  Node: TTreeNode ;
begin
//  if tvTree.Selected.Enabled = false then   begin
//    Node:=tvTree.Items.AddChild(tvTree.Selected,'Współczynnik bezpieczeństwa');
//    Node.Selected:=True;
//    Node.editText;
//    Form9.Show;
//  end else
//    ShowMessage('Nie zaznaczono węzła Obciążenia');
end;

procedure TForm1.Wybrwaciwocimateriaowych1Click(Sender: TObject);
//var
//  Node: TTreeNode ;
begin
//  if tvTree.Selected.Enabled = false then   begin
//    Node:=tvTree.Items.AddChild(tvTree.Selected,'Naprężenie dopuszczalne');
//    Node.Selected:=True;
//    Node.editText;
//    Form11.Show;
//  end else
//    ShowMessage('Nie zaznaczono węzła Obciążenia');
end;

procedure TForm1.Wybrwspczynnikaredukujcego1Click(Sender: TObject);
//var
//  Node: TTreeNode ;
begin
//  Node:=tvTree.Items.AddChild(tvTree.Selected,'Wspólczynnik redukujący');
//  Node.Selected:=True;
//  Node.editText;
//  Form10.Show;
end;

procedure TForm1.Zamianapodpr1Click(Sender: TObject);
begin
  Shaft.SwapSupports;
end;

end.
