object Form6: TForm6
  Left = 0
  Top = 0
  ActiveControl = edtZ
  BorderStyle = bsDialog
  Caption = 'Po'#322'o'#380'enie podpory [m]'
  ClientHeight = 79
  ClientWidth = 284
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
  object Label3: TLabel
    Left = 0
    Top = 11
    Width = 153
    Height = 13
    Caption = 'Odleg'#322'o'#347#263' od pocz'#261'tku wa'#322'u [m]'
  end
  object edtZ: TEdit
    Left = 155
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 48
    Width = 284
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 270
    object btnOK: TButton
      AlignWithMargins = True
      Left = 129
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 115
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 208
      Top = 3
      Width = 73
      Height = 25
      Align = alRight
      Caption = 'Anuluj'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 194
    end
  end
end
