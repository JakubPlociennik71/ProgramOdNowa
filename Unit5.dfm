object Form5: TForm5
  Left = 0
  Top = 0
  ActiveControl = edtTorque
  BorderStyle = bsDialog
  Caption = 'Moment skr'#281'caj'#261'cy [kNm]'
  ClientHeight = 97
  ClientWidth = 252
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
    Left = 8
    Top = 41
    Width = 66
    Height = 13
    Caption = 'Odleg'#322'o'#347#263' [m]'
  end
  object Label3: TLabel
    Left = 8
    Top = 8
    Width = 71
    Height = 13
    Caption = 'Warto'#347#263' [kNm]'
  end
  object edtTorque: TEdit
    Left = 101
    Top = 8
    Width = 143
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object edtZ: TEdit
    Left = 101
    Top = 39
    Width = 143
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 66
    Width = 252
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 218
    object btnOK: TButton
      AlignWithMargins = True
      Left = 97
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 63
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 176
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'Anuluj'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 142
    end
  end
end
