object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Moment gn'#261'cy'
  ClientHeight = 159
  ClientWidth = 283
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 10
    Top = 65
    Width = 47
    Height = 13
    Caption = 'Odleg'#322'o'#347#263
  end
  object Label3: TLabel
    Left = 8
    Top = 8
    Width = 49
    Height = 13
    Caption = 'Warto'#347#263' X'
  end
  object Label4: TLabel
    Left = 8
    Top = 38
    Width = 49
    Height = 13
    Caption = 'Warto'#347#263' Y'
  end
  object edtFx: TEdit
    Left = 63
    Top = 5
    Width = 143
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object edtFy: TEdit
    Left = 63
    Top = 35
    Width = 143
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object edtZ: TEdit
    Left = 63
    Top = 62
    Width = 143
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 128
    Width = 283
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object btnOK: TButton
      AlignWithMargins = True
      Left = 128
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
      Left = 207
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
