object Form3: TForm3
  Left = 0
  Top = 0
  ActiveControl = edtFx
  BorderStyle = bsDialog
  Caption = 'Si'#322'a [kN]'
  ClientHeight = 199
  ClientWidth = 239
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
    Width = 75
    Height = 13
    Caption = 'Odleg'#322'o'#347#263' X [m]'
  end
  object Label3: TLabel
    Left = 0
    Top = 8
    Width = 72
    Height = 13
    Caption = 'Warto'#347#263' X [kN]'
  end
  object Label4: TLabel
    Left = 0
    Top = 35
    Width = 72
    Height = 13
    Caption = 'Warto'#347#263' Y [kN]'
  end
  object Label8: TLabel
    Left = 0
    Top = 63
    Width = 72
    Height = 13
    Caption = 'Warto'#347#263' Z [kN]'
  end
  object Label1: TLabel
    Left = 1
    Top = 116
    Width = 75
    Height = 13
    Caption = 'Odleg'#322'o'#347#263' Y [m]'
  end
  object Label5: TLabel
    Left = 1
    Top = 143
    Width = 75
    Height = 13
    Caption = 'Odleg'#322'o'#347#263' Z [m]'
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
    Top = 168
    Width = 239
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    object btnOK: TButton
      AlignWithMargins = True
      Left = 84
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
      Left = 163
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'Anuluj'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object edtY: TEdit
    Left = 79
    Top = 113
    Width = 143
    Height = 21
    TabOrder = 4
    Text = '0'
  end
  object edtZ: TEdit
    Left = 79
    Top = 140
    Width = 143
    Height = 21
    TabOrder = 5
    Text = '0'
  end
end
