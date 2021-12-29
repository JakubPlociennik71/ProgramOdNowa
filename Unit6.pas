unit Unit6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Loads, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm6 = class(TForm)
    edtZ: TEdit;
    Label3: TLabel;
    pnlBottom: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
  private
    { Private declarations }
  public
    procedure Init(AZ: Double);
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

{ TForm6 }

procedure TForm6.Init(AZ: Double);
begin
  Position := poMainFormCenter;
  edtZ.Text := FloatToStr(AZ);
end;

end.
