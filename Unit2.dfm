object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 20
    Top = 8
    Width = 132
    Height = 24
    Caption = 'Wpisz warto'#347'ci'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 20
    Top = 195
    Width = 47
    Height = 13
    Caption = 'Odleg'#322'o'#347#263
  end
  object Label3: TLabel
    Left = 20
    Top = 59
    Width = 49
    Height = 13
    Caption = 'Warto'#347#263' X'
  end
  object Label4: TLabel
    Left = 20
    Top = 107
    Width = 49
    Height = 13
    Caption = 'Warto'#347#263' Y'
  end
  object Label8: TLabel
    Left = 20
    Top = 155
    Width = 49
    Height = 13
    Caption = 'Warto'#347#263' Z'
  end
  object Edit1: TEdit
    Left = 88
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object Edit2: TEdit
    Left = 88
    Top = 104
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object Edit3: TEdit
    Left = 88
    Top = 152
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object Edit4: TEdit
    Left = 88
    Top = 192
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '0'
  end
  object Button1: TButton
    Left = 248
    Top = 103
    Width = 89
    Height = 65
    Caption = 'Dodaj si'#322#281
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 20
    Top = 232
    Width = 104
    Height = 43
    Caption = 'Zamknij'
    TabOrder = 5
    OnClick = Button2Click
  end
end
