# Choix Geo #
$xmlCode =[xml](Get-Content -Path C:\Windows\Panther\unattend.xml -Force)
$Code = $xmlCode.unattend.settings.component.FirstLogonCommands.SynchronousCommand[2].CommandLine
if($? -eq $false){$?
$Code = '4269'}

# Install Module #
Install-PackageProvider -Name NuGet -Confirm:$false -Force
if( $? -eq $false){$?}
Install-Module -Name AudioDeviceCmdlets -Confirm:$false -Force
if( $? -eq $false){$?}
Import-Module C:\Windows\Panther\InstalCustome\Set-WindowState.ps1 -Force
if( $? -eq $false){$?}

# Audio 0% #
Set-AudioDevice -PlaybackVolume 0
if( $? -eq $false){$?}

# Stop Edge #
ps msedge | Stop-Process -Force
if( $? -eq $false){$?}

# Copy Hosts #
Copy-Item C:\Windows\Panther\InstalCustome\hosts -Destination C:\Windows\System32\drivers\etc -Force
if( $? -eq $false){$?}

# Impriment Supprime #
Start-Sleep -Seconds 2
Remove-Printer -Name "OneNote"
Remove-Printer -Name "Microsoft XPS Document Writer"
if( $? -eq $false){$?}

# Play Fox #
Start-Process -FilePath "C:\Windows\Panther\InstalCustome\Firefox Installer.exe" "/verysilent"
Do{
Start-Sleep -Seconds 5
$fox = Get-Process -Name 'Firefox Installer'
$fox
Start-Sleep -Seconds 2
}Until($fox.SI -lt 1)
$loopnum = 0
Do{
Start-Process firefox https://www.mozilla.org/fr/firefox/set-as-default/thanks/
Start-Sleep -Seconds 4
if($loopnum -ge 5){$loopnum = 0
break}
$loopnum++
$ProgIDname = (Get-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice' -Name ProgId).ProgID
$ProgIDname
}Until($ProgIDname -like "Firefox*")
Stop-Process -Name firefox
if( $? -eq $false){$?}

# Alimentation #
powercfg /l
powercfg /setdcvalueindex 381b4222-f694-41f0-9685-ff5bb260df2e 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0
powercfg /setacvalueindex 381b4222-f694-41f0-9685-ff5bb260df2e 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0
if( $? -eq $false){$?}

# ShadowStorage #
Enable-ComputerRestore -Drive c:
vssadmin Resize ShadowStorage /For=C: /On=C: /Maxsize=10%
vssadmin list shadowstorage#
if( $? -eq $false){$?}

