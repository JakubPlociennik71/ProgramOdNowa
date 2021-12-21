unit Unit8;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,Loads, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm8 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Image1: TImage;
    Si³a: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}

uses Unit1, Unit2, Unit3, Unit4, Unit5, Unit6;



procedure TForm8.Button1Click(Sender: TObject);
 var
 skala1,skala2:double;
begin
var
i: integer;
skala1:=Abs((image1.Width/Shaft.ZPositions[Form1.d-1])-1);
skala2:=Abs((image1.Height/12)-10);
Image1.Picture.Bitmap.canvas.pen.color:=clRed;
for I := 0 to (Form1.d*2)-2  do  begin

    Image1.Picture.Bitmap.canvas.moveto(Trunc(skala1*Form1.sila_Y_x[i]),(Trunc(skala2*Form1.sila_Y_y[i])+Trunc(Image1.Height/2)));
    Image1.Picture.Bitmap.canvas.lineto(Trunc(skala1*Form1.sila_Y_x[i+1]),(Trunc(skala2*Form1.sila_Y_y[i+1])+Trunc(Image1.Height/2)));
end;

end;

procedure TForm8.FormCreate(Sender: TObject);
var Bitmap:TBitmap;
begin
 Bitmap:=TBitmap.create;
Bitmap.width:=300;
Bitmap.height:=200;
Image1.Picture.Graphic:=Bitmap;
Image1.width:=300;
Image1.height:=200;
Image1.Picture.Bitmap.canvas.pen.color:=clBlack;
  Image1.Picture.Bitmap.canvas.moveto(0,Trunc(Image1.Height/2));
  Image1.Picture.Bitmap.canvas.lineto(Image1.Width,Trunc(Image1.Height/2));
  Image1.Picture.Bitmap.canvas.moveto(0,0);
  Image1.Picture.Bitmap.canvas.lineto(0,Image1.Height);
end;

end.
