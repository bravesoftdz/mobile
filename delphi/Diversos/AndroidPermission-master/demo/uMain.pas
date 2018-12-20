unit uMain;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.GraphicsContentViewText,
  FMX.Permissions.Android,

  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Objects;

type
  TForm1 = class(TForm)
    Text1: TText;
    Layout1: TLayout;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure PermissionCallback(AAndroidPermission: TAndroidPermission; APermissions: TJavaObjectArray<JString>; AGrantResults: TJavaArray<Integer>);
    procedure RequestPermissionReadContacts;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
 RequestPermissionReadContacts;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  AndroidPermissions.onRequestPermissionsResult:=PermissionCallback;
end;

procedure TForm1.PermissionCallback(AAndroidPermission: TAndroidPermission; APermissions: TJavaObjectArray<JString>;
  AGrantResults: TJavaArray<Integer>);
begin
  case AAndroidPermission of
    apREAD_CONTACTS:
    begin
      // If request is cancelled, the result arrays are empty.
      // * Se a solicita��o for cancelada, as matrizes de resultado estar�o vazias.
      if (AGrantResults.Length > 0 ) and (AGrantResults[0] = TJPackageManager.JavaClass.PERMISSION_GRANTED) then
      begin
        // permission was granted, yay! Do the
        // contacts-related task you need to do.
        // * Permiss�o foi concedida, yay! Fa�a a tarefa relacionada aos contatos que voc� precisa fazer.
      end
      else
      begin
        // permission denied, boo! Disable the
        // functionality that depends on this permission
        // * Permiss�o negada, vaia! Desativar a funcionalidade que depende dessa permiss�o
      end;

    end;
    // other 'case' lines to check for other
    // permissions this app might request
    // * Outras linhas de 'casos' para verificar
    // * outras permiss�es que este aplicativo pode solicitar
  end;
end;


procedure TForm1.RequestPermissionReadContacts;
begin
  if (AndroidPermissions.checkSelfPermission(apREAD_CONTACTS)<>TJPackageManager.JavaClass.PERMISSION_GRANTED ) then
  begin
    // Should we show an explanation?
    // * Devemos mostrar uma explica��o?
    if (AndroidPermissions.shouldShowRequestPermissionRationale(apREAD_CONTACTS)) then
    begin
      // Show an expanation to the user *asynchronously* -- don't block
      // this thread waiting for the user's response! After the user
      // sees the explanation, try again to request the permission.
      // * Mostrar uma expans�o para o usu�rio * de forma ass�ncrona *,
      // * n�o bloqueie este thread aguardando a resposta do usu�rio! Depois
      // * que o usu�rio v� a explica��o, tente novamente solicitar a permiss�o.
    end
    else
    begin
      // No explanation needed, we can request the permission.
      // * Nenhuma explica��o necess�ria, podemos solicitar a permiss�o.
      AndroidPermissions.requestPermissions(apREAD_CONTACTS);
    end;

  end;
end;

end.
