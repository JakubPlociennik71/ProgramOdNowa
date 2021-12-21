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
    Image1: TImage;
    Label4: TLabel;
    Label5: TLabel;
    Si³a: TLabel;
    Label6: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Image2: TImage;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label11: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    v: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label22: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Wspczynnikbezpieczestwa1: TMenuItem;
    Wybrwspczynnikaredukujcego1: TMenuItem;


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
  private
    { Private declarations }
  public
    { Public declarations }
   sila_Y_x: array of Double;
    sila_Y_y:array of Double;
    sila_X_x: array of Double;
    sila_X_y: array of Double;
    sila_x: array of Double;
    sila_y: array of Double;
    moment_y: array of double;
    torque_y: array of double;
    diameter_y: array of double;
    safety_factor: double;
    reduction: double;
    d: integer;
    points: TAoD;
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

uses Unit2, Unit3, Unit4, Unit5, Unit6, Unit7, Unit8, Unit9, Unit10;



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
f1,f2: TForce;
z,s,m,t,skala1,skala2,skalaF,skalaY,skalaX,skalaM,skalaTor,skalaRed,skalaD,max: double;
licznik,i:integer;

begin
//Form8.Show;


Shaft.BeginUpdate;
Shaft.SupportB.Z:=6;
f1:=Shaft.AddForce(P3D(0,-15,0),2);
f2:=Shaft.AddForce(P3D(0,-8,0),4);
Shaft.EndUpdate;


points:=Shaft.ZPositions;
d:=length(points);
SetLength(sila_Y_x,2*d);
SetLength(sila_Y_y,2*d) ;
SetLength(sila_X_x,2*d);
SetLength(sila_X_y,2*d) ;
SetLength(sila_x,2*d);
SetLength(sila_y,2*d) ;
SetLength(moment_y,2*d) ;
SetLength(torque_y,2*d);
licznik:=0;
for z in points do begin

    s:=Shaft.ShearY(z,ltLeft);

    sila_Y_y[licznik]:=Shaft.ShearY(z,ltLeft);
    sila_Y_x[licznik]:=z;
    //ListBox1.Items.Add(FloatToStr(sila_Y_x[licznik])+' '+FloatToStr(sila_Y_y[licznik]));
    sila_X_y[licznik]:=Shaft.ShearX(z,ltLeft);
    sila_X_x[licznik]:=z;

    sila_y[licznik]:=Shaft.Shear(z,ltLeft);
    sila_x[licznik]:=z;

     moment_y[licznik]:=Shaft.Moment(z,ltLeft);
     torque_y[licznik]:=Shaft.Torque(z,ltLeft);


     licznik:=licznik+1;
   s:=Shaft.ShearY(z);
    sila_Y_y[licznik]:=Shaft.ShearY(z);
    sila_Y_x[licznik]:=z;
     //ListBox1.Items.Add(FloatToStr(sila_Y_x[licznik])+' '+FloatToStr(sila_Y_y[licznik]));
     sila_X_y[licznik]:=Shaft.ShearX(z);
    sila_X_x[licznik]:=z;

    sila_y[licznik]:=Shaft.Shear(z);
    sila_x[licznik]:=z;

    moment_y[licznik]:= Shaft.Moment(z);
     torque_y[licznik]:= Shaft.Torque(z);



    licznik:=licznik+1;




  m:=Shaft.Moment(z,ltLeft);

  m:=Shaft.Moment(z);

  t:=Shaft.Torque(z,ltLeft);

  t:=Shaft.Torque(z);




end;
 skala1:=Abs((300/Shaft.ZPositions[Form1.d-1])-1);

 if Find_Max(Form1.sila_Y_Y,2*d)=0 then skalaY:=0.1
else  skalaY:=Abs((200/Find_Max(Form1.sila_Y_y,d))-10);




if Find_Max(Form1.sila_X_Y,2*d)=0 then skalaX:=0.1
else skalaX:=Abs((200/Find_Max(Form1.sila_X_y,2*d))-10);


if Find_Max(Form1.sila_Y,2*d)=0 then skalaF:=0.1
else skalaF:=Abs((200/Find_Max(Form1.sila_Y,2*d))-10);

if Find_Max( moment_y,2*d)=0 then skalaM:=0.1
else skalaM:=Abs((200/Find_Max(moment_y,2*d))-10);

if Find_Max( torque_y,2*d)=0 then skalaTor:=0.1
else skalaTor:=Abs((200/Find_Max(torque_y,2*d))-10);





