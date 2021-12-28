unit Unit13;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm13 = class(TForm)
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    pnlBottom: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure init(naprezenia: boolean; napis: string);
  end;

var
  Form13: TForm13;

implementation

{$R *.dfm}

procedure TForm13.init(naprezenia: boolean; napis: string);
begin

  RadioButton1.Checked:= naprezenia=true;
  RadioButton2.Checked:= Not RadioButton1.Checked ;

  if RadioButton1.Checked then begin
    naprezenia:=true;
    napis:='Gn¹ce';


  end else begin
    naprezenia:=false;
    napis:='Skrêcaj¹ce';

  end;

end;

end.
