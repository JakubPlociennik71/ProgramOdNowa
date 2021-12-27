unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Loads, Vcl.ExtCtrls;

type
  TForm3 = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    edtFx: TEdit;
    edtFy: TEdit;
    edtFz: TEdit;
    edtX: TEdit;
    pnlBottom: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    edtY: TEdit;
    Label5: TLabel;
    edtZ: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Init(AForce: TForce = nil);
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses Unit1, Unit2;





procedure TForm3.Init(AForce: TForce);
begin
  edtFx.Text := '0';
  edtFy.Text := '0';
  edtFz.Text := '0';
  edtX.Text := '0';
  edtY.Text := '0';
  edtZ.Text := '0';


  if Assigned(AForce) then begin
    edtFx.Text := FloatToStr(AForce.Fx);
    edtFy.Text := FloatToStr(AForce.Fy);
    edtFz.Text := FloatToStr(AForce.Fz);
    edtX.Text := FloatToStr(AForce.X);
    edtY.Text := FloatToStr(AForce.Y);
    edtZ.Text := FloatToStr(AForce.Z);


  end;
end;

end.
