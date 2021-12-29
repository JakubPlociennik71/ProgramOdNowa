object Form2: TForm2
  Left = 0
  Top = 0
  ActiveControl = edtFx
  BorderStyle = bsDialog
  Caption = 'Si'#322'a'
  ClientHeight = 158
  ClientWidth = 209
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 2
    Top = 89
    Width = 47
    Height = 13
    Caption = 'Odleg'#322'o'#347#263
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
    Top = 32
    Width = 143
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object edtFz: TEdit
    Left = 63
    Top = 59
    Width = 143
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object edtZ: TEdit
    Left = 63
    Top = 86
    Width = 143
    Height = 21
    TabOrder = 3
    Text = '0'
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 127
    Width = 209
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object btnOK: TButton
      AlignWithMargins = True
      Left = 54
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
      Left = 133
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
