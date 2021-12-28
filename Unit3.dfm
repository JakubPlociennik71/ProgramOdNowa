object Form3: TForm3
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Si'#322#261' poza wa'#322'em'
  ClientHeight = 212
  ClientWidth = 289
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
  object Label2: TLabel
    Left = 1
    Top = 89
    Width = 56
    Height = 13
    Caption = 'Odleg'#322'o'#347#263' X'
  end
  object Label3: TLabel
    Left = 0
    Top = 8
    Width = 49
    Height = 13
    Caption = 'Warto'#347#263' X'
  end
  object Label4: TLabel
    Left = 0
    Top = 35
    Width = 49
    Height = 13
    Caption = 'Warto'#347#263' Y'
  end
  object Label8: TLabel
    Left = 0
    Top = 63
    Width = 49
    Height = 13
    Caption = 'Warto'#347#263' Z'
  end
  object Label1: TLabel
    Left = 1
    Top = 116
    Width = 56
    Height = 13
    Caption = 'Odleg'#322'o'#347#263' Y'
  end
  object Label5: TLabel
    Left = 1
    Top = 143
    Width = 56
    Height = 13
    Caption = 'Odleg'#322'o'#347#263' Z'
  end
  object edtFx: TEdit
    Left = 79
    Top = 5
    Width = 143
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object edtFy: TEdit
    Left = 79
    Top = 32
    Width = 143
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object edtFz: TEdit
    Left = 79
    Top = 59
    Width = 143
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object edtX: TEdit
    Left = 79
    Top = 86
    Width = 143
    Height = 21
    TabOrder = 3
    Text = '0'
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 181
    Width = 289
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    ExplicitTop = 171
    ExplicitWidth = 279
    object btnOK: TButton
      AlignWithMargins = True
      Left = 134
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 124
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 213
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'Anuluj'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 203
    end
  end
  object edtY: TEdit
    Left = 79
    Top = 113
    Width = 143
    Height = 21
    TabOrder = 5
    Text = '0'
  end
  object edtZ: TEdit
    Left = 79
    Top = 140
    Width = 143
    Height = 21
    TabOrder = 6
    Text = '0'
  end
end
