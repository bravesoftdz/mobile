unit classes.ScriptDDL;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants;

type
  TScriptDDL = class(TObject)
    strict private
      class var aInstance : TScriptDDL;
      const
        TABLE_VERSAO      = 'app_versao';
        TABLE_INFO        = 'app_info';
        TABLE_NOTIFICACAO = 'app_notificacao';
        TABLE_USUARIO     = 'tbl_usuario';
        TABLE_PEDIDO      = 'tbl_pedido';
        TABLE_CLIENTE     = 'tbl_cliente';
    public
      class function GetInstance : TScriptDDL;

      function getCreateTableVersao : TStringList;
      function getCreateTableNotificacao : TStringList;
      function getCreateTableUsuario : TStringList;
      function getCreateTablePedido : TStringList;
      function getCreateTableCliente : TStringList;

      function getTableNameVersao : String;
      function getTableNameInfo : String;
      function getTableNameNotificacao : String;
      function getTableNameUsuario : String;
      function getTableNamePedido : String;
      function getTableNameCliente : String;
  end;

implementation

{ TScriptDDL }

function TScriptDDL.getCreateTableCliente: TStringList;
var
  aSQL : TStringList;
begin
  // Exemplos de ID no formato GUID
  // ['{0A7BA6EA-7E57-42E8-9B05-874A64442798}'] - Cliente 1
  // ['{5F3D9FF3-A6B9-44CA-B07F-33AAC4AA4475}'] - Cliente 2
  aSQL := TStringList.Create;
  try
    aSQL := TStringList.Create;
    aSQL.Clear;
    aSQL.BeginUpdate;
    aSQL.Add('CREATE TABLE IF NOT EXISTS ' + TABLE_CLIENTE + ' (');
    aSQL.Add('      id_cliente      VARCHAR (38) NOT NULL PRIMARY KEY');
    aSQL.Add('    , cd_cliente      BIGINT  (10) UNIQUE ON CONFLICT ROLLBACK');
    aSQL.Add('    , nm_cliente      VARCHAR (100)');
    aSQL.Add('    , tp_cliente      CHAR(1) DEFAULT (' + QuotedStr('F') + ') NOT NULL'); // F - Pessoa F�sica, J - Pessoa Jur�dica
    aSQL.Add('    , nr_cpf_cnpj     VARCHAR (20)');
    aSQL.Add('    , ds_contato      VARCHAR (100)');
    aSQL.Add('    , nr_telefone     VARCHAR (20)');
    aSQL.Add('    , nr_celular      VARCHAR (20)');
    aSQL.Add('    , ds_observacao   VARCHAR (500)');
    aSQL.Add('    , sn_ativo        CHAR(1) DEFAULT (' + QuotedStr('S') + ') NOT NULL');
    aSQL.Add('    , sn_sincronizado CHAR(1) DEFAULT (' + QuotedStr('N') + ') NOT NULL');
    aSQL.Add('    , cd_referencia   VARCHAR (38)'); // Refer�ncia do Cliente no Servidor Web (ID)
    aSQL.Add(')');
    aSQL.EndUpdate;
  finally
    Result := aSQL;
  end;
end;

function TScriptDDL.getCreateTableNotificacao: TStringList;
begin
  ;
end;

function TScriptDDL.getCreateTablePedido: TStringList;
var
  aSQL : TStringList;
