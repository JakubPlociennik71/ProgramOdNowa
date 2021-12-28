object Form13: TForm13
  Left = 0
  Top = 0
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
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object RadioButton1: TRadioButton
    Left = 8
    Top = 8
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
  object RadioButton2: TRadioButton
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
    ExplicitLeft = -12
    ExplicitTop = 148
    ExplicitWidth = 395
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
      ExplicitLeft = 240
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
      ExplicitLeft = 319
    end
  end
end
