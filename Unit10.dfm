object Form10: TForm10
  Left = 0
  Top = 0
  ActiveControl = rbDwukierunkowy
  BorderStyle = bsDialog
  Caption = 'Wyb'#243'r wsp'#243#322'czynnika redukcyjnego'
  ClientHeight = 152
  ClientWidth = 304
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object rbDwukierunkowy: TRadioButton
    Left = 16
    Top = 33
    Width = 385
    Height = 17
    Caption = 'Zmienny kierunek obrotu wa'#322'u (wsp. '#945' = '#8730'3 / 2)'
    TabOrder = 0
  end
  object rbJednokierunkowy: TRadioButton
    Left = 16
    Top = 73
    Width = 385
    Height = 17
    Caption = 'Sta'#322'y kierunek obrotu wa'#322'u (wsp. '#945' = '#8730'3 / 4)'
    TabOrder = 1
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 121
    Width = 304
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 148
    ExplicitWidth = 395
    object btnOK: TButton
      AlignWithMargins = True
      Left = 149
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 240
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 228
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'Anuluj'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 319
    end
  end
end
