object frmImagem_Scan: TfrmImagem_Scan
  Left = 0
  Top = 0
  Caption = 'Leitor Gabarito'
  ClientHeight = 616
  ClientWidth = 980
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 800
    Height = 616
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Imagem'
      object ScrollBox1: TScrollBox
        Left = 0
        Top = 0
        Width = 792
        Height = 588
        Align = alClient
        TabOrder = 0
        object imgDisplay: TImage
          Left = 0
          Top = 0
          Width = 2480
          Height = 3437
          AutoSize = True
          OnMouseMove = imgDisplayMouseMove
        end
      end
    end
    object TTabSheet
      Caption = 'Coordenadas - Debug'
      ImageIndex = 1
      object memoCoordenadas: TMemo
        Left = 0
        Top = 0
        Width = 792
        Height = 588
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Leitura'
      ImageIndex = 2
      object memoRetorno: TMemo
        Left = 0
        Top = 0
        Width = 792
        Height = 588
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object Panel1: TPanel
    Left = 800
    Top = 0
    Width = 180
    Height = 616
    Align = alRight
    TabOrder = 1
    object lblPosition: TLabel
      Left = 6
      Top = 69
      Width = 162
      Height = 41
      AutoSize = False
      Caption = 'lblPosition'
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object lblCor: TLabel
      Left = 6
      Top = 22
      Width = 162
      Height = 41
      Alignment = taCenter
      AutoSize = False
      Caption = 'COR'
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object btnObjeto: TButton
      Left = 6
      Top = 398
      Width = 162
      Height = 41
      Caption = 'Ler imagem'
      TabOrder = 0
      OnClick = btnObjetoClick
    end
    object btnPag1: TButton
      Left = 6
      Top = 116
      Width = 162
      Height = 41
      Caption = '&Carregar Pag.1'
      TabOrder = 1
      OnClick = btnPag1Click
    end
    object btnPag2: TButton
      Left = 6
      Top = 163
      Width = 162
      Height = 41
      Caption = '&Carregar Pag.2'
      TabOrder = 2
      OnClick = btnPag2Click
    end
    object btnPag3: TButton
      Left = 6
      Top = 210
      Width = 162
      Height = 41
      Caption = '&Carregar Pag.3'
      TabOrder = 3
      OnClick = btnPag3Click
    end
    object btnErroValidador: TButton
      Left = 6
      Top = 257
      Width = 162
      Height = 41
      Caption = '&Carregar Erro Validador'
      TabOrder = 4
      OnClick = btnErroValidadorClick
    end
    object btnErroPagina: TButton
      Left = 6
      Top = 304
      Width = 162
      Height = 41
      Caption = '&Carregar Erro Pagina'
      TabOrder = 5
      OnClick = btnErroPaginaClick
    end
    object btnPaginaVirada: TButton
      Left = 6
      Top = 351
      Width = 162
      Height = 41
      Caption = '&Carregar Erro Pagina Virada'
      TabOrder = 6
      OnClick = btnPaginaViradaClick
    end
    object chkMarcaLeitura: TCheckBox
      Left = 6
      Top = 445
      Width = 147
      Height = 17
      Caption = 'Marcar leitura na imagem'
      TabOrder = 7
    end
  end
  object cdsLeitura: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 40
  end
end
