unit Unit13;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm13 = class(TForm)
    rbGnace: TRadioButton;
    rbSkrecajace: TRadioButton;
    pnlBottom: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure init(naprezenia: boolean);
  end;

var
  Form13: TForm13;

implementation

{$R *.dfm}

procedure TForm13.init(naprezenia: boolean);
begin
  rbGnace.Checked := naprezenia;
  rbSkrecajace.Checked := not rbGnace.Checked;
end;

end.
