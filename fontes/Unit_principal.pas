unit Unit_principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Data.DB,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.WinXCtrls, Unit_DataComponent,
  Vcl.ComCtrls, Vcl.DBCGrids, Vcl.Mask ;

type
  TFormPrincipal = class(TForm)
    GroupBoxCliente: TGroupBox;
    GroupBoxPedido: TGroupBox;
    GroupBoxProdutosPedido: TGroupBox;
    LabelCodigo: TLabel;
    EditNomeCliente: TEdit;
    LabelNome: TLabel;
    EditCidade: TEdit;
    LabelCidade: TLabel;
    EditUF: TEdit;
    LabelUF: TLabel;
    BitBtnGravaPedido: TBitBtn;
    BitBtnFechar: TBitBtn;
    EditEmissaoPedido: TEdit;
    EditValorTotalPedido: TEdit;
    ButtonApagaPedido: TButton;
    LabelCodigoProduto: TLabel;
    EditDescricaoProduto: TEdit;
    LabelDescricaoProduto: TLabel;
    LabelVlrUnitario: TLabel;
    EditVlrUnitario: TEdit;
    BitBtnIncluiItem: TBitBtn;
    BitBtnRemveItem: TBitBtn;
    LabelTitItensPedido: TLabel;
    LabelTitPedido: TLabel;
    LabelTitCliente: TLabel;
    LabelNrPedido: TLabel;
    LabelEmissao: TLabel;
    LabelValorotalPedido: TLabel;
    Labelquntidade: TLabel;
    EditQuantidade: TEdit;
    StatusBar1: TStatusBar;
    DBGridPodutoPedido: TDBGrid;
    ButtonCarregaPedido: TButton;
    MEditIdProduto: TMaskEdit;
    MEditIdCliente: TMaskEdit;
    MEditNrPedido: TMaskEdit;
    DBGridCarregaPedido: TDBGrid;
    procedure BitBtnFecharClick(Sender: TObject);
    procedure BitBtnGravaPedidoClick(Sender: TObject);
    procedure BitBtnIncluiItemClick(Sender: TObject);
    procedure BitBtnRemveItemClick(Sender: TObject);
    procedure ButtonApagaPedidoClick(Sender: TObject);
    procedure DBGridPodutoPedidoKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridPodutoPedidoEnter(Sender: TObject);
    procedure DBGridPodutoPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdClienteChange(Sender: TObject);
    procedure EditIdClienteKeyPress(Sender: TObject; var Key: Char);
    function  FTrataBtnPedido(sIdcliente: string): boolean;
    procedure EditNrPedidoChange(Sender: TObject);
    procedure EditNrPedidoKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdProdutoChange(Sender: TObject);
    procedure EditIdProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure ButtonCarregaPedidoClick(Sender: TObject);
    procedure MEditIdProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure MEditIdClienteChange(Sender: TObject);
    procedure MEditIdClienteKeyPress(Sender: TObject; var Key: Char);
    procedure MEditNrPedidoChange(Sender: TObject);
    procedure MEditNrPedidoKeyPress(Sender: TObject; var Key: Char);
    procedure EditQuantidadeKeyPress(Sender: TObject; var Key: Char);
   private
    { Private declarations }
    GValorTtalPedido:real;
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation


{$R *.dfm}

procedure TFormPrincipal.BitBtnRemveItemClick(Sender: TObject);
var
  valorTotalItem: real;
begin
  try
    valorTotalItem := DM.CDSItempedido.FieldByName('Vlr_total').Value;
    DM.CDSItempedido.Delete;
    GValorTtalPedido                := GValorTtalPedido - valorTotalItem;
    StatusBar1.Panels.Items[0].Text := 'Valor total do pedido: R$ '+ FormatFloat('0,00',GValorTtalPedido);
  except on E:Exception do
    showmessage('Falha ao remover o item do pedido: ' + E.Message);
  end;
end;

