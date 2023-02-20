# Wifi #
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser -Force
$NumberWIFI =(((Get-Item -Path C:\Windows\Panther\InstalCustome\WI-FI\*.xml | Select-Object -Property name).count))
$LISTWIFI=(Get-Item -Path C:\Windows\Panther\InstalCustome\WI-FI\*.xml | Select-Object -Property name).Name
$ExecutWIFI =(0)

Do{
$NAMEXML=($LISTWIFI.Item($ExecutWIFI))
netsh wlan add profile filename=C:\Windows\Panther\InstalCustome\WI-FI\$NAMEXML
if( $? -eq $false){Pause}
$ExecutWIFI=($ExecutWIFI+1)
Write-Host "Wi-Fi :" $ExecutWIFI "/" $NumberWIFI} Until($NumberWIFI -eq $ExecutWIFI)
Write-Host "WiFi Ready"

#Start-Process powershell -Verb runAs "C:\Windows\Panther\InstalCustome\FullSetupAdmin.ps1" -WindowStyle Maximized
#if( $? -eq $false){Pause}