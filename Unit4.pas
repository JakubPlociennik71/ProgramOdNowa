unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,Loads, Vcl.StdCtrls;

type
  TForm4 = class(TForm)
    Label2: TLabel;
    Edit4: TEdit;
    Button1: TButton;
    Label5: TLabel;
    Label6: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label1: TLabel;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

uses Unit1, Unit2, Unit3;

procedure TForm4.Button1Click(Sender: TObject);
var
f1: TMoment;
begin
Shaft.BeginUpdate;
  f1:=Shaft.AddMoment(StrToFloat(Edit4.Text),StrToFloat(Edit5.Text),StrToFloat(Edit6.Text));
  Shaft.EndUpdate;
      Form1.TreeView1.Items.AddChild(Form1.TreeView1.Selected,'Wartoœæ p³aszczyzna X: '+Edit4.Text);
      Form1.TreeView1.Items.AddChild(Form1.TreeView1.Selected,'Wartoœæ p³aszczyzna Y: '+Edit5.Text);
      Form1.TreeView1.Items.AddChild(Form1.TreeView1.Selected,'Odleg³oœæ od pocz¹tku wa³u: '+Edit6.Text);
  ShowMessage('Moment  dodany');
  Form4.Close;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
Form4.Close;
end;

end.
