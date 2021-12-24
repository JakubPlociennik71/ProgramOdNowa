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


    procedure UsunClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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
Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Moment gnący');
      Node.Selected:=True;
      Node.editText;
 Form4.Show;
end;
procedure TForm1.actPrzesuwnaExecute(Sender: TObject);
var
  Node: TTreeNode ;
begin
Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Podpora przesuwna');
      Node.Selected:=True;
      Node.editText;
 Form6.Show;
end;
procedure TForm1.actSilaExecute(Sender: TObject);
var
  Node: TTreeNode ;
begin
Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Siła');
      Node.Selected:=True;
      Node.editText;
 Form2.Show;
end;

procedure TForm1.actSilaPozaWalemExecute(Sender: TObject);
var
  Node: TTreeNode ;
begin
Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Siła poza wałem');
      Node.Selected:=True;
      Node.editText;
 Form3.Show;
end;
procedure TForm1.actStalaExecute(Sender: TObject);
var
  Node: TTreeNode ;
begin
Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Podpora stała');
      Node.Selected:=True;
      Node.editText;
 Form7.Show;
end;
procedure TForm1.actTorqueExecute(Sender: TObject);
var
  Node: TTreeNode ;
begin
Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Moment skręcający');
      Node.Selected:=True;
      Node.editText;
 Form5.Show;
end;
procedure TForm1.Button1Click(Sender: TObject);
var
  Node: TTreeNode ;
begin
      Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Nowe obciązenie');
      Node.Selected:=True;
      Node.editText;
end;


procedure TForm1.Button3Click(Sender: TObject);
//var
//  f1,f2: TForce;
//  fa,fb: TP3D;
//  z,s,m,t,skala1,skala2,skalaF,skalaY,skalaX,skalaM,skalaTor,skalaRed,skalaD,max: double;
//  licznik,i:integer;
//  can: TCanvas;
//  rct: TRect;

begin
//Form8.Show;


//  Shaft.BeginUpdate;
//  Shaft.SupportB.Z:=6;
//
//  f1:=Shaft.AddForce(P3D(0,-150,80),2);
//  f2:=Shaft.AddForce(P3D(0,-80,0),4);
//  Shaft.EndUpdate;
//
//
//  points:=Shaft.ZPositions;
//  d:=length(points);
//  SetLength(sila_Y_x,2*d);
//  SetLength(sila_Y_y,2*d) ;
//  SetLength(sila_X_x,2*d);
//  SetLength(sila_X_y,2*d) ;
//  SetLength(sila_x,2*d);
//  SetLength(sila_y,2*d) ;
//  SetLength(moment_y,2*d) ;
//  SetLength(torque_y,2*d);
//  licznik:=0;
//  fa:=Shaft.SupportA.Force;
//  fb:=Shaft.SupportB.Force;
//   ListBox1.Items.Add('Wartości reakcji w podporze stałej (X,Y,Z):');
//   ListBox1.Items.Add(FloatToStr(fa.X)+' '+FloatToStr(fa.Y)+' '+FloatToStr(fa.Z));
//    ListBox1.Items.Add('Wartości reakcji w podporze przesuwnej (X,Y,Z):');
//   ListBox1.Items.Add(FloatToStr(fb.X)+' '+FloatToStr(fb.Y)+' '+FloatToStr(fb.Z));
//
//  for z in points do begin
//
////      s:=Shaft.ShearY(z,ltLeft);
////
////      sila_Y_y[licznik]:=Shaft.ShearY(z,ltLeft);
////      sila_Y_x[licznik]:=z;
////      //ListBox1.Items.Add(FloatToStr(sila_Y_x[licznik])+' '+FloatToStr(sila_Y_y[licznik]));
////      sila_X_y[licznik]:=Shaft.ShearX(z,ltLeft);
////      sila_X_x[licznik]:=z;
////
////      sila_y[licznik]:=Shaft.Shear(z,ltLeft);
////      sila_x[licznik]:=z;
////
////       moment_y[licznik]:=Shaft.Moment(z,ltLeft);
////       torque_y[licznik]:=Shaft.Torque(z,ltLeft);
//
//
//       licznik:=licznik+1;
//     s:=Shaft.ShearY(z);
//      sila_Y_y[licznik]:=Shaft.ShearY(z);
//      sila_Y_x[licznik]:=z;
//       //ListBox1.Items.Add(FloatToStr(sila_Y_x[licznik])+' '+FloatToStr(sila_Y_y[licznik]));
//       sila_X_y[licznik]:=Shaft.ShearX(z);
//      sila_X_x[licznik]:=z;
//
//      sila_y[licznik]:=Shaft.Shear(z);
//      sila_x[licznik]:=z;
//
//      moment_y[licznik]:= Shaft.Moment(z);
//       torque_y[licznik]:= Shaft.Torque(z);
//
//
//
//      licznik:=licznik+1;
//
//
//
//
////    m:=Shaft.Moment(z,ltLeft);
////
////    m:=Shaft.Moment(z);
////
////    t:=Shaft.Torque(z,ltLeft);
////
////    t:=Shaft.Torque(z);
//
//
//
//
//  end;

  // test rysowania diagramu sił
//  can.Pen.Color := clGray;
//  can.Rectangle(8, 8, 152, 122);

//  can := pbPaintBox.Canvas;

//  rct := Rect(10, 10, pbPaintBox.Width - 10, 110);
//  PrepareMap(MinValue(sila_Y_X), MinValue(sila_Y_Y), MaxValue(sila_Y_X), MaxValue(sila_Y_Y), rct);
//  Diagram(can, clRed, sila_Y_X, sila_Y_Y);

