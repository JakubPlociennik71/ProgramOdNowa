object Form13: TForm13
  Left = 0
  Top = 0
  ActiveControl = rbGnace
  BorderStyle = bsDialog
  Caption = 'Wyb'#243'r przewa'#380'aj'#261'cego obci'#261#380'enia'
  ClientHeight = 124
  ClientWidth = 226
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
  object rbGnace: TRadioButton
    Left = 8
    Top = 16
    Width = 385
    Height = 17
    Caption = 'Napr'#281#380'enie gn'#261'ce'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object rbSkrecajace: TRadioButton
    Left = 8
    Top = 47
    Width = 385
    Height = 17
    Caption = 'Napr'#281#380'enie skr'#281'caj'#261'ce'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 93
    Width = 226
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnOK: TButton
      AlignWithMargins = True
      Left = 71
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
      Left = 150
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
