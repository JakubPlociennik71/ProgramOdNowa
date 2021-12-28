object Form10: TForm10
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Wsp'#243#322'czynnik redukcyjny'
  ClientHeight = 179
  ClientWidth = 547
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
  object Label1: TLabel
    Left = 8
    Top = 8
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
    Left = 16
    Top = 33
    Width = 385
    Height = 17
    Caption = 
      'Obciazenie tego samego typu. Wsp'#243#322'czynnik r'#243'wna si'#281' pierwiastek ' +
      'z 3'
    TabOrder = 0
  end
  object RadioButton2: TRadioButton
    Left = 16
    Top = 73
    Width = 385
    Height = 17
    Caption = 
      'Obciazenie r'#243#380'nych typ'#243'w. Wsp'#243#322'czynnik r'#243'wna si'#281' pierwiastek z 3' +
      ' przez 2'
    TabOrder = 1
  end
  object RadioButton3: TRadioButton
    Left = 16
    Top = 113
    Width = 385
    Height = 17
    Caption = 
      'Obciazenie r'#243#380'nych typ'#243'w. Wsp'#243#322'czynnik r'#243'wna si'#281' dwa pierwiastki' +
      ' z 3'
    TabOrder = 2
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 148
    Width = 547
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitTop = 138
    ExplicitWidth = 537
    object btnOK: TButton
      AlignWithMargins = True
      Left = 392
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 382
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 471
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'Anuluj'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 461
    end
  end
end
