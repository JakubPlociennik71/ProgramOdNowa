object Form11: TForm11
  Left = 0
  Top = 0
  ActiveControl = edtKg
  BorderStyle = bsToolWindow
  Caption = 'Napr'#281#380'enia dopuszczalne'
  ClientHeight = 102
  ClientWidth = 235
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 4
  Padding.Top = 4
  Padding.Right = 4
  Padding.Bottom = 4
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 7
    Top = 10
    Width = 88
    Height = 13
    Caption = 'Warto'#347#263'  kg [MPa]'
  end
  object Label2: TLabel
    Left = 7
    Top = 37
    Width = 87
    Height = 13
    Caption = 'Warto'#347#263'  ks [MPa]'
  end
  object edtKg: TEdit
    Left = 102
    Top = 7
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object pnlBottom: TPanel
    Left = 4
    Top = 67
    Width = 227
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 120
    ExplicitWidth = 242
    object btnOK: TButton
      AlignWithMargins = True
      Left = 72
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 87
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 151
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'Anuluj'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 166
    end
  end
  object edtKs: TEdit
    Left = 102
    Top = 34
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '0'
  end
end
