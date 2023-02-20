@echo off
echo Copie de la Cle Windows...
powershell -ExecutionPolicy Bypass "(Set-Clipboard -Value (Get-WmiObject -query 'select * from SoftwareLicensingService').OA3xOriginalProductKey)"
powershell -ExecutionPolicy Bypass "((Get-WmiObject -query 'select * from SoftwareLicensingService').OA3xOriginalProductKey)"
powershell "Start-Sleep -Seconds 1
echo Cle Windows Copier avec Succes
powershell "Start-Sleep -Seconds 5"
exit