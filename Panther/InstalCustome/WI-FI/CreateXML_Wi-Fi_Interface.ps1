[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

$Form = New-Object System.Windows.Forms.Form
$Form.Text = "XML Extract WiFi"
$Form.Icon = '.\Icon-WiFi.ico'
$Form.Size = New-Object System.Drawing.Size(300,170)
$Form.StartPosition = "CenterScreen"

$Form.KeyPreview = $True
$Form.Add_KeyDown({if ($_.KeyCode -eq "Enter")
{$x=$ListBox.SelectedItem;$Form.Close()}})
$Form.Add_KeyDown({if ($_.KeyCode -eq "Escape")
{$Form.Close()}})

$Eping_computer_click ={
$Achiv=0
$statusBar1.Text="Start Exporting"
Write-Host("ClickV") -ForegroundColor Green
$WI_FI_NAME=(Get-NetConnectionProfile| select-Object -Property Name).Name
netsh wlan export profile name=$WI_FI_NAME key=clear folder=.\
Do{$Achiv=$Achiv+1
$statusBar1.Text=$Achiv,"%"
Start-Sleep -Milliseconds 1} Until($Achiv -eq 100)
$statusBar1.Text=$WI_FI_NAME, "Sucess full Export"}

$Rping_computer_click ={
$Achiv=0
Write-Host("ClickV") -ForegroundColor Green
$statusBar1.Text="Start Refreching"
$WI_FI_NAME=(Get-NetConnectionProfile| select-Object -Property Name).Name
Do{$Achiv=$Achiv+1
$statusBar1.Text=$Achiv,"%"
Start-Sleep -Milliseconds 1} Until($Achiv -eq 100)
$label.Text = "Appuer sur Exporter pour extraire le XML de la Wi-Fi :",$WI_FI_NAME
$statusBar1.Text="Sucess full Refrech"}

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Size(5,5)
$label.Size = New-Object System.Drawing.Size(240,30)
$label.Text = "Appuer sur Exporter pour extraire le XML de la Wi-Fi :",$WI_FI_NAME
$Form.Controls.Add($label)

$RefrechButton = New-Object System.Windows.Forms.Button
$RefrechButton.Location = New-Object System.Drawing.Size(105,40)
$RefrechButton.Size = New-Object System.Drawing.Size(75,23)
$RefrechButton.Text = "Refrech WiFi"
$RefrechButton.Add_Click($Rping_computer_click)
$Form.Controls.Add($RefrechButton)

$ExporButton = New-Object System.Windows.Forms.Button
$ExporButton.Location = New-Object System.Drawing.Size(105,70)
$ExporButton.Size = New-Object System.Drawing.Size(75,23)
$ExporButton.Text = "ExporXML"
$ExporButton.Add_Click($Eping_computer_click)
$Form.Controls.Add($ExporButton)

$statusBar1 = New-Object System.Windows.Forms.StatusBar
$statusBar1.Name = "statusBar1"
$statusBar1.Text = ("Ready...")
$form.Controls.Add($statusBar1)


$Form.Add_KeyDown({if ($_.KeyCode -eq "Enter"){& $ping_computer_click}})
$Form.Add_KeyDown({if ($_.KeyCode -eq "Escape")
{$Form.Close()}})

$Form.Topmost = $True
$Form.Add_Shown({$Form.Activate()})
[void] $Form.ShowDialog()
