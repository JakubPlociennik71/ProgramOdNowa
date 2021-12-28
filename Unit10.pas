unit Unit10;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm10 = class(TForm)
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    pnlBottom: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure init(wspRed: double);
  end;

var
  Form10: TForm10;

implementation

{$R *.dfm}

uses Unit1, Unit2, Unit3, Unit4, Unit5, Unit6, Unit7, Unit8, Unit9,Loads;



procedure TForm10.init(wspRed: double);
begin

  RadioButton1.Checked:= Abs(wspRed-sqrt(3)/2)<0.01 ;
  RadioButton2.Checked:= Not RadioButton1.Checked ;

end;

end.
