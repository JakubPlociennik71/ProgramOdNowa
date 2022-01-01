unit Unit10;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm10 = class(TForm)
    rbDwukierunkowy: TRadioButton;
    rbJednokierunkowy: TRadioButton;
    pnlBottom: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Init(AWspRed: Double);
  end;

var
  Form10: TForm10;

implementation

{$R *.dfm}

procedure TForm10.Init(AWspRed: Double);
begin
  Position := poMainFormCenter;
  rbDwukierunkowy.Checked := Abs(AWspRed - sqrt(3)) < 0.01;
  rbJednokierunkowy.Checked := not rbDwukierunkowy.Checked;
end;

end.
