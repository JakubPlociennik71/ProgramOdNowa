unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Loads;

type
  TForm3 = class(TForm)
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
    Label5: TLabel;
    Label6: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses Unit1, Unit2;

procedure TForm3.Button1Click(Sender: TObject);
var
f1: TForce;
begin
Shaft.BeginUpdate;
  f1:=Shaft.AddForce(P3D(StrToFloat(Edit1.Text),StrToFloat(Edit2.Text),StrToFloat(Edit3.Text)),P3D(StrToFloat(Edit4.Text),StrToFloat(Edit5.Text),StrToFloat(Edit6.Text)));
  Shaft.EndUpdate;
      Form1.tvTree.Items.AddChild(Form1.tvTree.Selected,'Wartoœæ p³aszczyzna X: '+Edit1.Text);
      Form1.tvTree.Items.AddChild(Form1.tvTree.Selected,'Wartoœæ p³aszczyzna Y: '+Edit2.Text);
      Form1.tvTree.Items.AddChild(Form1.tvTree.Selected,'Wartoœæ p³aszczyzna Z: '+Edit3.Text);
      Form1.tvTree.Items.AddChild(Form1.tvTree.Selected,'Odleg³oœæ X: '+Edit4.Text);
       Form1.tvTree.Items.AddChild(Form1.tvTree.Selected,'Odleg³oœæ Y: '+Edit5.Text);
        Form1.tvTree.Items.AddChild(Form1.tvTree.Selected,'Odleg³oœæ Z: '+Edit6.Text);
  ShowMessage('Si³a dodana');

  Form3.Close;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
Form3.Close;
end;

end.
