unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, loads;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Edit4: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses Unit1;

procedure TForm2.Button1Click(Sender: TObject);
var
f1: TForce;
begin
Shaft.BeginUpdate;
  f1:=Shaft.AddForce(P3D(StrToFloat(Edit1.Text),StrToFloat(Edit2.Text),StrToFloat(Edit3.Text)),StrToFloat(Edit4.Text));
  Shaft.EndUpdate;
      Form1.TreeView1.Items.AddChild(Form1.TreeView1.Selected,'Wartoœæ p³aszczyzna X: '+Edit1.Text);
      Form1.TreeView1.Items.AddChild(Form1.TreeView1.Selected,'Wartoœæ p³aszczyzna Y: '+Edit2.Text);
      Form1.TreeView1.Items.AddChild(Form1.TreeView1.Selected,'Wartoœæ p³aszczyzna Z: '+Edit3.Text);
      Form1.TreeView1.Items.AddChild(Form1.TreeView1.Selected,'Odleg³oœæ od pocz¹tku wa³u: '+Edit4.Text);
  ShowMessage('Si³a dodana');
  Shaft.EndUpdate;
  Form2.Close;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
Form2.Close
end;

end.
