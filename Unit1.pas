unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.StdActns, Vcl.Menus, System.Actions, Vcl.ActnList, Vcl.ToolWin,
  System.ImageList, Vcl.ImgList, Vcl.ExtActns, Loads;

type
  TForm1 = class(TForm)
    TreeView1: TTreeView;
    Button2: TButton;
    Usun: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
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
    Button1: TButton;
    edtReport: TRichEdit;
    btn1: TButton;

    procedure Button2Click(Sender: TObject);
    procedure UsunClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    procedure CalculationsChanged(Sender: TObject);
  public
    { Public declarations }
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

procedure TForm1.btn1Click(Sender: TObject);
var
  points: TAoD;
  z, s, m, t: Double;
  f1, f2: TForce;
begin
  Shaft.Clear;
  Shaft.BeginUpdate;
  Shaft.PlaceSupports(0.5, 1.5);
  Shaft.AddForce(P3D(0, -2, 0), 0);
  Shaft.AddForce(P3D(0, -1, 1), 1);
  Shaft.AddForce(P3D(0, -1, 0), 2);
  Shaft.AddForce(0.3, 0.5, 0.1, 1, 30, 1);
  Shaft.EndUpdate;

  points := Shaft.ZPositions;
  for z in points do begin
    s := Shaft.ShearY(z, ltLeft);
    m := Shaft.MomentY(z, ltLeft);
    t := Shaft.Torque(z, ltLeft);

    s := Shaft.ShearY(z);
    m := Shaft.MomentY(z);
    t := Shaft.Torque(z);

    f1 := f1;
  end;


//  // zmieniam po³o¿enie podpór
//  Shaft.BeginUpdate;
//
////  Shaft.Angular.Z := 1;
////  Shaft.Radial.Z := 0;
//  Shaft.RadialReaction.Z := 3;
//  Shaft.AddTorque(1, 1);
//  Shaft.AddForce(P3D(-1, 0, 0), P3D(0, 1, 2));
//  Shaft.EndUpdate;
//
////  Shaft[0].Z := 2.5;
//  f1 := Shaft.AddForce(P3D(5, 0, 0), P3D(0, 0, 0.5));
//  Shaft.DeleteLoad(f);
//
//  // niebezpieczne przekroje
//  t := Shaft.RadialReaction.Force.X;
//  points := Shaft.ZPositions;
//  for z in points do begin
//    s := Shaft.Shear(z, ltLeftLimit);
//    s := Shaft.Shear(z);
//    m := Shaft.Moment(z, ltLeftLimit);
//    m := Shaft.Moment(z);
//    t := Shaft.Torque(z, ltLeftLimit);
//    t := Shaft.Torque(z);
//  end;

//  // zmieniam po³o¿enie podpór
//  Shaft.BeginUpdate;
//  Shaft.Radial.Z := 6;
//  Shaft.AddForce(P3D(-15, 0), P3D(2));
//  Shaft.AddForce(P3D(-6, 0), P3D(4));
//  Shaft.EndUpdate;
//
//  // niebezpieczne przekroje
//  points := Shaft.ZPositions;
//  for z in points do begin
//    s := Shaft.ShearX(z, ltLeftLimit);
//    s := Shaft.ShearX(z, ltRightLimit);
//
//    m := Shaft.MomentX(z, ltLeftLimit);
//    m := Shaft.MomentX(z, ltRightLimit);
//  end;

//  // dodajê si³y
//  Shaft.Clear;
//  Shaft.Radial.Z := 2;
//  Shaft.AddForce(P3D(0, 0, 1), P3D(1, 0, 1));
//  Shaft.AddMoment(-1, 0, 1.5);
//
//  // niebezpieczne przekroje
//  points := Shaft.ZPositions;
//  for z in points do begin
//    s := Shaft.ShearX(z, ltLeftLimit);
//    s := Shaft.ShearX(z);
//
//    m := Shaft.MomentX(z, ltLeftLimit);
//    m := Shaft.MomentX(z);
//  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Node: TTreeNode ;
begin
  Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Nowe obci¹zenie');
  Node.Selected:=True;
  Node.editText;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Node: TTreeNode ;
  note: Obciazenie;
begin
      note:= Obciazenie.Create;
      note.odleglosc:= StrToFloat(Edit1.Text);
      note.silaX:=StrToFloat(Edit2.Text);
      note.SilaY:=StrToFloat(Edit3.Text);
      Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Odleg³oœæ od pocz¹tku wa³u: '+Edit1.Text);
      Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Wartoœæ p³aszczyzna X: '+Edit1.Text);
      Node:=TreeView1.Items.AddChild(TreeView1.Selected,'Wartoœæ p³aszczyzna Y: '+Edit1.Text);
      Node.Selected:=True;
      Node.editText;
end;

var
  fCount: Integer = 0;

procedure TForm1.CalculationsChanged(Sender: TObject);
begin
  Inc(fCount);

  Caption := IntToStr(fCount);
end;

procedure TForm1.FormCreate(Sender: TObject);

var
Lista:TList;
begin
  Shaft.OnChange := CalculationsChanged;

  Lista:=TList.Create;


  Lista.Free;
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
