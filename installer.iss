; Pointr Laser Pointer Configurator Installer Script
; Requires Inno Setup 6.x or later

[Setup]
AppId={{A1B2C3D4-E5F6-4A5B-8C7D-8E9F0A1B2C3D}
AppName=Pointr
AppVersion=0.0.1
AppPublisher=BFPoint
AppPublisherURL=https://bfpoint.com
AppSupportURL=https://bfpoint.com/support
AppUpdatesURL=https://bfpoint.com/updates
DefaultDirName={pf}\Pointr
DefaultGroupName=Pointr
AllowNoIcons=yes
OutputDir=installer_output
OutputBaseFilename=pointr-setup-0.0.1
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
; Disable the "Select Start Menu Folder" page
DisableStartMenuPage=yes
; Disable the "Select Additional Tasks" page
DisableProgramGroupPage=yes

[Languages]
Name: "chinesesimp"; MessagesFile: "compiler:Languages\ChineseSimp.isl"
Name: "english"; MessagesFile: "compiler:Languages\English.isl"

[Tasks]
Name: "desktopicon"; Description: "Create a desktop icon"; GroupDescription: "Additional icons:"; Flags: unchecked

[Files]
Source: "build\windows\x64\runner\Release\pointr.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "README.md"; DestDir: "{app}"; Flags: ignoreversion; Attribs: readonly; Check: exists

[Icons]
Name: "{group}\Pointr"; Filename: "{app}\pointr.exe"
Name: "{group}\Uninstall Pointr"; Filename: "{uninstallexe}"

[Run]
Filename: "{app}\pointr.exe"; Description: "Launch Pointr"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: files; Name: "{app}\*"

[Code]
// Prevent installation if application is running
function IsAppRunning: Boolean;
var
  ResultCode: Integer;
begin
  Result := False;
  if CheckForMutexes('Global\PointrLaserPointerConfigurator') then
  begin
    Result := True;
    MsgBox('Pointr is currently running. Please close it before installing.', mbError, MB_OK);
  end;
end;

function InitializeSetup(): Boolean;
begin
  Result := not IsAppRunning;
end;

function InitializeUninstall(): Boolean;
begin
  Result := not CheckForMutexes('Global\PointrLaserPointerConfigurator');
  if not Result then
    MsgBox('Pointr is currently running. Please close it before uninstalling.', mbError, MB_OK);
end;
