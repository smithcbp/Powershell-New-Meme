<#
	.SYNOPSIS
		Powershell Based Meme Generator GUI
	
	.DESCRIPTION
		This tool uses the imgflip memegenerator api (https://api.imgflip.com/) to create the beautiful work of art known as a Meme.
		You will need to create an account at https://imgflip.com/signup.
	    This form was created using POSHGUI.com  a free online gui designer for PowerShell
	
	.NOTES
		Happy Memeing! Made by Chris Smith
        https://github.com/smithcbp/Powershell-New-Meme
#>

# Hardcode Imgflip Credentials
$Imgflip_UN = ''
$Imgflip_PW = ''

#Set Initial Image URL
$InitialImage = 'https://i.imgflip.com/347x36.jpg'

#Add required assemblies
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

#Import New-Meme Module
$ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path
Import-Module "$ScriptDir\new-meme.psm1"

#Build GUI
$Form = New-Object system.Windows.Forms.Form
$Form.ClientSize = '440,860'
$Form.text = "New-Meme"
$Form.TopMost = $false
$form.FormBorderStyle = 'Fixed3D'
$Form.MaximizeBox = $false

$PictureBox1 = New-Object system.Windows.Forms.PictureBox
$PictureBox1.width = 411
$PictureBox1.height = 441
$PictureBox1.location = New-Object System.Drawing.Point(15, 400)
$PictureBox1.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::zoom
$PictureBox1.ImageLocation = $InitialImage

$TitleLabel = New-Object system.Windows.Forms.Label
$TitleLabel.text = "Meme Maker"
$TitleLabel.AutoSize = $true
$TitleLabel.width = 25
$TitleLabel.height = 10
$TitleLabel.location = New-Object System.Drawing.Point(15, 10)
$TitleLabel.Font = 'Consolas,24,style=Bold,Underline'

$SubTitleLabel = New-Object system.Windows.Forms.Label
$SubTitleLabel.text = "Created by Chris Smith`nhttps://github.com/smithcbp`nSpecial Thanks to PoshGUI.com"
$SubTitleLabel.AutoSize = $true
$SubTitleLabel.width = 25
$SubTitleLabel.height = 10
$SubTitleLabel.location = New-Object System.Drawing.Point(230, 10)
$SubTitleLabel.Font = 'Consolas,8'

$ImgFlipUNTextBox = New-Object system.Windows.Forms.TextBox
$ImgFlipUNTextBox.multiline = $false
$ImgFlipUNTextBox.width = 225
$ImgFlipUNTextBox.height = 30
$ImgFlipUNTextBox.location = New-Object System.Drawing.Point(200, 55)
$ImgFlipUNTextBox.Font = 'Microsoft Sans Serif,10'
$ImgFlipUNTextBox.Text = $Imgflip_UN

$ImgFlipPWTextbox = New-Object system.Windows.Forms.TextBox
$ImgFlipPWTextbox.multiline = $false
$ImgFlipPWTextbox.width = 225
$ImgFlipPWTextbox.height = 30
$ImgFlipPWTextbox.location = New-Object System.Drawing.Point(200, 90)
$ImgFlipPWTextbox.Font = 'Microsoft Sans Serif,10'
$ImgFlipPWTextbox.PasswordChar = '*'
$ImgFlipPWTextbox.Text = $Imgflip_PW

$MemeTemplateListbox = New-Object System.Windows.Forms.ComboBox
$MemeTemplateListbox.text = ""
$MemeTemplateListbox.width = 225
$MemeTemplateListbox.height = 30
$MemeTemplateListbox.location = New-Object System.Drawing.Point(200, 125)
$MemeTemplateListbox.DropDownStyle = 'DropDownList'
$MemeTemplateListbox.Font = 'Microsoft Sans Serif,10'

$TextBox1 = New-Object system.Windows.Forms.TextBox
$TextBox1.multiline = $false
$TextBox1.width = 225
$TextBox1.height = 30
$TextBox1.location = New-Object System.Drawing.Point(200, 160)
$TextBox1.Font = 'Microsoft Sans Serif,10'

$TextBox2 = New-Object system.Windows.Forms.TextBox
$TextBox2.multiline = $false
$TextBox2.width = 225
$TextBox2.height = 30
$TextBox2.location = New-Object System.Drawing.Point(200, 195)
$TextBox2.Font = 'Microsoft Sans Serif,10'

$TextBox3 = New-Object system.Windows.Forms.TextBox
$TextBox3.multiline = $false
$TextBox3.width = 225
$TextBox3.height = 30
$TextBox3.location = New-Object System.Drawing.Point(200, 230)
$TextBox3.Font = 'Microsoft Sans Serif,10'

$TextBox4 = New-Object system.Windows.Forms.TextBox
$TextBox4.multiline = $false
$TextBox4.width = 225
$TextBox4.height = 30
$TextBox4.location = New-Object System.Drawing.Point(200, 265)
$TextBox4.Font = 'Microsoft Sans Serif,10'

$TextBox5 = New-Object system.Windows.Forms.TextBox
$TextBox5.multiline = $false
$TextBox5.width = 225
$TextBox5.height = 30
$TextBox5.location = New-Object System.Drawing.Point(200, 300)
$TextBox5.Font = 'Microsoft Sans Serif,10'

$OutputTextBox = New-Object system.Windows.Forms.TextBox
$OutputTextBox.multiline = $false
$OutputTextBox.width = 408
$OutputTextBox.height = 30
$OutputTextBox.location = New-Object System.Drawing.Point(15, 370)
$OutputTextBox.Font = 'Microsoft Sans Serif,10'
$OutputTextBox.ReadOnly = $true
$OutputTextBox.Text = 'https://i.imgflip.com/340lj5.jpg'

$ImgFlipUNLabel = New-Object system.Windows.Forms.Label
$ImgFlipUNLabel.text = "ImgFlip Username"
$ImgFlipUNLabel.AutoSize = $true
$ImgFlipUNLabel.width = 25
$ImgFlipUNLabel.height = 10
$ImgFlipUNLabel.location = New-Object System.Drawing.Point(15, 55)
$ImgFlipUNLabel.Font = 'Microsoft Sans Serif,14'

$ImgFlipPWLabel = New-Object system.Windows.Forms.Label
$ImgFlipPWLabel.text = "ImgFlip Password"
$ImgFlipPWLabel.AutoSize = $true
$ImgFlipPWLabel.width = 25
$ImgFlipPWLabel.height = 10
$ImgFlipPWLabel.location = New-Object System.Drawing.Point(15, 88)
$ImgFlipPWLabel.Font = 'Microsoft Sans Serif,14'

$MemeTemplateLabel = New-Object system.Windows.Forms.Label
$MemeTemplateLabel.text = "Meme Template"
$MemeTemplateLabel.AutoSize = $true
$MemeTemplateLabel.width = 25
$MemeTemplateLabel.height = 10
$MemeTemplateLabel.location = New-Object System.Drawing.Point(15, 126)
$MemeTemplateLabel.Font = 'Microsoft Sans Serif,14'

$TextOneLabel = New-Object system.Windows.Forms.Label
$TextOneLabel.text = "Text One"
$TextOneLabel.AutoSize = $true
$TextOneLabel.width = 25
$TextOneLabel.height = 10
$TextOneLabel.location = New-Object System.Drawing.Point(15, 160)
$TextOneLabel.Font = 'Microsoft Sans Serif,14'

$TextTwoLabel = New-Object system.Windows.Forms.Label
$TextTwoLabel.text = "Text Two"
$TextTwoLabel.AutoSize = $true
$TextTwoLabel.width = 25
$TextTwoLabel.height = 10
$TextTwoLabel.location = New-Object System.Drawing.Point(15, 195)
$TextTwoLabel.Font = 'Microsoft Sans Serif,14'

$TextThreeLabel = New-Object system.Windows.Forms.Label
$TextThreeLabel.text = "Text Three"
$TextThreeLabel.AutoSize = $true
$TextThreeLabel.width = 25
$TextThreeLabel.height = 10
$TextThreeLabel.location = New-Object System.Drawing.Point(15, 230)
$TextThreeLabel.Font = 'Microsoft Sans Serif,14'

$TextFourLabel = New-Object system.Windows.Forms.Label
$TextFourLabel.text = "Text Four"
$TextFourLabel.AutoSize = $true
$TextFourLabel.width = 25
$TextFourLabel.height = 10
$TextFourLabel.location = New-Object System.Drawing.Point(15, 265)
$TextFourLabel.Font = 'Microsoft Sans Serif,14'

$TextFiveLabel = New-Object system.Windows.Forms.Label
$TextFiveLabel.text = "Text Five"
$TextFiveLabel.AutoSize = $true
$TextFiveLabel.width = 25
$TextFiveLabel.height = 10
$TextFiveLabel.location = New-Object System.Drawing.Point(15, 300)
$TextFiveLabel.Font = 'Microsoft Sans Serif,14'

$PreviewButton = New-Object system.Windows.Forms.Button
$PreviewButton.text = "Preview"
$PreviewButton.width = 130
$PreviewButton.height = 30
$PreviewButton.location = New-Object System.Drawing.Point(15, 330)
$PreviewButton.Font = 'Microsoft Sans Serif,12'

$CopyButton = New-Object system.Windows.Forms.Button
$CopyButton.text = "Copy URL"
$CopyButton.width = 130
$CopyButton.height = 30
$CopyButton.location = New-Object System.Drawing.Point(155, 330)
$CopyButton.Font = 'Microsoft Sans Serif,12'

$SaveButton = New-Object system.Windows.Forms.Button
$SaveButton.text = "Save"
$SaveButton.width = 130
$SaveButton.height = 30
$SaveButton.location = New-Object System.Drawing.Point(295, 330)
$SaveButton.Font = 'Microsoft Sans Serif,12'

$Form.controls.AddRange(@($PictureBox1, $TitleLabel,$SubTitleLabel, $ImgFlipUNTextBox, $ImgFlipPWTextbox, $MemeTemplateListbox, $TextBox1, $TextBox2, $TextBox3, $TextBox4, $TextBox5, $OutputTextBox, $ImgFlipUNLabel, $ImgFlipPWLabel, $MemeTemplateLabel, $TextOneLabel, $TextTwoLabel, $TextThreeLabel, $TextFourLabel, $TextFiveLabel, $PreviewButton, $CopyButton, $SaveButton))

#Add Button Clicks
$PreviewButton.Add_Click( {
		#If No Textbox, Display meme preview. No creds needed.
        if ((!$($TextBox1.Text)) -and (!$($TextBox2.Text)) -and (!$($TextBox3.Text)) -and (!$($TextBox4.Text)) -and (!$($TextBox5.Text))) {
            $Meme = New-Meme -list | Where-Object Name -like $MemeTemplateListbox.Text
            $OutputTextBox.Text = $Meme.Url | Out-String
            $PictureBox1.ImageLocation = $Meme.Url
            return
		}
		#Error if No creds when including text boxes
        if (((!$($ImgFlipUNTextBox.Text)) -or (!$($ImgFlipPWTextBox.Text))) -and (($($TextBox1.Text)) -or ($($TextBox2.Text)))) {
            $OutputTextBox.Text = "Please Enter your Username and Password for ImgFlip.com"
            return
		}
		#Build Meme
        Else {
            $ImgFlipUn = $ImgFlipUNTextBox.Text
            $ImgFlipPw = "$($ImgFlipPWTextbox.Text)" | ConvertTo-SecureString -asPlainText -Force
            $ImgFlipCred = New-Object System.Management.Automation.PSCredential($ImgFlipUn, $ImgFlipPw)
            $Meme = New-Meme -Meme_Name $MemeTemplateListbox.Text -ImgFlip_Cred $ImgFlipCred -Text_One $TextBox1.Text -Text_Two $TextBox2.Text -Text_Three $TextBox3.Text -Text_Four $TextBox4.Text -Text_Five $TextBox5.Text
            if ($($Meme.response)) { $OutputTextBox.Text = $Meme.Response ; return }
            $OutputTextBox.Text = $Meme.Url
            $PictureBox1.ImageLocation = $Meme.Url
        }
    })

#Copies whatever is in the output box to the clipboard
$CopyButton.Add_Click( {
        $OutputTextBox.Text | clip
    })

#Initiates file dialog box to save image.
$SaveButton.Add_Click( {
        $defaultfilename = "$($MemeTemplateListbox.Text)" + '_' + "$($TextBox1.Text)" + "$($TextBox2.Text)"
        $SaveChooser = New-Object -TypeName System.Windows.Forms.SaveFileDialog
        $SaveChooser.Filter = "jpg files (*.jpg)|*.jpg|All files (*.*)|*.*" 
        $SaveChooser.initialDirectory = "$env:USERPROFILE\Pictures"
        $SaveChooser.FileName = "$defaultfilename"
        $result = $SaveChooser.ShowDialog()
        if ($result -like 'Cancel') { return }
        $path = $SaveChooser.FileName
        $url = $PictureBox1.ImageLocation
        $wc = New-Object System.Net.WebClient
        $wc.DownloadFile($url, $path)
        $OutputTextBox.Text = "$($PictureBox1.ImageLocation) saved to $($SaveChooser.FileName)"
    })

#Gathers Meme Templates to display in combobox
$MemeTemplates = New-Meme -List
Foreach ($Template in $MemeTemplates) {
    $MemeTemplateListbox.Items.Add($Template.Name) | Out-Null
}

#Show Form
[void]$Form.ShowDialog()

