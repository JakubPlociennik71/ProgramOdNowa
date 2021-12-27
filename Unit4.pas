unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,Loads, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm4 = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtFx: TEdit;
    edtFy: TEdit;
    edtZ: TEdit;
    pnlBottom: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Init(AMoment: TMoment = nil);
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

uses Unit1, Unit2, Unit3;



procedure TForm4.Init(AMoment: TMoment);
begin
  edtFx.Text := '0';
  edtFy.Text := '0';
  edtZ.Text := '0';

  if Assigned(AMoment) then begin
    edtFx.Text := FloatToStr(AMoment.MomentX);
    edtFy.Text := FloatToStr(AMoment.MomentY);
    edtZ.Text := FloatToStr(AMoment.Z);
  end;
end;

end.