procedure TFormPrincipal.ButtonApagaPedidoClick(Sender: TObject);
begin
  if application.MessageBox('Confirma a exclusão do pedido selecionado?','Atenção', MB_YESNO) = 6 then
  begin
    try
      DM.QryExcluiPedido.ParamByName('nrpedido').AsInteger := strtoint(MEditNrPedido.Text);
      DM.QryExcluiPedido.ExecSQL;
      showmessage( 'Pedido: '+ MEditNrPedido.Text+ ' foi apagado com sucesso!');
    except on E:Exception do
      showmessage('Falha ao excluir o pedido: ' + E.Message);
    end;
  end;
  GroupBoxCliente.Enabled:=true;
  DBGridPodutoPedido.Visible:=true;
  DBGridCarregaPedido.Visible:=false;
  FTrataBtnPedido(MEditIdCliente.text) ;
end;

procedure TFormPrincipal.ButtonCarregaPedidoClick(Sender: TObject);
begin
 try
    if strToint(MEditNrPedido.Text)<=0 then
      showmessage('informe um valor maior ou diferende de zero!')
    else
    begin
      DM.QryPedidos.ParamByName('nrpedido').ASINTEGER := strtoint(MEditNrPedido.Text);
      if DM.QryPedidos.Active then
        DM.QryPedidos.Refresh
      else
        DM.QryPedidos.Open;

      if DM.QryPedidos.IsEmpty then
      begin
        showmessage('Pedido não encontrado!');
        MEditNrPedido.Clear;
      end
      else
      begin
        EditEmissaoPedido.text    := DateToStr(DM.QryPedidos.FieldByName('data_emissao').Value);
        EditValorTotalPedido.text := FormatFloat('#,##0',DM.QryPedidos.FieldByName('valor_total').Value);
        DM.QryPedidosProdutos.close;
        DM.QryPedidosProdutos.ParamByName('nrpedido').asInteger:=strtoint(MEditNrPedido.Text);
        DM.QryPedidosProdutos.open;
        GroupBoxCliente.Enabled:=false;
        DBGridPodutoPedido.Visible:=false;
        DBGridCarregaPedido.Visible:=true;
      end
    end;
  except on E:Exception do
    showmessage('Falha ao buscar o pedido! ' + E.Message);
  end;
end;

procedure TFormPrincipal.DBGridPodutoPedidoEnter(Sender: TObject);
var valorTotalItem: real;
begin
  ValorTotalItem        := DM.CDSItempedido.FieldByName('Vlr_total').Value;
  EditQuantidade.Text   := IntToStr(DM.CDSItempedido.FieldByName('quantidade').value);
  EditVlrUnitario.Text  := FloaTtoStr(DM.CDSItempedido.FieldByName('vlr_unitario').value) ;
  editQuantidade.SetFocus;
  MEditIdProduto.Enabled:=false;
  showmessage('Modo de edição. Para salvar pressione  botão  [Adiciona item].');
end;

procedure TFormPrincipal.DBGridPodutoPedidoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
  var valorTotalItem: real;
begin
if (key = 46 ) then
  try
    ValorTotalItem := DM.CDSItempedido.FieldByName('Vlr_total').Value;
    DM.CDSItempedido.Delete;
    GValorTtalPedido                := GValorTtalPedido - valorTotalItem;
    StatusBar1.Panels.Items[0].Text := 'Valor total do pedido: R$ '+ FormatFloat('#,##0',GValorTtalPedido);
  except on E:Exception do
    showmessage('Falha ao remover o item do pedido: ' + E.Message);
  end;
end;

procedure TFormPrincipal.DBGridPodutoPedidoKeyPress(Sender: TObject; var Key: Char);
 var valorTotalItem: real;
