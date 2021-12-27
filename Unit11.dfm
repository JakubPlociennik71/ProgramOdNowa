object Form11: TForm11
  Left = 0
  Top = 0
  Caption = 'Napr'#281#380'enia dopuszczalne'
  ClientHeight = 97
  ClientWidth = 449
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 4
    Top = 8
    Width = 395
    Height = 13
    Caption = 
      'Wpisz warto'#347#263'  dopuszczalnych napr'#281#380'e'#324' materia'#322'u z jakiego ma by' +
      ' wykonany wa'#322
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 20
    Top = 35
    Width = 43
    Height = 13
    Caption = 'Warto'#347#263' '
  end
  object Edit1: TEdit
    Left = 88
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 66
    Width = 449
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 45
    ExplicitWidth = 303
    object btnOK: TButton
      AlignWithMargins = True
      Left = 294
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
      Left = 373
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
