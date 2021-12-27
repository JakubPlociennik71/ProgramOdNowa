object Form9: TForm9
  Left = 0
  Top = 0
  Caption = 'Form9'
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
    Width = 406
    Height = 24
    Caption = 'Wpisz warto'#347#263' wsp'#243#322'czynnika bezpiecze'#324'stwa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 20
    Top = 59
    Width = 144
    Height = 13
    Caption = 'Wsp'#243#322'czynnik bezpiecze'#324'stwa'
  end
  object Edit1: TEdit
    Left = 184
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object Button1: TButton
    Left = 337
    Top = 38
    Width = 120
    Height = 65
    Caption = 'Zapisz wsp'#243#322'czynnik'
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
    OnClick = Button2Click
  end
end