begin
  if (key = #13)  then
  begin
    ValorTotalItem        := DM.CDSItempedido.FieldByName('Vlr_total').Value;
    EditQuantidade.Text   := IntToStr(DM.CDSItempedido.FieldByName('quantidade').value);
    EditVlrUnitario.Text  := FormatFloat('#,##0',DM.CDSItempedido.FieldByName('vlr_unitario').value) ;
    editQuantidade.SetFocus;
    MEditIdProduto.Enabled:=false;
    showmessage('Modo de edição. Para salvar pressione  botão  [Adiciona item].');
  end;
end;

procedure TFormPrincipal.EditIdClienteChange(Sender: TObject);
begin
  FTrataBtnPedido(MEditIdCliente.Text);
end;

procedure TFormPrincipal.EditIdClienteKeyPress(Sender: TObject; var Key: Char);
begin
 if key = #13 then
  begin
    try
      if strToint(MEditIdCliente.Text) <= 0 then
        showmessage('informe um valor maior que zero!')
      else
      begin
        DM.QryClientes.ParamByName('PIDCLIENTE').asInteger := strtoint(MEditIdCliente.Text);

        if DM.QryClientes.Active then
          DM.QryClientes.Refresh
        else
          DM.QryClientes.Open;

        if DM.QryClientes.IsEmpty then
          showmessage('Cliente não encontrado!')
        else
        begin
          EditNomeCliente.text  := DM.QryClientes.FieldByName('nome').Value;
          Editcidade.text       := DM.QryClientes.FieldByName('cidade').Value;
          Edituf.text           := DM.QryClientes.FieldByName('uf').Value
        end
      end;
      MEditIdProduto.SetFocus;
    except on E:Exception do
      showmessage('Valor inválido: ' + E.Message);
    end;
  end;
end;

procedure TFormPrincipal.EditIdProdutoChange(Sender: TObject);
begin
  try
    if strToint(MEditIdProduto.Text)<=0 then
      showmessage('informe um valor maior que zero!')
    else
    begin
      DM.QryProdutos.ParamByName('PIDPRODUTO').asInteger := strtoint(MEditIdProduto.Text);
      if DM.QryProdutos.Active then
        DM.QryProdutos.Refresh
      else
        DM.QryProdutos.Open;

      if DM.QryProdutos.IsEmpty then
        showmessage(' Produto não encontrado!')
      else
      begin
        EditDescricaoProduto.text := DM.QryProdutos.FieldByName('descricao').Value;
        EditVlrUnitario.text      := FormatFloat('#,##0',DM.QryProdutos.FieldByName('preco_venda').Value);
      end;
    end;
  except on E:Exception do
    showmessage('Valor inválido: ' + E.Message);
  end;
end;


procedure TFormPrincipal.EditIdProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    try
      if strToint(MEditIdProduto.Text)<=0 then
        showmessage('informe um valor maior que zero!')
      else
      begin
        DM.QryProdutos.ParamByName('PIDPRODUTO').asInteger := strtoint(MEditIdProduto.Text);
        if DM.QryProdutos.Active then
          DM.QryProdutos.Refresh
        else
          DM.QryProdutos.Open;

        if DM.QryProdutos.IsEmpty then
          showmessage(' Produto não encontrado!')
        else
        begin
          EditDescricaoProduto.text := DM.QryProdutos.FieldByName('descricao').Value;
          EditVlrUnitario.text      := FormatFloat('#,##0',DM.QryProdutos.FieldByName('preco_venda').Value);
          EditQuantidade.SetFocus;
        end;
      end;
    except on E:Exception do
      showmessage('Valor inválido: ' + E.Message);
    end;
  end;
end;


procedure TFormPrincipal.EditNrPedidoChange(Sender: TObject);
begin
  if (MEditNrPedido.Text=null) or (MEditNrPedido.Text='') or (MEditNrPedido.Text=' ') then
  begin
    ButtonCarregaPedido.Visible:=false;
    ButtonApagaPedido.Visible:=false;
  end
  else
  begin
    ButtonCarregaPedido.Visible:=true;
    ButtonApagaPedido.Visible:=true
  end;
end;

procedure TFormPrincipal.EditNrPedidoKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    ButtonCarregaPedido.SetFocus;
end;


procedure TFormPrincipal.EditQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    EditVlrUnitario.SetFocus;
end;

procedure TFormPrincipal.BitBtnFecharClick(Sender: TObject);
begin
  application.Terminate;
end;

procedure TFormPrincipal.BitBtnGravaPedidoClick(Sender: TObject);
var
  i         : integer;
  nr_pedido : integer;

begin
  try
    DM.QryMaxPedido.SQL.Clear;
    DM.QryMaxPedido.SQL.Add('Select MAX(numero_pedido) + 1 as ultimo_pedido from pedidos_dados_gerais');
    DM.QryMaxPedido.Open;
    if DM.QryMaxPedido.FieldByName('ultimo_pedido').value = null then
      nr_pedido := 1
    else
      nr_pedido := DM.QryMaxPedido.FieldByName('ultimo_pedido').value ;
    DM.QryMaxPedido.Close;
    DM.QryGravaPedido.ParamByName('nrpedido').ASINTEGER         := nr_pedido;
    DM.QryGravaPedido.ParamByName('idclientes').ASINTEGER       := strtoint(MEditIdCliente.text);
    DM.QryGravaPedido.ParamByName('data_emissao').ASDATETIME    := date();
    DM.QryGravaPedido.ParamByName('valor_total').ASFLOAT := GValorTtalPedido;
    DM.QryGravaPedido.ExecSQL;
    DM.CDSItempedido.First;
    for I := 0 to DM.CDSItempedido.RecordCount do  begin
      DM.QryGravaPedido_produto.ParamByName('numero_pedido').asInteger:= nr_pedido;
      DM.QryGravaPedido_produto.ParamByName('idprodutos').asInteger   := DM.CDSItempedido.FieldByName('idprodutos').value;
      DM.QryGravaPedido_produto.ParamByName('quantidade').asFloat     := DM.CDSItempedido.FieldByName('quantidade').value;
      DM.QryGravaPedido_produto.ParamByName('vlr_unitario').asFloat   := DM.CDSItempedido.FieldByName('vlr_unitario').value;
      DM.QryGravaPedido_produto.ParamByName('Vlr_total').asFloat      := DM.CDSItempedido.FieldByName('Vlr_total').value;
      DM.QryGravaPedido_produto.ExecSQL;
      DM.CDSItempedido.Next;
    end;
    DM.CDSItemPedido.EmptyDataSet;
    DM.CDSItemPedido.active:=false;
    showmessage('O pedido número ' + IntToStr(nr_pedido) + ' foi gravado om sucesso!');
    GValorTtalPedido:=0;
    StatusBar1.Panels.Items[0].Text := 'Valor total do pedido: R$ '+ FormatFloat('0,00',GValorTtalPedido);
    MEditIdCliente.SetFocus;
    MEditIdCliente.clear;
    FTrataBtnPedido(MEditIdCliente.Text) ;
  except on E:Exception do
    showmessage('Falha ao gravar o pedido. Operação candelada: ' + E.Message);
  end;
end;

procedure TFormPrincipal.BitBtnIncluiItemClick(Sender: TObject);
var
  Total : real;
  bContinua:boolean;
begin
  bContinua:=true;
  if ( editQuantidade.Text='' ) or (editQuantidade.Text='0') or (editQuantidade.Text=' ')  then
  begin
    showmessage('O campo quantidade deve ser maior que zero!');
    bContinua:=false;
  end;
  if ( EditVlrUnitario.Text='' ) or (EditVlrUnitario.Text='0') or (EditVlrUnitario.Text=' ')  then
  begin
    showmessage('O campo  Valor unitário deve ser maior que zero!');
    bContinua:=false;
  end;
  if bContinua then
  begin
    try
      if DM.CDSItempedido.active=false then
        DM.CDSItempedido.Active:=true;
        if MEditIdProduto.Enabled=true then
        begin
          DM.CDSItemPedido.Append;
          DM.CDSItempedido.FieldByName('idprodutos').AsInteger := StrToInt(MEditIdProduto.text);
          DM.CDSItempedido.FieldByName('produto').AsString     := EditDescricaoProduto.text;
        end
        else
          DM.CDSItempedido.Edit;

        DM.CDSItempedido.FieldByName('quantidade').AsFloat   := StrToFloat(editQuantidade.Text);
        DM.CDSItempedido.FieldByName('vlr_unitario').AsFloat := StrToFloat(EditVlrUnitario.Text);
        Total := StrToInt(Editquantidade.Text) * StrToFloat(EditVlrUnitario.Text);
        DM.CDSItempedido.FieldByName('Vlr_total').AsFloat    := Total;
        DM.CDSItempedido.Post;
        GValorTtalPedido                := GValorTtalPedido + Total;
        StatusBar1.Panels.Items[0].Text := 'Valor total do pedido: R$ '+ FormatFloat('#,##0',GValorTtalPedido);
        MEditIdProduto.clear     ;
        editQuantidade.Text             := '';
        EditVlrUnitario.text            := '';
        EditDescricaoProduto.Text       := '' ;
        MEditIdProduto.Enabled:=true;
        MEditIdProduto.SetFocus;
    except on E:Exception do
      showmessage('Falha ao incluir o item no pedido: ' + E.Message);
    end;
  end;
end;


procedure TFormPrincipal.FormShow(Sender: TObject);
begin
  MEditIdCliente.SetFocus;
end;


function TFormPrincipal.FTrataBtnPedido(sIdcliente: string): boolean;
begin
    if (sIdcliente=null) or (sIdcliente=' ') or (sIdcliente='') then
    begin
      GroupBoxPedido.Enabled         :=true;
      GroupBoxProdutosPedido.Enabled :=false;
      GroupBoxPedido.Enabled         :=true;
      ButtonCarregaPedido.Visible    :=true;
      ButtonApagaPedido.Visible      :=true;
      BitBtnGravaPedido.Enabled      :=false;
      EditDescricaoProduto.Text   :='';
      editQuantidade.Text         :='';
      EditVlrUnitario.Text        :='';
      EditNomeCliente.text        :='';
      EditCidade.text             :='';
      EditUF.text                 :='';
      editNomeCliente.Text;
      editCidade.Text             :='';
      editUF.Text                 :='';
      EditEmissaoPedido.Text      :='';
      EditValorTotalPedido.Text   :='';
      MEditIdCliente.Clear;;     ;
      MEditIdProduto.clear;
      MEditNrPedido.Clear;
    end
    else
    begin
      GroupBoxPedido.Enabled          :=false;
      ButtonCarregaPedido.Visible     :=false;
      ButtonApagaPedido.Visible       :=false;
      GroupBoxProdutosPedido.Enabled  :=true;
      BitBtnGravaPedido.Enabled       :=true;
      GValorTtalPedido                :=0;
      DM.CDSItemPedido.EmptyDataSet;
      DM.CDSItemPedido.active:=false;
    end;
end;

procedure TFormPrincipal.MEditIdClienteChange(Sender: TObject);
begin
  FTrataBtnPedido(MEditIdCliente.Text);
end;

procedure TFormPrincipal.MEditIdClienteKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then
  begin
    try
      if strToint(MEditIdCliente.Text) <= 0 then
        showmessage('informe um valor maior que zero!')
      else
      begin
        DM.QryClientes.ParamByName('PIDCLIENTE').asInteger := strtoint(MEditIdCliente.Text);
        if DM.QryClientes.Active then
          DM.QryClientes.Refresh
        else
          DM.QryClientes.Open;

        if DM.QryClientes.IsEmpty then
          showmessage('Cliente não encontrado!')
        else
        begin
          EditNomeCliente.text  := DM.QryClientes.FieldByName('nome').Value;
          Editcidade.text       := DM.QryClientes.FieldByName('cidade').Value;
          Edituf.text           := DM.QryClientes.FieldByName('uf').Value
        end
      end;
      MEditIdProduto.SetFocus;
    except on E:Exception do
      showmessage('Valor inválido: ' + E.Message);
    end;
  end;
end;

procedure TFormPrincipal.MEditIdProdutoKeyPress(Sender: TObject; var Key: Char);
begin
 if key = #13 then
  begin
    try
      if strToint(MEditIdProduto.Text)<=0 then
        showmessage('informe um valor maior que zero!')
      else
      begin
        DM.QryProdutos.ParamByName('PIDPRODUTO').asInteger := strtoint(MEditIdProduto.Text);
        if DM.QryProdutos.Active then
          DM.QryProdutos.Refresh
        else
          DM.QryProdutos.Open;

        if DM.QryProdutos.IsEmpty then
          showmessage(' Produto não encontrado!')
        else
        begin
          EditDescricaoProduto.text := DM.QryProdutos.FieldByName('descricao').Value;
          EditVlrUnitario.text      := FormatFloat('#,##0',DM.QryProdutos.FieldByName('preco_venda').Value);
          EditQuantidade.SetFocus;
        end;
      end;
    except on E:Exception do
      showmessage('Valor inválido: ' + E.Message);
    end;
  end;
end;

procedure TFormPrincipal.MEditNrPedidoChange(Sender: TObject);
begin
  if (MEditNrPedido.Text=null) or (MEditNrPedido.Text='') or (MEditNrPedido.Text=' ') then
  begin
    ButtonCarregaPedido.Visible :=false;
    ButtonApagaPedido.Visible   :=false;
  end
  else
  begin
    ButtonCarregaPedido.Visible :=true;
    ButtonApagaPedido.Visible   :=true
  end;
end;

procedure TFormPrincipal.MEditNrPedidoKeyPress(Sender: TObject; var Key: Char);
begin
 if key = #13 then
    ButtonCarregaPedido.SetFocus;
end;

end.
