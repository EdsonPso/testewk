object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  Caption = 'Teste para a vaga de Desenvolvedor Delphi - PEDIDOS DE VENDA'
  ClientHeight = 508
  ClientWidth = 636
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnShow = FormShow
  TextHeight = 15
  object GroupBoxCliente: TGroupBox
    Left = 8
    Top = 8
    Width = 625
    Height = 97
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LabelCodigo: TLabel
      Left = 16
      Top = 32
      Width = 39
      Height = 15
      Caption = 'C'#243'digo'
    end
    object LabelNome: TLabel
      Left = 96
      Top = 32
      Width = 33
      Height = 15
      Caption = 'Nome'
    end
    object LabelCidade: TLabel
      Left = 331
      Top = 30
      Width = 37
      Height = 15
      Caption = 'Cidade'
    end
    object LabelUF: TLabel
      Left = 498
      Top = 30
      Width = 14
      Height = 15
      Caption = 'UF'
    end
    object LabelTitCliente: TLabel
      Left = 286
      Top = 3
      Width = 54
      Height = 21
      Alignment = taCenter
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object EditNomeCliente: TEdit
      Left = 96
      Top = 53
      Width = 225
      Height = 23
      TabStop = False
      Enabled = False
      TabOrder = 0
    end
    object EditCidade: TEdit
      Left = 331
      Top = 51
      Width = 161
      Height = 23
      TabStop = False
      Enabled = False
      TabOrder = 1
    end
    object EditUF: TEdit
      Left = 498
      Top = 51
      Width = 25
      Height = 23
      TabStop = False
      Enabled = False
      TabOrder = 2
    end
    object MEditIdCliente: TMaskEdit
      Left = 17
      Top = 53
      Width = 71
      Height = 23
      Alignment = taCenter
      TabOrder = 3
      Text = ''
      OnChange = MEditIdClienteChange
      OnKeyPress = MEditIdClienteKeyPress
    end
  end
  object GroupBoxPedido: TGroupBox
    Left = 8
    Top = 111
    Width = 622
    Height = 90
    TabOrder = 1
    object LabelTitPedido: TLabel
      Left = 284
      Top = 5
      Width = 54
      Height = 21
      Alignment = taCenter
      Caption = 'Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelNrPedido: TLabel
      Left = 14
      Top = 32
      Width = 56
      Height = 15
      Caption = 'Nr. Pedido'
    end
    object LabelEmissao: TLabel
      Left = 94
      Top = 32
      Width = 43
      Height = 15
      Caption = 'Emiss'#227'o'
    end
    object LabelValorotalPedido: TLabel
      Left = 182
      Top = 32
      Width = 53
      Height = 15
      Caption = 'Valor total'
    end
    object EditEmissaoPedido: TEdit
      Left = 94
      Top = 53
      Width = 82
      Height = 23
      TabStop = False
      Enabled = False
      TabOrder = 2
    end
    object EditValorTotalPedido: TEdit
      Left = 182
      Top = 53
      Width = 121
      Height = 23
      TabStop = False
      Alignment = taRightJustify
      Enabled = False
      TabOrder = 1
    end
    object ButtonApagaPedido: TButton
      Left = 496
      Top = 53
      Width = 75
      Height = 25
      Caption = 'Apaga'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      TabStop = False
      Visible = False
      OnClick = ButtonApagaPedidoClick
    end
    object ButtonCarregaPedido: TButton
      Left = 415
      Top = 53
      Width = 75
      Height = 25
      Caption = 'Carrega'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      TabStop = False
      Visible = False
      OnClick = ButtonCarregaPedidoClick
    end
    object MEditNrPedido: TMaskEdit
      Left = 17
      Top = 53
      Width = 71
      Height = 23
      Alignment = taCenter
      TabOrder = 4
      Text = ''
      OnChange = MEditNrPedidoChange
      OnKeyPress = MEditNrPedidoKeyPress
    end
  end
  object GroupBoxProdutosPedido: TGroupBox
    Left = 8
    Top = 203
    Width = 625
    Height = 250
    Caption = #39#39#39
    Enabled = False
    TabOrder = 2
    object LabelCodigoProduto: TLabel
      Left = 17
      Top = 45
      Width = 74
      Height = 15
      Caption = 'C'#243'd.  produto'
    end
    object LabelDescricaoProduto: TLabel
      Left = 97
      Top = 45
      Width = 51
      Height = 15
      Caption = 'Descri'#231#227'o'
    end
    object LabelVlrUnitario: TLabel
      Left = 461
      Top = 47
      Width = 61
      Height = 15
      Caption = 'Vl.r unit'#225'rio'
    end
    object LabelTitItensPedido: TLabel
      Left = 259
      Top = 11
      Width = 119
      Height = 21
      Alignment = taCenter
      Caption = 'Itens do pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Labelquntidade: TLabel
      Left = 390
      Top = 47
      Width = 62
      Height = 15
      Caption = 'Quantidade'
    end
    object EditDescricaoProduto: TEdit
      Left = 97
      Top = 66
      Width = 271
      Height = 23
      TabStop = False
      Enabled = False
      TabOrder = 0
    end
    object EditVlrUnitario: TEdit
      Left = 460
      Top = 66
      Width = 63
      Height = 23
      Alignment = taRightJustify
      TabOrder = 3
    end
    object BitBtnIncluiItem: TBitBtn
      Left = 539
      Top = 67
      Width = 83
      Height = 25
      Caption = 'Adiciona item'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = BitBtnIncluiItemClick
    end
    object BitBtnRemveItem: TBitBtn
      Left = 538
      Top = 134
      Width = 83
      Height = 25
      Caption = 'Remove  item'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = BitBtnRemveItemClick
    end
    object EditQuantidade: TEdit
      Left = 390
      Top = 66
      Width = 64
      Height = 23
      Alignment = taRightJustify
      TabOrder = 2
      OnKeyPress = EditQuantidadeKeyPress
    end
    object DBGridPodutoPedido: TDBGrid
      Left = 22
      Top = 95
      Width = 510
      Height = 140
      DataSource = DM.DSItemPedido
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 5
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnKeyDown = DBGridPodutoPedidoKeyDown
      OnKeyPress = DBGridPodutoPedidoKeyPress
      Columns = <
        item
          Expanded = False
          FieldName = 'produto'
          Width = 271
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'quantidade'
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'vlr_unitario'
          Width = 66
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'vlr_total'
          Visible = True
        end>
    end
    object MEditIdProduto: TMaskEdit
      Left = 17
      Top = 66
      Width = 71
      Height = 23
      Alignment = taCenter
      TabOrder = 1
      Text = ''
      OnKeyPress = MEditIdProdutoKeyPress
    end
    object DBGridCarregaPedido: TDBGrid
      Left = 6
      Top = 95
      Width = 528
      Height = 120
      DataSource = DM.DSPedidosProdutos
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 7
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Visible = False
    end
  end
  object BitBtnGravaPedido: TBitBtn
    Left = 32
    Top = 459
    Width = 137
    Height = 23
    Caption = 'Gravar o pedido'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = BitBtnGravaPedidoClick
  end
  object BitBtnFechar: TBitBtn
    Left = 557
    Top = 467
    Width = 75
    Height = 23
    Caption = 'Fechar'
    TabOrder = 3
    StyleName = 'Windows'
    OnClick = BitBtnFecharClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 489
    Width = 636
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Text = 'Valor total do pedido: '
        Width = 50
      end>
    ExplicitTop = 488
    ExplicitWidth = 632
  end
end