begin
  // Exemplos de ID no formato GUID
  // ['{4B0A0C47-8A62-4E8D-AECF-074BE7D4CBC1}'] - Pedido  1
  // ['{AF73EDCF-870F-45AC-A3E7-75458A920DBA}'] - Pedido  2
  aSQL := TStringList.Create;
  try
    aSQL := TStringList.Create;
    aSQL.Clear;
    aSQL.BeginUpdate;
    aSQL.Add('CREATE TABLE IF NOT EXISTS ' + TABLE_PEDIDO + ' (');
    aSQL.Add('      id_pedido       VARCHAR (38) NOT NULL PRIMARY KEY');
    aSQL.Add('    , cd_pedido       BIGINT  (10) UNIQUE ON CONFLICT ROLLBACK');
    aSQL.Add('    , tp_pedido       CHAR(1) DEFAULT (' + QuotedStr('O') + ') NOT NULL'); // O - Or�amento, P - Pedido
    aSQL.Add('    , id_cliente      VARCHAR (38) NOT NULL');
    aSQL.Add('    , ds_contato      VARCHAR (100)');
    aSQL.Add('    , ds_observacao   VARCHAR (500)');
    aSQL.Add('    , dt_pedido       DATE');
    aSQL.Add('    , vl_total        NUMERIC (15,2) DEFAULT (0)');
    aSQL.Add('    , vl_desconto     NUMERIC (15,2) DEFAULT (0)');
    aSQL.Add('    , vl_pedido       NUMERIC (15,2) DEFAULT (0)'); //  (vl_pedido = vl_total -  vl_desconto)
    aSQL.Add('    , sn_ativo        CHAR(1) DEFAULT (' + QuotedStr('S') + ') NOT NULL');
    aSQL.Add('    , sn_entregue     CHAR(1) DEFAULT (' + QuotedStr('N') + ') NOT NULL');
    aSQL.Add('    , sn_sincronizado CHAR(1) DEFAULT (' + QuotedStr('N') + ') NOT NULL');
    aSQL.Add('    , cd_referencia   VARCHAR (38)'); // Refer�ncia do Pedido no Servidor Web (ID)
    aSQL.Add(')');
    aSQL.EndUpdate;
  finally
    Result := aSQL;
  end;
end;

function TScriptDDL.getCreateTableUsuario: TStringList;
var
  aSQL : TStringList;
begin
  aSQL := TStringList.Create;
  try
    aSQL := TStringList.Create;
    aSQL.Clear;
    aSQL.BeginUpdate;
    aSQL.Add('CREATE TABLE IF NOT EXISTS ' + TABLE_USUARIO + ' (');
    aSQL.Add('      id_usuario     VARCHAR (38) NOT NULL PRIMARY KEY');
    aSQL.Add('    , nm_usuario     VARCHAR (50)');
    aSQL.Add('    , ds_email       VARCHAR (50)');
    aSQL.Add('    , ds_senha       VARCHAR (100)');
    aSQL.Add('    , nr_celular     VARCHAR (50)');
    aSQL.Add('    , nr_cpf         VARCHAR (15)');
    aSQL.Add('    , id_dispositivo VARCHAR (250)');
    aSQL.Add('    , tk_dispositivo VARCHAR (250)');
    aSQL.Add('    , sn_ativo       CHAR (1) DEFAULT (' + QuotedStr('1') + ') NOT NULL');
    aSQL.Add(')');
    aSQL.EndUpdate;
  finally
    Result := aSQL;
  end;
end;

function TScriptDDL.getCreateTableVersao: TStringList;
var
  aSQL : TStringList;
begin
  aSQL := TStringList.Create;
  try
    aSQL.Clear;
    aSQL.BeginUpdate;
    aSQL.Add('CREATE TABLE IF NOT EXISTS ' + TABLE_VERSAO + ' (');
    aSQL.Add('      cd_versao INTEGER NOT NULL PRIMARY KEY');
    aSQL.Add('    , ds_versao VARCHAR (30)');
    aSQL.Add('    , dt_versao DATE');
    aSQL.Add(')');
    aSQL.EndUpdate;
  finally
    Result := aSQL;
  end;
end;

class function TScriptDDL.GetInstance: TScriptDDL;
begin
  if not Assigned(aInstance) then
    aInstance := TScriptDDL.Create;

  Result := aInstance;
end;

function TScriptDDL.getTableNameCliente: String;
begin
  Result := TABLE_CLIENTE;
end;

function TScriptDDL.getTableNameInfo: String;
begin
  Result := TABLE_INFO;
end;

function TScriptDDL.getTableNameNotificacao: String;
begin
  Result := TABLE_NOTIFICACAO;
end;

function TScriptDDL.getTableNamePedido: String;
begin
  Result := TABLE_PEDIDO;
end;

function TScriptDDL.getTableNameUsuario: String;
begin
  Result := TABLE_USUARIO;
end;

function TScriptDDL.getTableNameVersao: String;
begin
  Result := TABLE_VERSAO;
end;

end.