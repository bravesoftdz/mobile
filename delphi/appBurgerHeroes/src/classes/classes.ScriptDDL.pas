unit classes.ScriptDDL;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants;

type
  TScriptDDL = class(TObject)
    private
      class var aInstance : TScriptDDL;
      const
        TABLE_VERSAO        = 'tbl_versao';
        TABLE_INFO          = 'tbl_info';
        TABLE_USUARIO       = 'tbl_usuario';
        TABLE_ESPECIALIDADE = 'tbl_especialidade';
        TABLE_NOTIFICACAO   = 'app_notificacao';
        TABLE_MENSAGEM      = 'app_mensagem';
    public
      class function GetInstance : TScriptDDL;
      function getCreateTableVersao : TStringList;
      function getCreateTableEspecialidade : TStringList;
      function getCreateTableUsuario : TStringList;
      function getCreateTableNotificacao : TStringList; virtual; abstract;
      function getCreateTableMensagem : TStringList; virtual; abstract;
      function getAlterTableUsuario : TStringList;

      function getTableNameEspecialidade : String;
      function getTableNameUsuario : String;
      function getTableNameNotificacao : String;
      function getTableNameMensagem : String;
  end;

implementation

{ TScriptDDL }

function TScriptDDL.getAlterTableUsuario: TStringList;
var
  aSQL : TStringList;
begin
  aSQL := TStringList.Create;
  try
    aSQL.Clear;
    aSQL.BeginUpdate;
    aSQL.Add('ALTER TABLE ' + TABLE_USUARIO + ' ');
    aSQL.Add('      ADD nr_celular     STRING (50)');
    aSQL.Add('    , ADD id_dispositivo STRING (250)');
    aSQL.Add('    , ADD dk_dispositivo STRING (250)');
    aSQL.EndUpdate;
  finally
    Result := aSQL;
  end;
end;

function TScriptDDL.getCreateTableEspecialidade: TStringList;
var
  aSQL : TStringList;
begin
  aSQL := TStringList.Create;
  try
    aSQL.Clear;
    aSQL.BeginUpdate;
    aSQL.Add('CREATE TABLE IF NOT EXISTS ' + TABLE_ESPECIALIDADE + ' (');
    aSQL.Add('      cd_especialidade INTEGER NOT NULL PRIMARY KEY');
    aSQL.Add('    , ds_especialidade STRING (50)');
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
    aSQL.Add('      id_usuario     STRING (38) NOT NULL PRIMARY KEY');
    aSQL.Add('    , cd_usuario     STRING (30) NOT NULL');
    aSQL.Add('    , nm_usuario     STRING (50)');
    aSQL.Add('    , ds_email       STRING (50)');
    aSQL.Add('    , ds_senha       STRING (100)');
    aSQL.Add('    , cd_prestador   NUMERIC');
    aSQL.Add('    , ds_observacao  STRING (50)');
    aSQL.Add('    , nr_celular     STRING (50)');
    aSQL.Add('    , id_dispositivo STRING (250)');
    aSQL.Add('    , tk_dispositivo STRING (250)');
    aSQL.Add('    , sn_ativo       STRING (1) NOT NULL');
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
    aSQL.Add('    , ds_versao STRING (30)');
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

function TScriptDDL.getTableNameEspecialidade: String;
begin
  Result := TABLE_ESPECIALIDADE;
end;

function TScriptDDL.getTableNameMensagem: String;
begin
  Result := TABLE_MENSAGEM;
end;

function TScriptDDL.getTableNameNotificacao: String;
begin
  Result := TABLE_NOTIFICACAO;
end;

function TScriptDDL.getTableNameUsuario: String;
begin
  Result := TABLE_USUARIO;
end;

end.
