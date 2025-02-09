; -- 64BitThreeArch.iss --
; Demonstrates how to install a program built for three different
; architectures (x86, x64, Arm64) using a single installer.

; SEE THE DOCUMENTATION FOR DETAILS ON CREATING .ISS SCRIPT FILES!

[Setup]
AppName=Requests externalizer
AppVersion=1.0.0
WizardStyle=modern
DefaultDirName={autocf}\Requests-externalizer
DefaultGroupName=Requests externalizer
UninstallDisplayIcon={app}\requests-externalizer.exe
UninstallDisplaySize=3525632
Compression=lzma2
SolidCompression=yes
OutputDir=.\installers
WizardSmallImageFile=.\winres\icon128.bmp
OutputBaseFilename=Requests-externalizer-installer-windows-all
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog
; "ArchitecturesInstallIn64BitMode=x64compatible or arm64" instructs
; Setup to use "64-bit install mode" on x64-compatible systems and
; Arm64 systems, meaning Setup should use the native 64-bit Program
; Files directory and the 64-bit view of the registry. On all other
; OS architectures (e.g., 32-bit x86), Setup will use "32-bit
; install mode".
ArchitecturesInstallIn64BitMode=x64compatible or arm64

[Files]
; In order of preference, we want to install:
; - Arm64 binaries on Arm64 systems
; - else, x64 binaries on x64-compatible systems
; - else, x86 binaries

; Place all Arm64-specific files here, using 'Check: PreferArm64Files' on each entry.
Source: ".\bin\requests-externalizer-arm64.exe"; DestDir: "{app}"; DestName: "requests-externalizer.exe"; Check: PreferArm64Files; AfterInstall: InstallManifest

; Place all x64-specific files here, using 'Check: PreferX64Files' on each entry.
; Only the first entry should include the 'solidbreak' flag.
Source: ".\bin\requests-externalizer-x64.exe"; DestDir: "{app}"; DestName: "requests-externalizer.exe"; Check: PreferX64Files; AfterInstall: InstallManifest; Flags: solidbreak

; Place all x86-specific files here, using 'Check: PreferX86Files' on each entry.
; Only the first entry should include the 'solidbreak' flag.
Source: ".\bin\requests-externalizer-x86.exe"; DestDir: "{app}"; DestName: "requests-externalizer.exe"; Check: PreferX86Files; AfterInstall: InstallManifest; Flags: solidbreak

[Registry]
Root: HKA; Subkey: "SOFTWARE\Google\Chrome\NativeMessagingHosts\es.requests.externalizer"; ValueType: string; ValueData: "{localappdata}\Requests-externalizer\config\manifest.json"; Flags: uninsdeletekey
Root: HKA; Subkey: "SOFTWARE\Mozilla\NativeMessagingHosts\es.requests.externalizer"; ValueType: string; ValueData: "{localappdata}\Requests-externalizer\config\firefox-manifest.json"; Flags: uninsdeletekey

[Icons]
Name: "{group}\Request externalizer"; Filename: "{app}\requests-externalizer.exe"

[Code]
function PreferArm64Files: Boolean;
begin
  Result := IsArm64;
end;

function PreferX64Files: Boolean;
begin
  Result := not PreferArm64Files and IsX64Compatible;
end;

function PreferX86Files: Boolean;
begin
  Result := not PreferArm64Files and not PreferX64Files;
end;

procedure InstallManifest();
var
  AppPath : String;
  CommonManifestStart : String;
  ChromeExtOrigin : String;
  FirefoxExtOrigin : String;
  ManifestEnding : String;
begin
  AppPath := ExpandConstant('{app}');
  StringChangeEx(AppPath, '\', '\\', True);
  CommonManifestStart := '{' + #13#10 +
    '"name": "es.requests.externalizer",' + #13#10 +
    '"description": "Requests externalizer native app",' + #13#10 +
    '"path": "' + AppPath + '\\requests-externalizer.exe",' + #13#10 +
    '"type": "stdio",' + #13#10;
  ChromeExtOrigin := '"allowed_origins": ["chrome-extension://cleklecjnonjaggdaljfjhgfapphjjig/"]' + #13#10;
  FirefoxExtOrigin := '"allowed_extensions": ["requests-externalizer@dokkaltek.es"]' + #13#10;
  ManifestEnding := '}';
  

  // Make sure config directories exist
  ForceDirectories(ExpandConstant('{localappdata}') + '\Requests-externalizer\config\');
  
  // Save the chrome manifest
  SaveStringToFile(ExpandConstant('{localappdata}') + '\Requests-externalizer\config\manifest.json', 
  CommonManifestStart + ChromeExtOrigin + ManifestEnding, False);
  
  // Save the firefox manifest
  SaveStringToFile(ExpandConstant('{localappdata}') + '\Requests-externalizer\config\firefox-manifest.json', 
  CommonManifestStart + FirefoxExtOrigin + ManifestEnding, False);
end;
