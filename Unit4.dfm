object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
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
  object Label2: TLabel
    Left = 20
    Top = 70
    Width = 49
    Height = 13
    Caption = 'Warto'#347#263' X'
  end
  object Label5: TLabel
    Left = 20
    Top = 123
    Width = 49
    Height = 13
    Caption = 'Warto'#347#263' Y'
  end
  object Label6: TLabel
    Left = 20
    Top = 171
    Width = 50
    Height = 13
    Caption = 'Odleg'#322'o'#347#263' '
  end
  object Label1: TLabel
    Left = 20
    Top = 16
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
  object Edit4: TEdit
    Left = 120
    Top = 67
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object Button1: TButton
    Left = 282
    Top = 98
    Width = 89
    Height = 65
    Caption = 'Dodaj moment'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit5: TEdit
    Left = 120
    Top = 120
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object Edit6: TEdit
    Left = 120
    Top = 168
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '0'
  end
  object Button2: TButton
    Left = 20
    Top = 232
    Width = 104
    Height = 43
    Caption = 'Zamknij'
    TabOrder = 4
    OnClick = Button2Click
  end
end
