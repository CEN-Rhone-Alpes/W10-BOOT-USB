
# Choix Geo #
$xmlCode =[xml](Get-Content -Path C:\Windows\Panther\unattend.xml -Force)
$Code = $xmlCode.unattend.settings.component.FirstLogonCommands.SynchronousCommand[2].CommandLine
if($? -eq $false){$?
$Code = '4269'}
