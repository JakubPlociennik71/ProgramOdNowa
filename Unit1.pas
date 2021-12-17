unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.StdActns, Vcl.Menus, System.Actions, Vcl.ActnList, Vcl.ToolWin,
  System.ImageList, Vcl.ImgList, Vcl.ExtActns;

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
    edt1: TRichEdit;

    procedure Button2Click(Sender: TObject);
    procedure UsunClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
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

procedure TForm1.FormCreate(Sender: TObject);

var
Lista:TList;
begin
  Lista:=TList.Create;

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
