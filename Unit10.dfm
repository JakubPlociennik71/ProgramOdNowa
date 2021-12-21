object Form10: TForm10
  Left = 0
  Top = 0
  Caption = 'Form10'
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
    Left = 16
    Top = 32
    Width = 519
    Height = 19
    Caption = 
      'Wybierz rodzaj redukcji stosowanej w obliczeniach momentu zast'#281'p' +
      'czego'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object RadioButton1: TRadioButton
    Left = 32
    Top = 72
    Width = 385
    Height = 17
    Caption = 
      'Obciazenie tego samego typu. Wsp'#243#322'czynnik r'#243'wna si'#281' pierwiastek ' +
      'z 3'
    TabOrder = 0
  end
  object RadioButton2: TRadioButton
    Left = 32
    Top = 112
    Width = 385
    Height = 17
    Caption = 
      'Obciazenie r'#243#380'nych typ'#243'w. Wsp'#243#322'czynnik r'#243'wna si'#281' pierwiastek z 3' +
      ' przez 2'
    TabOrder = 1
  end
  object RadioButton3: TRadioButton
    Left = 32
    Top = 152
    Width = 385
    Height = 17
    Caption = 
      'Obciazenie r'#243#380'nych typ'#243'w. Wsp'#243#322'czynnik r'#243'wna si'#281' dwa pierwiastki' +
      ' z 3'
    TabOrder = 2
  end
  object Button1: TButton
    Left = 430
    Top = 88
    Width = 105
    Height = 65
    Caption = 'Zatwierd'#378' wyb'#243'r'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 32
    Top = 232
    Width = 97
    Height = 41
    Caption = 'Zamknij'
    TabOrder = 4
    OnClick = Button2Click
  end
end
