object Form5: TForm5
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Moment skr'#281'caj'#261'cy'
  ClientHeight = 170
  ClientWidth = 313
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
    Left = 10
    Top = 41
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
  object edtFx: TEdit
    Left = 63
    Top = 5
    Width = 143
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object edtZ: TEdit
    Left = 63
    Top = 38
    Width = 143
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 139
    Width = 313
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 129
    ExplicitWidth = 303
    object btnOK: TButton
      AlignWithMargins = True
      Left = 158
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 148
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 237
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'Anuluj'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 227
    end
  end
end
