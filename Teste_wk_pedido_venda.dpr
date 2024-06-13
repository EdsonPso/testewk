program Teste_wk_pedido_venda;

uses
  Vcl.Forms,
  Unit_DataComponent in 'fontes\Unit_DataComponent.pas' {DM: TDataModule},
  Unit_principal in 'fontes\Unit_principal.pas' {FormPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
