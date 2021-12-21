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
    edt1: TRichEdit;
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
    actRedukcja: TAction;
    actBezpiecz: TAction;


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
  private
    { Private declarations }
  public
    { Public declarations }
   x: array of Double;
    y:array of Double;
    d: integer;
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

uses Unit2, Unit3, Unit4, Unit5, Unit6, Unit7, Unit8;



procedure TForm1.actMomentExecute(Sender: TObject);
var
  Node: TTreeNode ;
begin
Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Moment gn¹cy');
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
Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Si³a');
      Node.Selected:=True;
      Node.editText;
 Form2.Show;
end;

procedure TForm1.actSilaPozaWalemExecute(Sender: TObject);
var
  Node: TTreeNode ;
begin
Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Si³a poza wa³em');
      Node.Selected:=True;
      Node.editText;
 Form3.Show;
end;
procedure TForm1.actStalaExecute(Sender: TObject);
var
  Node: TTreeNode ;
begin
Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Podpora sta³a');
      Node.Selected:=True;
      Node.editText;
 Form7.Show;
end;
procedure TForm1.actTorqueExecute(Sender: TObject);
var
  Node: TTreeNode ;
begin
Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Moment skrêcaj¹cy');
      Node.Selected:=True;
      Node.editText;
 Form5.Show;
end;
procedure TForm1.Button1Click(Sender: TObject);
var
  Node: TTreeNode ;
begin
      Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Nowe obci¹zenie');
      Node.Selected:=True;
      Node.editText;
end;


procedure TForm1.Button3Click(Sender: TObject);
var
points: TAoD;
f1,f2: TForce;
z,s,m,t,skala1,skala2: double;
licznik,i:integer;

begin
Form8.Show;


Shaft.BeginUpdate;
Shaft.SupportB.Z:=6;
f1:=Shaft.AddForce(P3D(0,-15,0),2);
f2:=Shaft.AddForce(P3D(0,-6,0),4);
Shaft.EndUpdate;


points:=Shaft.ZPositions;
d:=length(points) ;
SetLength(x,2*d);
SetLength(y,2*d) ;
licznik:=0;
for z in points do begin

    s:=Shaft.ShearY(z,ltLeft);
    //ListBox1.Items.Add(FloatToStr(z)+' '+FloatToStr(s));
    y[licznik]:=Shaft.ShearY(z,ltLeft);
    x[licznik]:=z;
    ListBox1.Items.Add(FloatToStr(x[licznik])+' '+FloatToStr(y[licznik]));

  //Image1.Picture.Bitmap.canvas.moveto(Trunc(skala1*z),Trunc(s)+Trunc(Image1.Height/2));
     licznik:=licznik+1;
   s:=Shaft.ShearY(z);
    y[licznik]:=Shaft.ShearY(z);
    x[licznik]:=z;
     ListBox1.Items.Add(FloatToStr(x[licznik])+' '+FloatToStr(y[licznik]));
    licznik:=licznik+1;
   //ListBox1.Items.Add(FloatToStr(s));
   //Image1.Picture.Bitmap.canvas.lineto(Trunc((skala1*z)),Trunc(s)+Trunc(Image1.Height/2));

   //ListBox1.Items.Add(FloatToStr(z)+' '+FloatToStr(s));
  //ListBox1.Items.Add(FloatToStr(s));

  m:=Shaft.Moment(z,ltLeft);
  //ListBox1.Items.Add(FloatToStr(m));
  m:=Shaft.Moment(z);
  //ListBox1.Items.Add(FloatToStr(m));
  t:=Shaft.Torque(z,ltLeft);

  t:=Shaft.Torque(z);




end;


end;

procedure TForm1.Button4Click(Sender: TObject);
begin
//TreeView1.Items.AddChild(TreeView1.Selected,'Si³a skupiona');
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

procedure TForm1.FormCreate(Sender: TObject);

var
Lista:TList;
var Bitmap:TBitmap;
points: TAoD;
Node: TTreeNode ;
begin


 end;
procedure TForm1.UsunClick(Sender: TObject);
var
indeks: integer;
ok: Boolean;
begin
if TreeView1.Selected.Enabled=false then
    MessageDlg('Nie mo¿na usun¹æ',mtInformation,[mbOk],0)
else  begin
        TreeView1.Selected.Delete;



end;
 end;
end.
