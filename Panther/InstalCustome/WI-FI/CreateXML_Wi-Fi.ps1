$WI_FI_NAME=(Get-NetConnectionProfile| select-Object -Property Name).Name
netsh wlan export profile name=$WI_FI_NAME key=clear folder=.\
Start-Sleep -Seconds 5