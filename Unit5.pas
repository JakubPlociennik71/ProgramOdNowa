unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,Loads, Vcl.ExtCtrls;

type
  TForm5 = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    edtFx: TEdit;
    edtZ: TEdit;
    pnlBottom: TPanel;
    btnOK: TButton;
    btnCancel: TButton;

  private
    { Private declarations }
  public
    { Public declarations }
    procedure Init(ATorque: TTorque = nil);
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

uses Unit1, Unit2, Unit3, Unit4;




procedure TForm5.Init(ATorque: TTorque);
begin
  edtFx.Text := '0';
  edtZ.Text := '0';

  if Assigned(ATorque) then begin
    edtFx.Text := FloatToStr(ATorque.Torque);
    edtZ.Text := FloatToStr(ATorque.Z);
  end;
end;
end.
