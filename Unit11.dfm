object Form11: TForm11
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Napr'#281#380'enia dopuszczalne'
  ClientHeight = 155
  ClientWidth = 250
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
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 7
    Top = 7
    Width = 89
    Height = 13
    Caption = 'Warto'#347#263'  kg [MPA]'
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
    Top = 120
    Width = 242
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 76
    ExplicitWidth = 530
    object btnOK: TButton
      AlignWithMargins = True
      Left = 87
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 375
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 166
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'Anuluj'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 454
    end
  end
  object edtKs: TEdit
    Left = 102
    Top = 34
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '0'
  end
end
