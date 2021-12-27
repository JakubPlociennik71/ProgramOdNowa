unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.StdActns, Vcl.Menus, System.Actions, Vcl.ActnList, Vcl.ToolWin,
  System.ImageList, Vcl.ImgList, Vcl.ExtActns, Loads, Vcl.ExtCtrls;



type
  TForm1 = class(TForm)
    TreeView1: TTreeView;
    Usun: TButton;
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    ImageList1: TImageList;
    ToolBar1: TToolBar;
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
    Button3: TButton;
    ListBox1: TListBox;
    PopupMenu1: TPopupMenu;
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
    Image2: TImage;
    Wspczynnikbezpieczestwa1: TMenuItem;
    Wybrwspczynnikaredukujcego1: TMenuItem;
    Wybrwaciwocimateriaowych1: TMenuItem;
    HelpContents1: THelpContents;
    Contents1: TMenuItem;
    pbDiagrams: TPaintBox;
    Button1: TButton;
    Button2: TButton;


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
  private
    function Equivalent(AZ: Double): Double;
    function Diameter(AZ: Double): Double;

    procedure PaintDiagrams;
    procedure OnChange(ASender: TObject);
  public
    { Public declarations }
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

  end;
 type
 Obciazenie = class
   odleglosc: Real;
   silaX: Real;
   SilaY:Real;
   CzyMoment: Boolean;
 end;
var
  Form1: TForm1;

implementation

{$R *.dfm}

uses UITypes, Math, Diagrams, Unit2, Unit3, Unit4, Unit5, Unit6, Unit7, Unit8, Unit9, Unit10,
  Unit11;



procedure TForm1.actMomentExecute(Sender: TObject);
var
  Node: TTreeNode ;
begin
if TreeView1.Selected.Enabled = false then   begin
Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Moment gnący');
      Node.Selected:=True;
      Node.editText;
 Form4.Show;
end else ShowMessage('Nie zaznaczono węzła Obciążenia');
end;
procedure TForm1.actPrzesuwnaExecute(Sender: TObject);
var
  Node: TTreeNode ;
begin
if TreeView1.Selected.Enabled = false then   begin
Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Podpora przesuwna');
      Node.Selected:=True;
      Node.editText;
 Form6.Show;
end else ShowMessage('Nie zaznaczono węzła Obciążenia');
end;
procedure TForm1.actSilaExecute(Sender: TObject);
var
  Node: TTreeNode ;
begin
if TreeView1.Selected.Enabled = false then   begin

 Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Siła');
      Node.Selected:=True;
      Node.editText;
     Form2.Show;
end else ShowMessage('Nie zaznaczono węzła Obciążenia');


end;

procedure TForm1.actSilaPozaWalemExecute(Sender: TObject);
var
  Node: TTreeNode ;
begin
if TreeView1.Selected.Enabled = false then   begin
Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Siła poza wałem');
      Node.Selected:=True;
      Node.editText;
 Form3.Show;

end else  ShowMessage('Nie zaznaczono węzła Obciążenia');
end;
procedure TForm1.actStalaExecute(Sender: TObject);
var
  Node: TTreeNode ;
begin
if TreeView1.Selected.Enabled = false then   begin
Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Podpora stała');
      Node.Selected:=True;
      Node.editText;
 Form7.Show;
end  else ShowMessage('Nie zaznaczono węzła Obciążenia');
end;

procedure TForm1.actTorqueExecute(Sender: TObject);
var
  Node: TTreeNode ;
begin
if TreeView1.Selected.Enabled = false then   begin
Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Moment skręcający');
      Node.Selected:=True;
      Node.editText;
 Form5.Show;
end else  ShowMessage('Nie zaznaczono węzła Obciążenia');
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
  f1,f2: TForce;
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
  a, m, t: Double;
begin
  if not InRange(AZ, Shaft.MinZValue, Shaft.MaxZValue) then Exit(0);

  a := Shaft.Axial(AZ);
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
    Result := Power((32 * Equivalent(Az)) / (Pi * naprezenia), 1/3)
  else
    Result := Power((16 * Equivalent(Az)) / (Pi * naprezenia), 1/3);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
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

procedure TForm1.UsunClick(Sender: TObject);
var
ob: TLoad;
begin
  if TreeView1.Selected.Enabled = false then
    MessageDlg('Nie można usunąć', mtInformation, [mbOk], 0)
  else
    TreeView1.Selected.Delete;

  Shaft.DeleteLoad(ob);
end;

procedure TForm1.Wspczynnikbezpieczestwa1Click(Sender: TObject);
var
  Node: TTreeNode ;
begin
if TreeView1.Selected.Enabled = false then   begin
Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Współczynnik bezpieczeństwa');
      Node.Selected:=True;
      Node.editText;
Form9.Show;
end else ShowMessage('Nie zaznaczono węzła Obciążenia');
end;

procedure TForm1.Wybrwaciwocimateriaowych1Click(Sender: TObject);
var
  Node: TTreeNode ;
begin
if TreeView1.Selected.Enabled = false then   begin
Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Naprężenie maksymalne');
      Node.Selected:=True;
      Node.editText;
Form11.Show;
end else ShowMessage('Nie zaznaczono węzła Obciążenia');
end;

procedure TForm1.Wybrwspczynnikaredukujcego1Click(Sender: TObject);
var
 Node: TTreeNode ;
begin
Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Wspólczynnik redukujący');
      Node.Selected:=True;
      Node.editText;
Form10.Show;
end;

end.