//  rct.Offset(0, 120);
//  PrepareMap(MinValue(sila_X_X), MinValue(sila_X_Y), MaxValue(sila_X_X), MaxValue(sila_X_Y), rct);
//  Diagram(can, clGreen, sila_X_X, sila_X_Y);
//  PrepareMap(MinValue(sila_Y_X), MinValue(sila_Y_Y), MaxValue(sila_Y_X), MaxValue(sila_Y_Y), rct);
//  Diagram(can, clGreen, sila_Y_X, sila_Y_Y);



//  skala1:=Abs((300/Shaft.ZPositions[Form1.d-1])-1);

  // if Find_Max(Form1.sila_Y_Y,2*d)=0 then skalaY:=0.1
  //else  skalaY:=Abs((200/Find_Max(Form1.sila_Y_y,d))-10);
  //
  //
  //
  //
  //if Find_Max(Form1.sila_X_Y,2*d)=0 then skalaX:=0.1
  //else skalaX:=Abs((200/Find_Max(Form1.sila_X_y,2*d))-10);
  //
  //
  //if Find_Max(Form1.sila_Y,2*d)=0 then skalaF:=0.1
  //else skalaF:=Abs((200/Find_Max(Form1.sila_Y,2*d))-10);
  //
  //if Find_Max( moment_y,2*d)=0 then skalaM:=0.1
  //else skalaM:=Abs((200/Find_Max(moment_y,2*d))-10);
  //
  //if Find_Max( torque_y,2*d)=0 then skalaTor:=0.1
  //else skalaTor:=Abs((200/Find_Max(torque_y,2*d))-10);






//  Image1.Picture.Bitmap.canvas.pen.color:=clRed;
//  for I := 0 to (Form1.d*2)-2  do  begin
//
//      Image1.Picture.Bitmap.canvas.moveto(Trunc(skala1*Form1.sila_Y_x[i]),(Trunc(skalaY*Form1.sila_Y_y[i])+Trunc(200/2)));
//      Image1.Picture.Bitmap.canvas.lineto(Trunc(skala1*Form1.sila_Y_x[i+1]),(Trunc(skalaY*Form1.sila_Y_y[i+1])+Trunc(200/2)));
//
//      Image1.Picture.Bitmap.canvas.moveto(Trunc(skala1*Form1.sila_X_x[i]),(Trunc(skalaX*Form1.sila_X_y[i])+Trunc(300)));
//      Image1.Picture.Bitmap.canvas.lineto(Trunc(skala1*Form1.sila_X_x[i+1]),(Trunc(skalaX*Form1.sila_X_y[i+1])+Trunc(300)));
//
//      Image1.Picture.Bitmap.canvas.moveto(Trunc(skala1*Form1.sila_x[i]),(Trunc(skalaF*Form1.sila_y[i])+Trunc(500)));
//      Image1.Picture.Bitmap.canvas.lineto(Trunc(skala1*Form1.sila_x[i+1]),(Trunc(skalaF*Form1.sila_y[i+1])+Trunc(500)));
//
//      Image1.Picture.Bitmap.canvas.moveto(Trunc(skala1*Form1.sila_x[i]),(Trunc(skalaM*moment_y[i])+Trunc(700)));
//      Image1.Picture.Bitmap.canvas.lineto(Trunc(skala1*Form1.sila_x[i+1]),(Trunc(skalaM*moment_y[i+1])+Trunc(700)));
//
//      Image1.Picture.Bitmap.canvas.moveto(Trunc(skala1*Form1.sila_x[i]),(Trunc(skalaTor*torque_y[i])+Trunc(900)));
//      Image1.Picture.Bitmap.canvas.lineto(Trunc(skala1*Form1.sila_x[i+1]),(Trunc(skalaTor*torque_y[i+1])+Trunc(900)));
//
//
//  end;






end;

procedure TForm1.Button4Click(Sender: TObject);
begin
//TreeView1.Items.AddChild(TreeView1.Selected,'Siła skupiona');
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
    Result := Sqrt(Sqr(m + a) + Sqr(t * reduction / 2))
  else
    Result := Sqrt(Sqr(m + a) / Sqr(reduction) + Sqr(t));

//  if normalne  then
//    Result := Sqrt(Sqr(Shaft.Moment(AZ) + shaft.Axial(AZ)) + Sqr(Shaft.Torque(Az) * reduction / 2))
//  else
//    Result := Sqrt(((Shaft.Moment(Az) + Shaft.Axial(Az)) * (Shaft.Moment(Az) + Shaft.Axial(Az))) / Sqr(reduction) + Sqr(Shaft.Torque(Az)));
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
  naprezenia:=200;
  reduction:=5;
  safety_factor:=4;

  // przypisanie procedury obsługiwanej po zmianie danych wałka
  Shaft.OnChange := OnChange;

  // przykład z Kurmaza (str. 109)
  Shaft.BeginUpdate;
  Shaft.PlaceSupports(0.098, 0);
  Shaft.AddForce(2421, -895, -438, 0.09451, 0, 0.049);
  Shaft.AddForce(Polar(5100, 150), 0.178);
  Shaft.AddTorque(228.8, 0.178);
  Shaft.EndUpdate;




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
begin
  if TreeView1.Selected.Enabled = false then
    MessageDlg('Nie można usunąć', mtInformation, [mbOk], 0)
  else
    TreeView1.Selected.Delete;
end;

procedure TForm1.Wspczynnikbezpieczestwa1Click(Sender: TObject);
var
  Node: TTreeNode ;
begin
Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Współczynnik bezpieczeństwa');
      Node.Selected:=True;
      Node.editText;
Form9.Show;
end;

procedure TForm1.Wybrwaciwocimateriaowych1Click(Sender: TObject);
var
  Node: TTreeNode ;
begin

Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Naprężenie maksymalne');
      Node.Selected:=True;
      Node.editText;
Form11.Show;
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
