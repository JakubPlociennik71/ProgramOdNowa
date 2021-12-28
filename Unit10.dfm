object Form10: TForm10
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Wyb'#243'r wsp'#243#322'czynnika redukcyjnego'
  ClientHeight = 179
  ClientWidth = 395
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object RadioButton1: TRadioButton
    Left = 16
    Top = 33
    Width = 385
    Height = 17
    Caption = 
      'Zmienny kierunek obrotu wa'#322'u. Wsp'#243#322'czynnik r'#243'wna si'#281' pierwiastek' +
      ' z '#8730'3/2'
    TabOrder = 0
  end
  object RadioButton2: TRadioButton
    Left = 16
    Top = 73
    Width = 385
    Height = 17
    Caption = 
      'Sta'#322'y kierunek obrotu wa'#322'u. Wsp'#243#322'czynnik r'#243'wna si'#281' pierwiastek z' +
      ' '#8730'3/4'
    TabOrder = 1
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 148
    Width = 395
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 547
    object btnOK: TButton
      AlignWithMargins = True
      Left = 240
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 392
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 319
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'Anuluj'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 471
    end
  end
end
