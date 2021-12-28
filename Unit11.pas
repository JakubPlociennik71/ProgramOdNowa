unit Unit11;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm11 = class(TForm)
    Label3: TLabel;
    edtKg: TEdit;
    pnlBottom: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    edtKs: TEdit;
    Label2: TLabel;
    procedure Init(kg,ks: double);
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

procedure TForm11.Init(kg,ks: double);
begin
  edtKg.Text := FloatToStr(kg);
  edtKs.Text := FloatToStr(ks);
end;
end.
