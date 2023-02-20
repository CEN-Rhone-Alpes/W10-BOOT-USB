@echo off

powershell -ExecutionPolicy bypass "$xmlWriter =[xml](Get-Content -Path  .\unattend.xml)"

echo Debut de Tache...
powershell -ExecutionPolicy bypass -File "./UnattendWriter.ps1"


echo Fin de Tache...
powershell "Start-Sleep -Seconds 5"

exit