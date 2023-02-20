#Instal module#
Import-Module .\Set-WindowState.ps1 -Force
if( $? -eq $false){$?}
Get-Process -Name cmd | Set-WindowState -State HIDE
if( $? -eq $false){$?}

$xmlWriter =[xml](Get-Content -Path  .\unattend.xml -Force)

#Appel de module#
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")


#Dessin de L'interface#
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Unattend Writer"
$Form.Icon = ".\Image\Icon-Shell.ico"
$Form.Size = New-Object System.Drawing.Size(300,270)
$Form.StartPosition = "CenterScreen"
$Form.BackgroundImage = [system.drawing.image]::FromFile(".\Image\Background.jpg")
$Form.BackgroundImageLayout = "Center",1
$Form.MaximumSize = $Form.Size
$Form.MinimumSize = $Form.Size

#ClavierShortCut#
$Form.KeyPreview = $True
$Form.Add_KeyDown({if ($_.KeyCode -eq "Enter")
{& $xmlCreate}})
$Form.Add_KeyDown({if ($_.KeyCode -eq "Escape")
{$Form.Close()}})
$Form.Add_KeyDown({if ($_.KeyCode -eq "F2")
{Start-Process https://support.microsoft.com/fr-fr/windows/trouver-votre-cl%C3%A9-de-produit-windows-aaa2bf69-7b2b-9f13-f581-a806abf0a886}})
$Form.Add_KeyDown({if ($_.KeyCode -eq "F1")
{$LC=((Get-Location).Drive.Name)+(':\sources\$OEM$\$$\Panther\InstalCustome\SoftwareLicensingService.bat')
Start-Process $LC -WindowStyle Hidden
$Achiv = 0
$form.Controls.Add($loadingBar)
Do{$Achiv=$Achiv+1
$loadingBar.Value=$Achiv
$statusBar1.Text=$Achiv,"%"
Start-Sleep -Milliseconds 1} Until($Achiv -eq 100)
$Form.Controls.Remove($loadingBar)
$statusBar1.Text = "Ready..."}})

#Action du button#
$xmlCreate={Write-Host("OK_click_On")
$statusBar1.Text = "Testing..."
$LW10NoSafe = $textbox1.Text
$NameNoSafe = $textbox2.Text
$LW10 = $LW10NoSafe.ToString().ToUpper()
if($NameNoSafe -like 'STAGE'){$Name = $NameNoSafe}
if($NameNoSafe -notlike 'STAGE'){
$Name = $NameNoSafe.ToString().ToLower()}
if($NameNoSafe -like 'stage'){$Name = $NameNoSafe.ToString().ToUpper()}
$SetPassExpires = "cmd /C wmic useraccount where name='$Name' set PasswordExpires=false"
$NameUpper=($Name.Substring(0,2).ToUpper())
if($Liste.SelectedItem -like "Vourles (4269)"){$Zone = '4269'}
if($Liste.SelectedItem -like "Charnoz (01)"){$Zone = '01'}
if($Liste.SelectedItem -like "Vogue (0726)"){$Zone = '0726'}
if($Liste.SelectedItem -like ""){$Zone = $null}
if($ListeW.SelectedItem -like "Windows 10"){$Windows = '10'}
if($ListeW.SelectedItem -like "Windows 11"){$Windows = '11'}
if($ListeW.SelectedItem -like ""){$Windows = $null}
if($Zone -notlike $null){
if($LW10.Length -eq 29){
$xmlWriter.unattend.settings.component.UserData.ProductKey.Key=$LW10
$xmlWriter.unattend.settings.component[1].ComputerName=$Name
$xmlWriter.unattend.settings.component[1].ProductKey=$LW10
$xmlWriter.unattend.settings.component.UserAccounts.LocalAccounts.LocalAccount.Name=$Name
$xmlWriter.unattend.settings.component.UserAccounts.LocalAccounts.LocalAccount.Password.Value=$Name
$xmlWriter.unattend.settings.component[2].AutoLogon.Username = $Name
$xmlWriter.unattend.settings.component.AutoLogon.Password.Value=$Name
$xmlWriter.unattend.settings.component.UserAccounts.LocalAccounts.LocalAccount.Description=$NameUpper
$xmlWriter.unattend.settings.component.FirstLogonCommands.SynchronousCommand[2].CommandLine=$Zone
$xmlWriter.unattend.settings.component.FirstLogonCommands.SynchronousCommand[3].CommandLine=$SetPassExpires
$xmlWriter.unattend.settings.component.UserData.ProductKey.Key
$xmlWriter.unattend.settings.component[1].ProductKey
$xmlWriter.unattend.settings.component.AutoLogon.Username
$xmlWriter.unattend.settings.component.AutoLogon.Password.Value
$xmlWriter.unattend.settings.component.UserAccounts.LocalAccounts.LocalAccount.Name
$xmlWriter.unattend.settings.component.UserAccounts.LocalAccounts.LocalAccount.Password.Value
$xmlWriter.unattend.settings.component.UserAccounts.LocalAccounts.LocalAccount.Description
$xmlWriter.unattend.settings.component.FirstLogonCommands.SynchronousCommand[2].CommandLine
$xmlWriter.Save("./unattend.xml")
$RS=((Get-Location).Drive.Name)+(':\sources\$OEM$\$$\Panther')
Copy-Item -Path "./unattend.xml" -Destination $RS -PassThru -Force
$Achiv = 0
$form.Controls.Add($loadingBar)
Do{$Achiv=$Achiv+1
$loadingBar.Value=$Achiv
$statusBar1.Text=$Achiv,"%"
Start-Sleep -Milliseconds 1} Until($Achiv -eq 100)
$Form.Controls.Remove($loadingBar)
$statusBar1.Text = "Finish..."
Write-Host("OK_click_Off")
$form.Close()
}
else{$statusBar1.Text = "Error Cle Windows"
if($LW10.Length -ne 29){$statusBar1.Text = "Error Cle Windows : Longeur non respecter"}
if($LW10.Contains("-") -like $false){$statusBar1.Text = "Error Cle Windows : Pas de Separator"}}}
else{$statusBar1.Text = "Error Zone non selectione"}}


#LabelEnter#
$labelEnter = New-Object System.Windows.Forms.Label
$labelEnter.BackColor = "Transparent"
$labelEnter.Location = New-Object System.Drawing.Size(65,165)
$labelEnter.Size = New-Object System.Drawing.Size(170,15)
$labelEnter.Text = "Presse Enter pour crée le XML..."
$labelEnter.ForeColor= "yellow"
$Form.Controls.Add($labelEnter)

#CreateMainMenu
$Execut = new-object System.Windows.Forms.ToolStripMenuItem
$Exit = new-object System.Windows.Forms.ToolStripMenuItem
$Microsoft = new-object System.Windows.Forms.ToolStripMenuItem
$Copy = new-object System.Windows.Forms.ToolStripMenuItem
$Menu = New-Object System.Windows.Forms.MenuStrip

#Button Shortcut#
$ShortCut = New-Object System.Windows.Forms.ToolStripMenuItem
$ShortCut.Name = "ShortCut"
$ShortCut.Size = new-object System.Drawing.Size(30, 20)
$ShortCut.Text = "Shortcut"
$ShortCut.TextAlign = "MiddleLeft"
$ShortCut.DropDownItems.AddRange(@($Execut,$Microsoft,$Copy,$Exit))

#Execut
$Execut.Name = "Execut"
$Execut.Size = new-object System.Drawing.Size(152, 22)
$Execut.Text = "Execut"
$Execut.add_click($xmlCreate)
$Execut.ShortcutKeyDisplayString = "Enter"
$Execut.ForeColor = "gray"
$Execut.ShowShortcutKeys = $true
$Execut.Image = [system.drawing.image]::FromFile(".\Image\Start.jpg")
$Execut.TextAlign = "MiddleLeft"

#Microsoft
$Microsoft.Name = "Microsoft"
$Microsoft.Size = new-object System.Drawing.Size(152, 22)
$Microsoft.Text = "Microsoft"
$Microsoft.add_click({Start-Process https://support.microsoft.com/fr-fr/windows/trouver-votre-cl%C3%A9-de-produit-windows-aaa2bf69-7b2b-9f13-f581-a806abf0a886})
$Microsoft.ShortcutKeyDisplayString = "F2"
$Microsoft.ForeColor = "gray"
$Microsoft.ShowShortcutKeys = $true
$Microsoft.Image = [system.drawing.image]::FromFile(".\Image\Web.jpg")
$Microsoft.TextAlign = "MiddleLeft"

#Copy
$Copy.Name = "Copy"
$Copy.Size = new-object System.Drawing.Size(152, 22)
$Copy.Text = "Copie Licens"
$Copy.add_click({$LC=((Get-Location).Drive.Name)+(':\sources\$OEM$\$$\Panther\InstalCustome\SoftwareLicensingService.bat')
Start-Process $LC -WindowStyle Hidden
$Achiv = 0
$form.Controls.Add($loadingBar)
Do{$Achiv=$Achiv+1
$loadingBar.Value=$Achiv
$statusBar1.Text=$Achiv,"%"
Start-Sleep -Milliseconds 1} Until($Achiv -eq 100)
$Form.Controls.Remove($loadingBar)
$statusBar1.Text = "Ready..."})
$Copy.ShortcutKeyDisplayString = "F1"
$Copy.ForeColor = "gray"
$Copy.ShowShortcutKeys = $true
$Copy.Image = [system.drawing.image]::FromFile(".\Image\Copy.jpg")
$Copy.TextAlign = "MiddleLeft"

#Exit
$Exit.Name = "Exit"
$Exit.Size = new-object System.Drawing.Size(152, 22)
$Exit.Text = "Exit"
$Exit.add_click({$Form.Close()})
$Exit.ShortcutKeyDisplayString = "Escape"
$Exit.ForeColor = "gray"
$Exit.ShowShortcutKeys = $true
$Exit.Image = [system.drawing.image]::FromFile(".\Image\Exit.jpg")
$Exit.TextAlign = "MiddleLeft"

#Bar MainMenu#
$Menu.Items.AddRange(@($ShortCut))
$Menu.Location = new-object System.Drawing.Point(0,0)
$Menu.Size = New-Object System.Drawing.Size(354,24)
$Menu.TabIndex = 0
$Menu.Name = "MainMenu"
$Form.Controls.Add($Menu)

#TextBox1#
$textbox1 = New-Object System.Windows.Forms.TextBox
$textbox1.Location = New-Object System.Drawing.Size(10,55)
$textbox1.Size = New-Object System.Drawing.Size(120,20)
$textbox1.Text = "Cle Windows 10/11"
$Form.Controls.Add($textbox1)

#Label1#
$label1 = New-Object System.Windows.Forms.Label
$label1.BackColor = "Transparent"
$label1.Location = New-Object System.Drawing.Size(10,35)
$label1.Size = New-Object System.Drawing.Size(120,30)
$label1.Text = "Cle Windows 10/11 :"
$label1.ForeColor= "yellow"
$Form.Controls.Add($label1)

#TextBox2#
$textbox2 = New-Object System.Windows.Forms.TextBox
$textbox2.Location = New-Object System.Drawing.Size(155,55)
$textbox2.Size = New-Object System.Drawing.Size(120,20)
$textbox2.Text = "Nom du Profil"
$Form.Controls.Add($textbox2)

#Label2#
$label2 = New-Object System.Windows.Forms.Label
$label2.BackColor = "Transparent"
$label2.Location = New-Object System.Drawing.Size(155,35)
$label2.Size = New-Object System.Drawing.Size(100,30)
$label2.Text = "Nom du Profil :"
$label2.ForeColor= "yellow"
$Form.Controls.Add($label2)

#Button#
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Size(105,70)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.add_click($xmlCreate)

#Loading bar#
$loadingBar = New-Object System.Windows.Forms.ProgressBar
$loadingBar.ForeColor = "Cyan"
$loadingBar.MarqueeAnimationSpeed = 20
$loadingBar.Location = New-Object System.Drawing.Size(12,185)
$loadingBar.Size = New-Object System.Drawing.Size(260,20)
$loadingBar.Value = 0

#Label3#
$label3 = New-Object System.Windows.Forms.Label
$label3.BackColor = "Transparent"
$label3.Location = New-Object System.Drawing.Size(10,80)
$label3.Size = New-Object System.Drawing.Size(200,15)
$label3.Text = "Zone Geographique :"
$label3.ForeColor= "yellow"
$Form.Controls.Add($label3)

#ListBox#
$Liste = New-Object System.Windows.Forms.ListBox
$Liste.Name = "Zone"
$Liste.Location =New-Object System.Drawing.Size(12,95)
$Liste.Size = New-Object System.Drawing.Size(260,40)
$Liste.Items.Add("Vourles (4269)")
$Liste.Items.Add("Charnoz (01)")
$Liste.Items.Add("Vogue (0726)")
$Form.Controls.Add($Liste)

#Windows10/11#
$ListeW = New-Object System.Windows.Forms.ListBox
$ListeW.Name = "Windows10/11"
$ListeW.Location =New-Object System.Drawing.Size(100,135)
$ListeW.Size = New-Object System.Drawing.Size(90,40)
$ListeW.Items.Add("Windows 10")
$ListeW.Items.Add("Windows 11")
#$Form.Controls.Add($ListeW)

#Bar de Statu#
$statusBar1 = New-Object System.Windows.Forms.StatusBar
$statusBar1.Name = "statusBar1"
$statusBar1.BackColor = "Transparent"
$statusBar1.Text = "Ready..."
$form.Controls.Add($statusBar1)

#Vue de L'interface#
$Form.Topmost = $True
$Form.Add_Shown({$Form.Activate()})
[void] $Form.ShowDialog()