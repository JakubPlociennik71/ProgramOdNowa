object Form6: TForm6
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Po'#322'o'#380'enie podpory'
  ClientHeight = 79
  ClientWidth = 270
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 0
    Top = 11
    Width = 134
    Height = 13
    Caption = 'Odleg'#322'o'#347#263' od pocz'#261'tku wa'#322'u'
  end
  object edtZ: TEdit
    Left = 144
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 48
    Width = 270
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 133
    ExplicitWidth = 266
    object btnOK: TButton
      AlignWithMargins = True
      Left = 115
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 54
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 194
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'Anuluj'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 133
    end
  end
end
