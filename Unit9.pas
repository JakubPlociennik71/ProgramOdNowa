unit Unit9;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm9 = class(TForm)
    Label3: TLabel;
    Edit1: TEdit;
    pnlBottom: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Init(s: double);
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
  Form1.tvTree.Items.AddChild(Form1.tvTree.Selected,'Wartoœæ: '+Edit1.Text);
  Form1.start:=Form1.start+1;
  Shaft.EndUpdate;
  if Form1.start=3 then

  Form9.Close;
end;

procedure TForm9.Button2Click(Sender: TObject);
begin
  Form9.close;
end;

procedure TForm9.Init(s: double);
begin
  edit1.Text := '0';


    edit1.Text := FloatToStr(s);


end;
end.
