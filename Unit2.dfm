object Form2: TForm2
  Left = 0
  Top = 0
  ActiveControl = edtFx
  BorderStyle = bsDialog
  Caption = 'Si'#322'a'
  ClientHeight = 158
  ClientWidth = 230
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
    Left = 2
    Top = 89
    Width = 66
    Height = 13
    Caption = 'Odleg'#322'o'#347#263' [m]'
  end
  object Label3: TLabel
    Left = 0
    Top = 8
    Width = 65
    Height = 13
    Caption = 'Warto'#347#263' X[m]'
  end
  object Label4: TLabel
    Left = 0
    Top = 35
    Width = 65
    Height = 13
    Caption = 'Warto'#347#263' Y[m]'
  end
  object Label8: TLabel
    Left = 0
    Top = 63
    Width = 68
    Height = 13
    Caption = 'Warto'#347#263' Z [m]'
  end
  object edtFx: TEdit
    Left = 71
    Top = 5
    Width = 143
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object edtFy: TEdit
    Left = 71
    Top = 32
    Width = 143
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object edtFz: TEdit
    Left = 71
    Top = 59
    Width = 143
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object edtZ: TEdit
    Left = 71
    Top = 86
    Width = 143
    Height = 21
    TabOrder = 3
    Text = '0'
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 127
    Width = 230
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    ExplicitWidth = 209
    object btnOK: TButton
      AlignWithMargins = True
      Left = 75
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
      Left = 154
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