Image1.Picture.Bitmap.canvas.pen.color:=clRed;
for I := 0 to (Form1.d*2)-2  do  begin

    Image1.Picture.Bitmap.canvas.moveto(Trunc(skala1*Form1.sila_Y_x[i]),(Trunc(skalaY*Form1.sila_Y_y[i])+Trunc(200/2)));
    Image1.Picture.Bitmap.canvas.lineto(Trunc(skala1*Form1.sila_Y_x[i+1]),(Trunc(skalaY*Form1.sila_Y_y[i+1])+Trunc(200/2)));

    Image1.Picture.Bitmap.canvas.moveto(Trunc(skala1*Form1.sila_X_x[i]),(Trunc(skalaX*Form1.sila_X_y[i])+Trunc(300)));
    Image1.Picture.Bitmap.canvas.lineto(Trunc(skala1*Form1.sila_X_x[i+1]),(Trunc(skalaX*Form1.sila_X_y[i+1])+Trunc(300)));

    Image1.Picture.Bitmap.canvas.moveto(Trunc(skala1*Form1.sila_x[i]),(Trunc(skalaF*Form1.sila_y[i])+Trunc(500)));
    Image1.Picture.Bitmap.canvas.lineto(Trunc(skala1*Form1.sila_x[i+1]),(Trunc(skalaF*Form1.sila_y[i+1])+Trunc(500)));

    Image1.Picture.Bitmap.canvas.moveto(Trunc(skala1*Form1.sila_x[i]),(Trunc(skalaM*moment_y[i])+Trunc(700)));
    Image1.Picture.Bitmap.canvas.lineto(Trunc(skala1*Form1.sila_x[i+1]),(Trunc(skalaM*moment_y[i+1])+Trunc(700)));

    Image1.Picture.Bitmap.canvas.moveto(Trunc(skala1*Form1.sila_x[i]),(Trunc(skalaTor*torque_y[i])+Trunc(900)));
    Image1.Picture.Bitmap.canvas.lineto(Trunc(skala1*Form1.sila_x[i+1]),(Trunc(skalaTor*torque_y[i+1])+Trunc(900)));


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
 Bitmap:=TBitmap.create;
Bitmap.width:=300;
Bitmap.height:=2000;
Image1.Picture.Graphic:=Bitmap;
Image1.width:=300;
Image1.height:=2000;
Image1.Picture.Bitmap.canvas.pen.color:=clBlack;
Image1.Picture.Bitmap.canvas.moveto(0,0);
  Image1.Picture.Bitmap.canvas.lineto(0,2000);

  Image1.Picture.Bitmap.canvas.moveto(0,Trunc(100));
  Image1.Picture.Bitmap.canvas.lineto(300,Trunc(100));

    Image1.Picture.Bitmap.canvas.moveto(0,Trunc(300));
  Image1.Picture.Bitmap.canvas.lineto(300,Trunc(300));


   Image1.Picture.Bitmap.canvas.moveto(0,Trunc(500));
  Image1.Picture.Bitmap.canvas.lineto(300,Trunc(500));

  Image1.Picture.Bitmap.canvas.moveto(0,Trunc(700));
  Image1.Picture.Bitmap.canvas.lineto(300,Trunc(700));

  Image1.Picture.Bitmap.canvas.moveto(0,Trunc(900));
  Image1.Picture.Bitmap.canvas.lineto(300,Trunc(900));

  Image1.Picture.Bitmap.canvas.moveto(0,Trunc(1100));
  Image1.Picture.Bitmap.canvas.lineto(300,Trunc(1100));

   Image1.Picture.Bitmap.canvas.moveto(0,Trunc(1300));
  Image1.Picture.Bitmap.canvas.lineto(300,Trunc(1300));

   Image1.Picture.Bitmap.canvas.moveto(0,Trunc(1500));
  Image1.Picture.Bitmap.canvas.lineto(300,Trunc(1500));

   Image1.Picture.Bitmap.canvas.moveto(0,Trunc(1700));
  Image1.Picture.Bitmap.canvas.lineto(300,Trunc(1700));

   Image1.Picture.Bitmap.canvas.moveto(0,Trunc(1900));
  Image1.Picture.Bitmap.canvas.lineto(300,Trunc(1900));
{Image1.Picture.Bitmap.canvas.pen.color:=clBlack;
  Image1.Picture.Bitmap.canvas.moveto(0,Trunc(Image1.Height/2));
  Image1.Picture.Bitmap.canvas.lineto(Image1.Width,Trunc(Image1.Height/2));
  Image1.Picture.Bitmap.canvas.moveto(0,0);
  Image1.Picture.Bitmap.canvas.lineto(0,Image1.Height); }


ListBox1.Items.Add('Wyniki Obliczeñ: ');

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
procedure TForm1.Wspczynnikbezpieczestwa1Click(Sender: TObject);
var
  Node: TTreeNode ;
begin
Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Wspó³czynnik bezpieczeñstwa');
      Node.Selected:=True;
      Node.editText;
Form9.Show;
end;

procedure TForm1.Wybrwspczynnikaredukujcego1Click(Sender: TObject);
var
 Node: TTreeNode ;
begin
Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Wspólczynnik redukuj¹cy');
      Node.Selected:=True;
      Node.editText;
Form10.Show;
end;

end.
