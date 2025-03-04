object DM: TDM
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 32
    Top = 8
  end
  object QryClientes: TFDQuery
    IndexFieldNames = 'cidade;idclientes;nome;uf'
    DetailFields = 'cidade;idclientes;nome;uf'
    Connection = FDConnection
    SQL.Strings = (
      'select * from clientes where idclientes = :PIDCLIENTE')
    Left = 32
    Top = 88
    ParamData = <
      item
        Name = 'PIDCLIENTE'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object QryPedidos: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'select clientes.nome,clientes.cidade,clientes.uf,data_emissao,va' +
        'lor_total '
      'from pedidos_dados_gerais '
      'inner join clientes on idclientes'
      '  where numero_pedido = :nrpedido')
    Left = 120
    Top = 88
    ParamData = <
      item
        Name = 'NRPEDIDO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object QryProdutos: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select idprodutos,descricao,preco_venda '
      'from produtos where idProdutos = :PIDPRODUTO')
    Left = 521
    Top = 88
    ParamData = <
      item
        Name = 'PIDPRODUTO'
        ParamType = ptInput
      end>
  end
  object QryMaxPedido: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'select MAX(numero_pedido) + 1 as numero from pedidos_dados_gerai' +
        's')
    Left = 200
    Top = 88
  end
  object FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink
    VendorLib = 
      'C:\Users\Pai\Documents\Embarcadero\Studio\Projects\testewk\libmy' +
      'sql.dll'
    Left = 160
    Top = 8
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 448
    Top = 8
  end
  object FDGUIxLoginDialog1: TFDGUIxLoginDialog
    Provider = 'Forms'
    Left = 312
    Top = 8
  end
  object DSItemPedido: TDataSource
    DataSet = CDSItemPedido
    Left = 288
    Top = 160
  end
  object CDSItemPedido: TClientDataSet
    PersistDataPacket.Data = {
      830000009619E0BD01000000180000000500000000000300000083000770726F
      6475746F01004900000001000557494454480200020014000A7175616E746964
      61646508000400000000000C766C725F756E69746172696F0800040000000000
      09766C725F746F74616C08000400000000000A696470726F6475746F73040001
      00000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'produto'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'quantidade'
        DataType = ftFloat
      end
      item
        Name = 'vlr_unitario'
        DataType = ftFloat
      end
      item
        Name = 'vlr_total'
        DataType = ftFloat
      end
      item
        Name = 'idprodutos'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 368
    Top = 160
    object CDSItemPedidoproduto: TStringField
      FieldName = 'produto'
    end
    object CDSItemPedidoquantidade: TFloatField
      FieldName = 'quantidade'
    end
    object CDSItemPedidovlr_unitario: TFloatField
      FieldName = 'vlr_unitario'
      DisplayFormat = '#,###0.00'
    end
    object CDSItemPedidovlr_total: TFloatField
      FieldName = 'vlr_total'
      DisplayFormat = '#,###0.00'
    end
    object CDSItemPedidoidprodutos: TIntegerField
      FieldName = 'idprodutos'
    end
  end
  object DSPedidosProdutos: TDataSource
    AutoEdit = False
    DataSet = QryPedidosProdutos
    Left = 184
    Top = 160
  end
  object QryPedidosProdutos: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select t2.descricao,t1.quantidade,t1.vlr_unitario,t1.vlr_total '
      'from teste_wk.pedidos_produtos t1'
      'inner join teste_wk.produtos t2'
      'on t1.produtos_idprodutos = t2.idprodutos'
      'where pedidos_dados_gerais_numero_pedido= :nrpedido')
    Left = 416
    Top = 88
    ParamData = <
      item
        Name = 'NRPEDIDO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object QryPedidosProdutosdescricao: TStringField
      DisplayWidth = 35
      FieldName = 'descricao'
      Origin = 'descricao'
      Required = True
      Size = 45
    end
    object QryPedidosProdutosquantidade: TBCDField
      FieldName = 'quantidade'
      Origin = 'quantidade'
      Required = True
      Precision = 12
      Size = 2
    end
    object QryPedidosProdutosvlr_unitario: TBCDField
      FieldName = 'vlr_unitario'
      Origin = 'vlr_unitario'
      Required = True
      DisplayFormat = '#,###0.00'
      Precision = 12
      Size = 2
    end
    object QryPedidosProdutosvlr_total: TBCDField
      FieldName = 'vlr_total'
      Origin = 'vlr_total'
      Required = True
      DisplayFormat = '#,###0.00'
      Precision = 12
      Size = 2
    end
  end
  object QryGravaPedido: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'insert into pedidos_dados_gerais (numero_pedido,data_emissao,val' +
        'or_total,clientes_idclientes) '
      'values(:nrpedido,:data_emissao,:valor_total,:idclientes)')
    Left = 296
    Top = 88
    ParamData = <
      item
        Name = 'NRPEDIDO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DATA_EMISSAO'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'VALOR_TOTAL'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'IDCLIENTES'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object QryGravaPedido_produto: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'insert into pedidos_produtos'
      
        '(quantidade,vlr_unitario,vlr_total,produtos_idprodutos,pedidos_d' +
        'ados_gerais_numero_pedido)'
      
        ' values(:quantidade,:vlr_unitario,:vlr_total,:idprodutos,:numero' +
        '_pedido)')
    Left = 64
    Top = 160
    ParamData = <
      item
        Name = 'QUANTIDADE'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'VLR_UNITARIO'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'VLR_TOTAL'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'IDPRODUTOS'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'NUMERO_PEDIDO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object QryExcluiPedido: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'delete FROM teste_wk.pedidos_produtos where pedidos_dados_gerais' +
        '_numero_pedido= :nrpedido;'
      
        'delete FROM teste_wk.pedidos_dados_gerais where numero_pedido= :' +
        'nrpedido;'
      'commit;'
      '')
    Left = 472
    Top = 160
    ParamData = <
      item
        Name = 'NRPEDIDO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
