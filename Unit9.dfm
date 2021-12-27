object Form9: TForm9
  Left = 0
  Top = 0
  Caption = 'Wsp'#243#322'czynnik bezpiecze'#324'stwa'
  ClientHeight = 167
  ClientWidth = 303
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 8
    Top = 27
    Width = 144
    Height = 13
    Caption = 'Wsp'#243#322'czynnik bezpiecze'#324'stwa'
  end
  object Edit1: TEdit
    Left = 172
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 136
    Width = 303
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 8
    object btnOK: TButton
      AlignWithMargins = True
      Left = 148
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 227
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'Anuluj'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
