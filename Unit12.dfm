object Form12: TForm12
  Left = 0
  Top = 0
  Caption = 
    'Podaj '#347'cie'#380'ke i nazw'#281' pliku, gdzie maj'#261' by'#263' zapisane wyniki obli' +
    'cze'#324
  ClientHeight = 99
  ClientWidth = 297
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 233
    Height = 21
    TabOrder = 0
    Text = '\wyniki.txt'
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 68
    Width = 297
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 209
    object btnOK: TButton
      AlignWithMargins = True
      Left = 142
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
      Left = 221
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
