object Form8: TForm8
  Left = 0
  Top = 0
  Caption = 'Form8'
  ClientHeight = 542
  ClientWidth = 876
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 40
    Top = 27
    Width = 800
    Height = 400
  end
  object Siła: TLabel
    Left = 8
    Top = 8
    Width = 37
    Height = 13
    Caption = 'Si'#322'a[kN]'
  end
  object Label4: TLabel
    Left = 846
    Top = 229
    Width = 22
    Height = 13
    Caption = 'x[m]'
  end
  object Label5: TLabel
    Left = 20
    Top = 414
    Width = 8
    Height = 13
    Caption = '+'
  end
  object Label6: TLabel
    Left = 24
    Top = 27
    Width = 4
    Height = 13
    Caption = '-'
  end
  object Button1: TButton
    Left = 8
    Top = 464
    Width = 89
    Height = 25
    Caption = 'Si'#322'y'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 128
    Top = 464
    Width = 89
    Height = 25
    Caption = 'Mom. Gn'#261'ce'
    TabOrder = 1
  end
  object Button3: TButton
    Left = 248
    Top = 464
    Width = 89
    Height = 25
    Caption = 'Mom. Skr'#281'caj'#261'ce'
    TabOrder = 2
  end
  object Button4: TButton
    Left = 376
    Top = 464
    Width = 89
    Height = 25
    Caption = 'Mom. Zredukowany'
    TabOrder = 3
  end
  object Button5: TButton
    Left = 512
    Top = 464
    Width = 89
    Height = 25
    Caption = #346'rednica'
    TabOrder = 4
  end
end
