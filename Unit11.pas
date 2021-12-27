unit Unit11;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm11 = class(TForm)
    Label1: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form11: TForm11;

implementation

{$R *.dfm}

uses Diagrams, Loads, Unit1, Unit10, Unit2, Unit3, Unit4, Unit5, Unit6, Unit7,
  Unit8, Unit9;

procedure TForm11.Button1Click(Sender: TObject);
begin
  Shaft.BeginUpdate;
  Form1.naprezenia:=StrToFloat(edit1.Text);
  Form1.tvTree.Items.AddChild(Form1.tvTree.Selected,'Wartoœæ: '+Edit1.Text);
  Form1.start:=Form1.start+1;
  Shaft.EndUpdate;
  
  Form11.Close;
end;

end.
