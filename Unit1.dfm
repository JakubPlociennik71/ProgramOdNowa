object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Obliczenia wa'#322#243'w'
  ClientHeight = 681
  ClientWidth = 842
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mmMenu
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object splRight: TSplitter
    Left = 437
    Top = 0
    Height = 681
    Align = alRight
    ExplicitLeft = 432
    ExplicitTop = 320
    ExplicitHeight = 100
  end
  object ScrollBox1: TScrollBox
    Left = 440
    Top = 0
    Width = 402
    Height = 681
    Align = alRight
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object pbDiagrams: TPaintBox
      Left = 0
      Top = 0
      Width = 398
      Height = 425
      Align = alTop
      OnPaint = pbDiagramsPaint
      ExplicitLeft = -3
      ExplicitTop = -2
      ExplicitWidth = 399
    end
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 437
    Height = 681
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object splLeft: TSplitter
      Left = 0
      Top = 233
      Width = 437
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitLeft = -1
      ExplicitTop = 115
    end
    object tvTree: TTreeView
      Left = 0
      Top = 0
      Width = 437
      Height = 233
      Align = alTop
      HotTrack = True
      Indent = 19
      PopupMenu = pmPopup
      ReadOnly = True
      RightClickSelect = True
      TabOrder = 0
      OnDblClick = tvTreeDblClick
      ExplicitLeft = -1
    end
    object mmRaport: TMemo
      Left = 0
      Top = 236
      Width = 437
      Height = 445
      Align = alClient
      Lines.Strings = (
        'mmRaport')
      TabOrder = 1
      ExplicitLeft = -1
      ExplicitTop = 239
    end
  end
  object mmMenu: TMainMenu
    Left = 592
    Top = 16
    object Zamianapodpr1: TMenuItem
      Caption = 'Zamiana podp'#243'r'
      OnClick = Zamianapodpr1Click
    end
    object Wynikioblicze1: TMenuItem
      Action = actWyniki
    end
    object Usuobcienie1: TMenuItem
      Action = actUsunObc
    end
    object Usuwszystkieobcienia1: TMenuItem
      Action = actUsunWszystko
      Caption = 'Reset obci'#261#380'e'#324
    end
    object Zapiszwyikidopliku1: TMenuItem
      Caption = 'Zapisz wyniki do pliku'
      OnClick = Zapiszwyikidopliku1Click
    end
  end
  object alActions: TActionList
    Images = ilImages
    OnUpdate = alActionsUpdate
    Left = 528
    Top = 16
    object FileSaveAs1: TFileSaveAs
      Category = 'File'
      Caption = 'Save &As...'
      Hint = 'Save As|Saves the active file with a new name'
      ImageIndex = 6
    end
    object FileExit1: TFileExit
      Category = 'File'
      Caption = 'E&xit'
      Hint = 'Exit|Quits the application'
      ImageIndex = 7
    end
    object FileOpen1: TFileOpen
      Category = 'File'
      Caption = '&Open...'
      Hint = 'Open|Opens an existing file'
      ImageIndex = 8
      ShortCut = 16463
    end
    object FileOpen2: TFileOpen
      Category = 'File'
      Caption = '&Open...'
      Hint = 'Open|Opens an existing file'
      ImageIndex = 9
      ShortCut = 16463
    end
    object actSila: TAction
      Caption = 'Si'#322'a'
      OnExecute = actSilaExecute
    end
    object actSilaEdit: TAction
      Caption = 'actSilaEdit'
      OnExecute = actSilaEditExecute
    end
    object actSilaPozaWalem: TAction
      Caption = 'Si'#322'a Poza Wa'#322'em'
      OnExecute = actSilaPozaWalemExecute
    end
    object actMoment: TAction
      Caption = 'Moment gn'#261'cy'
      OnExecute = actMomentExecute
    end
    object actTorque: TAction
      Caption = 'Moment skr'#281'caj'#261'cy'
      OnExecute = actTorqueExecute
    end
    object actPrzesuwna: TAction
      Caption = 'Zmiana po'#322'o'#380'enia podpory przesuwnej'
      OnExecute = actPrzesuwnaExecute
    end
    object actStala: TAction
      Caption = 'Zmiana po'#322'o'#380'enia podpry sta'#322'ej'
      OnExecute = actStalaExecute
    end
    object HelpContents1: THelpContents
      Category = 'Help'
      Caption = '&Contents'
      Enabled = False
      Hint = 'Help Contents'
      ImageIndex = 10
    end
    object actWyniki: TAction
      Caption = 'Wyniki oblicze'#324
      OnExecute = actWynikiExecute
    end
    object actUsunWszystko: TAction
      Caption = 'Usu'#324' wszystkie obci'#261#380'enia'
      OnExecute = actUsunWszystkoExecute
    end
    object actUsunObc: TAction
      Caption = 'Usu'#324' obci'#261#380'enie'
      OnExecute = actUsunObcExecute
    end
    object actMomentEdit: TAction
      Caption = 'actMomentEdit'
      OnExecute = actMomentEditExecute
    end
    object actTorqueEdit: TAction
      Caption = 'actTorqueEdit'
      OnExecute = actTorqueEditExecute
    end
    object actSilaPozaWalemEdit: TAction
      Caption = 'actSilaPozaWalemEdit'
      OnExecute = actSilaPozaWalemEditExecute
    end
    object actWspEdit: TAction
      Caption = 'actWspEdit'
    end
    object actWspBezp: TAction
      Caption = 'actWspBezp'
      OnExecute = actWspBezpExecute
    end
    object actNaprezeniaG: TAction
      Caption = 'actNaprezenia'
      OnExecute = actNaprezeniaGExecute
    end
    object actWspRed: TAction
      Caption = 'actWspRed'
      OnExecute = actWspRedExecute
    end
  end
  object ilImages: TImageList
    Left = 464
    Top = 16
    Bitmap = {
      494C01010B001800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800080008000800086868600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000800080008000FFFFFF00FFFFFF00C0C0C000868686000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000080
      8000008080000080800000808000008080000080800000808000008080000080
      8000000000000000000000000000000000000000000000FFFF00000000000080
      8000008080000080800000808000008080000080800000808000008080000080
      8000000000000000000000000000000000000000000000000000000000008000
      800080008000FFFFFF00FFFFFF000000000000000000C0C0C000C0C0C0008686
      8600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF000000
      0000008080000080800000808000008080000080800000808000008080000080
      80000080800000000000000000000000000000000000FFFFFF0000FFFF000000
      0000008080000080800000808000008080000080800000808000008080000080
      800000808000000000000000000000000000868686008000800080008000FFFF
      FF00FFFFFF000000000000000000800080008000800000000000C0C0C000C0C0
      C000868686000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000080800000808000008080000080800000808000008080000080
      8000008080000080800000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000080800000808000008080000080800000808000008080000080
      8000008080000080800000000000000000008686860080008000FFFFFF000000
      000000000000800080008000800080008000800080008000800000000000C0C0
      C000C0C0C0008686860000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008686860000000000000000008000
      800080008000800080000080800000FFFF008000800080008000800080000000
      0000C0C0C000C0C0C00086868600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000008686860080008000800080008000
      8000800080008000800080008000008080008000800080008000800080008000
      800000000000C0C0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000080008000FFFFFF008000
      80008000800080008000800080008000800000FFFF0000FFFF00800080008000
      8000800080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080008000FFFF
      FF0080008000800080008000800080008000800080000080800000FFFF0000FF
      FF00800080008000800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      8000FFFFFF00800080008000800080008000008080008000800000FFFF0000FF
      FF00800080008000800080008000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080008000FFFFFF00800080008000800000FFFF0000FFFF0000FFFF008000
      8000800080008000800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000080008000FFFFFF00800080008000800080008000800080008000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080008000FFFFFF008000800080008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800080008000800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008686860086868600868686008686
      8600868686008686860086868600868686008686860086868600FFFFFF00C0C0
      C00086868600C0C0C000FFFFFF00C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008686860086868600868686008686
      8600868686008686860086868600868686008686860086868600FFFFFF00C0C0
      C00086868600C0C0C000FFFFFF00C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008686860086868600868686008686
      860086868600868686008686860086868600868686008686860086868600FFFF
      FF0086868600FFFFFF0086868600868686000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008686860086868600868686008686
      860086868600868686008686860086868600868686008686860086868600FFFF
      FF0086868600FFFFFF0086868600868686000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000800000008000
      00000000000000000000868686008686860086868600FFFFFF00FFFFFF00FFFF
      FF00800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000800000008000
      00000000000000000000868686008686860086868600FFFFFF00FFFFFF00FFFF
      FF00800000008000000080000000800000000000000000000000000000000000
      0000008080000080800000000000000000000000000000000000C0C0C0000000
      0000008080000000000000000000000000000000000000000000000000008000
      0000FF00000080000000000000000000000086868600FFFFFF00FFFFFF00FFFF
      FF00800000000000000000000000000000000000000000000000000000000000
      0000008080000080800000000000000000000000000000000000C0C0C0000000
      0000008080000000000000000000000000000000000000000000000000008000
      0000FF00000080000000000000000000000086868600FFFFFF00FFFFFF00FFFF
      FF00800000000000000000000000000000000000000000000000000000000000
      0000008080000080800000000000000000000000000000000000C0C0C0000000
      0000008080000000000000000000000000000000000000000000000000008000
      000080000000FF0000008000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00800000000000000000000000000000000000000000000000000000000000
      0000008080000080800000000000000000000000000000000000C0C0C0000000
      0000008080000000000000000000000000000000000000000000000000008000
      000080000000FF0000008000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00800000000000000000000000000000000000000000000000000000000000
      0000008080000080800000000000000000000000000000000000000000000000
      0000008080000000000000000000000000000000000000000000000000008000
      0000FF00000080000000FF00000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00800000000000000000000000000000000000000000000000000000000000
      0000008080000080800000000000000000000000000000000000000000000000
      0000008080000000000000000000000000000000000000000000000000008000
      0000FF00000080000000FF00000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00800000000000000000000000000000000000000000000000000000000000
      0000008080000080800000808000008080000080800000808000008080000080
      8000008080000000000000000000000000000000000000000000000000008000
      000080000000FF0000008000000000000000FFFFFF00FFFF0000FFFFFF00FFFF
      0000800000000000000000000000000000000000000000000000000000000000
      0000008080000080800000808000008080000080800000808000008080000080
      8000008080000000000000000000000000000000000000000000000000008000
      000080000000FF0000008000000000000000FFFFFF00FFFF0000FFFFFF00FFFF
      0000800000000000000000000000000000000000000000000000000000000000
      0000008080000080800000000000000000000000000000000000000000000080
      8000008080000000000000000000000000000000000000000000000000008000
      0000FF00000080000000FF00000000000000FFFF0000FFFFFF00FFFF0000FFFF
      FF00800000000000000000000000000000000000000000000000000000000000
      0000008080000080800000000000000000000000000000000000000000000080
      8000008080000000000000000000000000000000000000000000000000008000
      0000FF00000080000000FF00000000000000FFFF0000FFFFFF00FFFF0000FFFF
      FF00800000000000000000000000000000000000000000000000000000000000
      00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000008080000000000000000000000000000000000000000000000000008000
      000080000000FF0000008000000000000000FFFFFF00FFFF0000FFFFFF00FFFF
      0000800000000000000000000000000000000000000000000000000000000000
      00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000008080000000000000000000000000000000000000000000000000008000
      000080000000FF0000008000000000000000FFFFFF00FFFF0000FFFFFF00FFFF
      0000800000000000000000000000000000000000000000000000000000000000
      00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000008080000000000000000000000000000000000000000000000000008000
      0000FF00000080000000FF00000000000000FFFF0000FFFFFF00FFFF0000FFFF
      FF00800000000000000000000000000000000000000000000000000000000000
      00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000008080000000000000000000000000000000000000000000000000008000
      0000FF00000080000000FF00000000000000FFFF0000FFFFFF00FFFF0000FFFF
      FF00800000000000000000000000000000000000000000000000000000000000
      00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000800000008000000080000000800000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000800000008000000080000000800000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008686860086868600868686008686
      8600868686008686860086868600868686008686860086868600FFFFFF00C0C0
      C00086868600C0C0C000FFFFFF00C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008686860086868600868686008686
      860086868600868686008686860086868600868686008686860086868600FFFF
      FF0086868600FFFFFF0086868600868686000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000800000008000
      00000000000000000000868686008686860086868600FFFFFF00FFFFFF00FFFF
      FF00800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000FF00000080000000000000000000000086868600FFFFFF00FFFFFF00FFFF
      FF00800000000000000000000000000000000000000000000000000000000000
      0000008080000080800000000000000000000000000000000000C0C0C0000000
      0000008080000000000000000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000000
      0000000000000000000000000000000000000000000000FFFF00000000000080
      8000008080000080800000808000008080000080800000808000008080000080
      8000000000000000000000000000000000000000000000000000000000008000
      000080000000FF0000008000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00800000000000000000000000000000000000000000000000000000000000
      0000008080000080800000000000000000000000000000000000C0C0C0000000
      0000008080000000000000000000000000000000000000FFFF00000000000080
      8000008080000080800000808000008080000080800000808000008080000080
      80000000000000000000000000000000000000000000FFFFFF0000FFFF000000
      0000008080000080800000808000008080000080800000808000008080000080
      8000008080000000000000000000000000000000000000000000000000008000
      0000FF00000080000000FF00000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00800000000000000000000000000000000000000000000000000000000000
      0000008080000080800000000000000000000000000000000000000000000000
      00000080800000000000000000000000000000000000FFFFFF0000FFFF000000
      0000008080000080800000808000008080000080800000808000008080000080
      8000008080000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000080800000808000008080000080800000808000008080000080
      8000008080000080800000000000000000000000000000000000000000008000
      000080000000FF0000008000000000000000FFFFFF00FFFF0000FFFFFF00FFFF
      0000800000000000000000000000000000000000000000000000000000000000
      0000008080000080800000808000008080000080800000808000008080000080
      8000008080000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000080800000808000008080000080800000808000008080000080
      80000080800000808000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000FF00000080000000FF00000000000000FFFF0000FFFFFF00FFFF0000FFFF
      FF00800000000000000000000000000000000000000000000000000000000000
      0000008080000080800000000000000000000000000000000000000000000080
      80000080800000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      000080000000FF0000008000000000000000FFFFFF00FFFF0000FFFFFF00FFFF
      0000800000000000000000000000000000000000000000000000000000000000
      00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000008080000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000FF00000080000000FF00000000000000FFFF0000FFFFFF00FFFF0000FFFF
      FF00800000000000000000000000000000000000000000000000000000000000
      00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      00000080800000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000800000008000000080000000800000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFFFFFFE3F0000
      001F001FF81F0000000F000FE00F000000070007800700000003000300030000
      00010001000100000000000000000000001F001F00010000001F001F80010000
      001F001FC00100008FF18FF1E0000000FFF9FFF9F0000000FF75FF75F8030000
      FF8FFF8FFC0F0000FFFFFFFFFE3F0000FF7E0000FF7E0000BFFF0000BFFF0000
      F0030000F0030000E003E007E003E007E003E007E003E007E003E007E003E007
      E003E007E003E0072003E0072003E007E002E007E002E007E003E007E003E007
      E003E007E003E007E003FFFFE003FFFFE003F81FE003F81FFFFFF81FFFFFF81F
      BF7DF81FBF7DF81F7F7EFFFF7F7EFFFFFFFF0000FF7EFFFFFFFF0000BFFFFFFF
      001F0000F003001F000FE007E003000F0007E007E00300070003E007E0030003
      0001E007E00300010000E00720030000001FE007E002001F001FE007E003001F
      001FE007E003001F8FF1FFFFE0038FF1FFF9F81FE003FFF9FF75F81FFFFFFF75
      FF8FF81FBF7DFF8FFFFFFFFF7F7EFFFF00000000000000000000000000000000
      000000000000}
  end
  object pmPopup: TPopupMenu
    Left = 656
    Top = 16
    object Sia1: TMenuItem
      Action = actSila
    end
    object SiaPozaWaem1: TMenuItem
      Action = actSilaPozaWalem
    end
    object Momentgncy1: TMenuItem
      Action = actMoment
    end
    object Momentskrcajcy1: TMenuItem
      Action = actTorque
    end
    object Zmianapooeniapodporyprzesuwnej1: TMenuItem
      Action = actPrzesuwna
    end
    object Zmianapooeniapodprystaej1: TMenuItem
      Action = actStala
      Caption = 'Zmiana po'#322'o'#380'enia podpory sta'#322'ej'
    end
    object Wybrwspczynnikaredukujcego1: TMenuItem
      Caption = 'Wyb'#243'r wsp'#243#322'czynnika redukuj'#261'cego'
      OnClick = Wybrwspczynnikaredukujcego1Click
    end
    object Wybrwaciwocimateriaowych1: TMenuItem
      Caption = 'Wyb'#243'r w'#322'a'#347'ciwo'#347'ci materia'#322'owych'
    end
  end
end
