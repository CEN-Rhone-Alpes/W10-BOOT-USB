@echo off

powershell Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser -Force

powershell -ExecutionPolicy Bypass -File "C:\Windows\Panther\InstalCustome\Execute.ps1" "/verysilent"

powershell -ExecutionPolicy Bypass "Start-process powershell -Verb runAs C:\Windows\Panther\InstalCustome\FullSetupAdmin.ps1"

powershell Start-Sleep -Seconds 180

powershell -ExecutionPolicy Bypass -File "C:\Windows\Panther\InstalCustome\BiosManufacturer.ps1" "/verysilent"

powershell -ExecutionPolicy Bypass -File "C:\Windows\Panther\InstalCustome\Lecteur.ps1" "/verysilent"

powershell -ExecutionPolicy Bypass -File "C:\Windows\Panther\InstalCustome\TrueInstallApp.ps1" "/verysilent"

Pause


