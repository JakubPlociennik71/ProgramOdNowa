object Form4: TForm4
  Left = 0
  Top = 0
  ActiveControl = edtMomentX
  BorderStyle = bsDialog
  Caption = 'Moment gn'#261'cy [kNm]'
  ClientHeight = 121
  ClientWidth = 261
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
    Top = 65
    Width = 66
    Height = 13
    Caption = 'Odleg'#322'o'#347#263' [m]'
  end
  object Label3: TLabel
    Left = 8
    Top = 8
    Width = 80
    Height = 13
    Caption = 'Warto'#347#263' X [kNm]'
  end
  object Label4: TLabel
    Left = 8
    Top = 38
    Width = 80
    Height = 13
    Caption = 'Warto'#347#263' Y [kNm]'
  end
  object edtMomentX: TEdit
    Left = 94
    Top = 8
    Width = 143
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object edtMomentY: TEdit
    Left = 94
    Top = 35
    Width = 143
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object edtZ: TEdit
    Left = 94
    Top = 62
    Width = 143
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 90
    Width = 261
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitWidth = 220
    object btnOK: TButton
      AlignWithMargins = True
      Left = 106
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 65
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 185
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'Anuluj'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 144
    end
  end
end
