unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,Loads;

type
  TForm5 = class(TForm)
    Label2: TLabel;
    Edit4: TEdit;
    Button1: TButton;
    Label5: TLabel;
    Edit5: TEdit;
    Label1: TLabel;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

uses Unit1, Unit2, Unit3, Unit4;

procedure TForm5.Button1Click(Sender: TObject);
var
f1: TTorque;
begin
Shaft.BeginUpdate;
  f1:=Shaft.AddTorque(StrToFloat(Edit4.Text),StrToFloat(Edit5.Text));
  Shaft.EndUpdate;
      Form1.TreeView1.Items.AddChild(Form1.TreeView1.Selected,'Wartoœæ : '+Edit4.Text);
      Form1.TreeView1.Items.AddChild(Form1.TreeView1.Selected,'Odleg³oœæ: '+Edit5.Text);

  ShowMessage('Moment skrêcaj¹cy  dodany');
  Shaft.EndUpdate;
  Form5.Close;
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
Form5.close;
end;

end.
