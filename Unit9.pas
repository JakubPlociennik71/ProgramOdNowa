unit Unit9;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm9 = class(TForm)
    Label1: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
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
  Form9: TForm9;

implementation

{$R *.dfm}

uses Unit1, Unit2, Unit3, Unit4, Unit5, Unit6, Unit7, Unit8,Loads;

procedure TForm9.Button1Click(Sender: TObject);
begin
  Shaft.BeginUpdate;
  Form1.safety_factor:=StrToFloat(edit1.Text);
  Form1.tvTree.Items.AddChild(Form1.tvTree.Selected,'Warto��: '+Edit1.Text);
  Form1.start:=Form1.start+1;
  Shaft.EndUpdate;
  if Form1.start=3 then

  Form9.Close;
end;

procedure TForm9.Button2Click(Sender: TObject);
begin
  Form9.close;
end;

end.
