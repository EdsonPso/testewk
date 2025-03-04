unit Unit_DataComponent;

interface

uses
System.SysUtils, System.Classes, FireDAC.Phys.MySQLDef, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, IniFiles, Windows, Forms,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Dialogs, FireDAC.VCLUI.Login,
  Datasnap.DBClient;

type
  TDM = class(TDataModule)
    FDConnection: TFDConnection;
    QryClientes: TFDQuery;
    QryPedidos: TFDQuery;
    QryProdutos: TFDQuery;
    QryMaxPedido: TFDQuery;
    FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDGUIxLoginDialog1: TFDGUIxLoginDialog;
    DSItemPedido: TDataSource;
    CDSItemPedido: TClientDataSet;
    DSPedidosProdutos: TDataSource;
    QryPedidosProdutos: TFDQuery;
    QryGravaPedido: TFDQuery;
    QryGravaPedido_produto: TFDQuery;
    CDSItemPedidoproduto: TStringField;
    CDSItemPedidoquantidade: TFloatField;
    CDSItemPedidovlr_unitario: TFloatField;
    CDSItemPedidovlr_total: TFloatField;
    CDSItemPedidoidprodutos: TIntegerField;
    QryExcluiPedido: TFDQuery;
    QryPedidosProdutosdescricao: TStringField;
    QryPedidosProdutosquantidade: TBCDField;
    QryPedidosProdutosvlr_unitario: TBCDField;
    QryPedidosProdutosvlr_total: TBCDField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    Iconfdb: TIniFile;
    sServer:string;
    iPorta:integer;
    sDatabase:string;
    sUsuario:string;
    sPass:string;
    sDriverID:string;

  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Unit_principal;

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  try
    Iconfdb:=TIniFile.Create(extractFilePath(Application.ExeName)+'teste_wk.ini');
    sDriverID := Iconfdb.ReadString('MySQL','DriverID','');
    sServer   := Iconfdb.ReadString('MySQL','Server','');
    iPorta    := Iconfdb.ReadInteger('MySQL','Port',0);
    sDatabase := Iconfdb.ReadString('MySQL','Database','');
    sUsuario  := Iconfdb.ReadString('MySQL','UserName','');
    sPass     := Iconfdb.ReadString('MySQL','Password','');

    FDConnection.Params.Add('Server='+sServer);
    FDConnection.Params.Add('Port='+IntToStr(iPorta));
    FDConnection.Params.Add('Database='+sDatabase);
    FDConnection.Params.Add('User_Name='+sUsuario);
    FDConnection.Params.Add('Password='+sPass);

    Iconfdb.Free ;

    FDConnection.open
  except on E:Exception do
        showmessage('Falha ao conectr com o banco de dados!' + E.Message);
  end;
end;

end.
