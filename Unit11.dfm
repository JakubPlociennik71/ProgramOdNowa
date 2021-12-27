object Form11: TForm11
  Left = 0
  Top = 0
  Caption = 'Form11'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 20
    Top = 8
    Width = 581
    Height = 19
    Caption = 
      'Wpisz warto'#347#263'  dopuszczalnych napr'#281#380'e'#324' materia'#322'u z jakiego ma by' +
      ' wykonany wa'#322
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 20
    Top = 59
    Width = 43
    Height = 13
    Caption = 'Warto'#347#263' '
  end
  object Edit1: TEdit
    Left = 88
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object Button1: TButton
    Left = 215
    Top = 33
    Width = 89
    Height = 65
    Caption = 'Wpisz warto'#347#263
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 20
    Top = 232
    Width = 104
    Height = 43
    Caption = 'Zamknij'
    TabOrder = 2
  end
end
