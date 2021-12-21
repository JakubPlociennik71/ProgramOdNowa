unit Unit10;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm10 = class(TForm)
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form10: TForm10;

implementation

{$R *.dfm}

uses Unit1, Unit2, Unit3, Unit4, Unit5, Unit6, Unit7, Unit8, Unit9;

procedure TForm10.Button1Click(Sender: TObject);
begin

if RadioButton1.Checked = true then begin
 Form1.reduction:=sqrt(3);
 Form1.TreeView1.Items.AddChild(Form1.TreeView1.Selected,'Pierwiastek z 3');
 Form10.Close;
end ;
if RadioButton2.Checked = true then
begin
 Form1.reduction:=sqrt(3)/2;
 Form1.TreeView1.Items.AddChild(Form1.TreeView1.Selected,'Pierwiastek z 3 przez 2');
  Form10.Close;

end;
 if RadioButton3.Checked = true then begin

 Form1.reduction:=sqrt(3)*2;
 Form1.TreeView1.Items.AddChild(Form1.TreeView1.Selected,'Pierwiastek dwa pierwiastki z 3');
  Form10.Close;
end;

end;

procedure TForm10.Button2Click(Sender: TObject);
begin
Form10.Close;
end;

end.
