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
    procedure btnOKClick(Sender: TObject);
  private
  public
    procedure Init(AForce: TForce = nil);
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses Unit1;

procedure TForm2.btnOKClick(Sender: TObject);
//var
//  f1: TForce;
begin
//  Shaft.BeginUpdate;
//
//  f1:=Shaft.AddForce(P3D(StrToFloat(Edit1.Text),StrToFloat(Edit2.Text),StrToFloat(Edit3.Text)),StrToFloat(Edit4.Text));
//
//  Shaft.EndUpdate;
//  Form1.tvTree.Items.AddChild(Form1.tvTree.Selected,'Wartoœæ p³aszczyzna X: '+Edit1.Text);
//  Form1.tvTree.Items.AddChild(Form1.tvTree.Selected,'Wartoœæ p³aszczyzna Y: '+Edit2.Text);
//  Form1.tvTree.Items.AddChild(Form1.tvTree.Selected,'Wartoœæ p³aszczyzna Z: '+Edit3.Text);
//  Form1.tvTree.Items.AddChild(Form1.tvTree.Selected,'Odleg³oœæ od pocz¹tku wa³u: '+Edit4.Text);
//  ShowMessage('Si³a dodana');
//
//  Form2.Close;
end;

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
