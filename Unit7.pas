unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,Loads, Vcl.StdCtrls;

type
  TForm7 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
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
  Form7: TForm7;

implementation

{$R *.dfm}

uses Unit1, Unit2, Unit3, Unit4, Unit5, Unit6;

procedure TForm7.Button1Click(Sender: TObject);
begin
Shaft.BeginUpdate;
  Shaft.SupportA.Z:=StrToFloat(Edit1.text);
  Shaft.EndUpdate;
      Form1.TreeView1.Items.AddChild(Form1.TreeView1.Selected,'Odleg³oœæ  od pocz¹tku wa³u: '+Edit1.Text);

  ShowMessage('Podpora zosta³a przesuniêta');

  Form7.Close;
end;

procedure TForm7.Button2Click(Sender: TObject);
begin
Form7.Close;
end;

end.
