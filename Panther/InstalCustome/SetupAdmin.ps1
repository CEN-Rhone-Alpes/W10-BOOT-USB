
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
