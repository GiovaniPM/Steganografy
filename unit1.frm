object Form1: TForm1
  Left = 343
  Height = 389
  Hint = 'Abrir'
  Top = 256
  Width = 600
  Caption = 'Steganografy'
  ClientHeight = 369
  ClientWidth = 600
  Menu = MainMenu1
  OnActivate = FormActivate
  LCLVersion = '7.2'
  Visible = True
  object Panel1: TPanel
    Left = 0
    Height = 304
    Top = 0
    Width = 600
    Align = alClient
    Caption = ' '
    ClientHeight = 304
    ClientWidth = 600
    TabOrder = 0
    object PairSplitter1: TPairSplitter
      Left = 1
      Height = 302
      Top = 1
      Width = 598
      Align = alClient
      Position = 300
      object PairSplitterSide1: TPairSplitterSide
        Cursor = crArrow
        Left = 0
        Height = 302
        Top = 0
        Width = 300
        ClientWidth = 300
        ClientHeight = 302
        object Image1: TImage
          Left = 0
          Height = 302
          Top = 0
          Width = 300
          Align = alClient
          Center = True
          Stretch = True
        end
      end
      object PairSplitterSide2: TPairSplitterSide
        Cursor = crArrow
        Left = 305
        Height = 302
        Top = 0
        Width = 293
        ClientWidth = 293
        ClientHeight = 302
        object Memo1: TMemo
          Left = 0
          Height = 302
          Top = 0
          Width = 293
          Align = alClient
          Lines.Strings = (
            'Memo1'
          )
          TabOrder = 0
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Height = 65
    Top = 304
    Width = 600
    Align = alBottom
    Caption = ' '
    ClientHeight = 65
    ClientWidth = 600
    TabOrder = 1
    object Edit1: TEdit
      Left = 8
      Height = 15
      Top = 8
      Width = 288
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 0
      Text = 'File name'
    end
    object Edit2: TEdit
      Left = 8
      Height = 15
      Top = 24
      Width = 288
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 1
      Text = 'File size'
    end
    object Edit3: TEdit
      Left = 8
      Height = 15
      Top = 40
      Width = 288
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 2
      Text = 'File identier'
    end
    object Edit4: TEdit
      Left = 304
      Height = 15
      Top = 8
      Width = 288
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 3
      Text = 'Pixel'
    end
    object Edit5: TEdit
      Left = 304
      Height = 15
      Top = 24
      Width = 288
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 4
      Text = 'Byte'
    end
    object Edit6: TEdit
      Left = 304
      Height = 15
      Top = 40
      Width = 288
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 5
      Text = 'Byte'
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 24
    Top = 120
  end
  object ActionList1: TActionList
    Left = 24
    Top = 72
    object Open: TAction
      Caption = 'Open'
      Hint = 'Open File'
      OnExecute = OpenExecute
    end
    object Save: TAction
      Caption = 'Save'
      Hint = 'Save File'
      OnExecute = SaveExecute
    end
    object Exit1: TAction
      Caption = 'Exit'
      OnExecute = Exit1Execute
    end
  end
  object MainMenu1: TMainMenu
    Left = 24
    Top = 24
    object MenuItem1: TMenuItem
      Caption = 'File'
      object MenuItem2: TMenuItem
        Action = Open
        Caption = 'Open ...'
      end
      object MenuItem3: TMenuItem
        Action = Save
        Caption = 'Save ...'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object MenuItem5: TMenuItem
        Action = Exit1
      end
    end
  end
end
