unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, loads, Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    edtFx: TEdit;
    edtFy: TEdit;
    edtFz: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    edtZ: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    pnlBottom: TPanel;
  private
  public
    procedure Init(AForce: TForce = nil);
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Init(AForce: TForce);
begin
  edtFx.Text := '0';
  edtFy.Text := '0';
  edtFz.Text := '0';
  edtZ.Text := '0';

  if Assigned(AForce) then begin
    edtFx.Text := FloatToStr(AForce.Fx);
    edtFy.Text := FloatToStr(AForce.Fy);
    edtFz.Text := FloatToStr(AForce.Fz);
    edtZ.Text := FloatToStr(AForce.Z);
  end;
end;

end.
