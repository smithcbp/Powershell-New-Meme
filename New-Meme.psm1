<#
.SYNOPSIS
	Meme Generator Function

.DESCRIPTION
	Get-Meme uses the imgflip memegenerator api (https://api.imgflip.com/) to create the beautiful work of art known as a Meme.
	You will need to create an account at https://imgflip.com/signup. Use those credentials for the $Imgflip_UN and $Imgflip_PW variables.

.EXAMPLE
	Get-Meme -List
	Get-Meme -Meme_Id "61544" -Text_One "Using Powershell" -Text_Two "I made my first meme!" -view
	Get-Meme -Meme_Name "Bear" -Text_Two "I don't even like memes" -Path C:\Temp -Clip -View

.NOTES
	Happy Memeing!
#>

#Build New-Meme Function
Function New-Meme {
	
    param
    (
        [parameter(ParameterSetName = 'List')]
        [switch]$List,
        [parameter(ParameterSetName = 'ID')]
        [Int]$Meme_Id,
        [parameter(ParameterSetName = 'Name')]
        [string]$Meme_Name,
        [parameter(ParameterSetName = 'ID')]
        [parameter(ParameterSetName = 'Name')]
        [parameter(Mandatory = $False)]
        [System.Management.Automation.PSCredential]$ImgFlip_Cred,
        [parameter(ParameterSetName = 'ID')]
        [parameter(ParameterSetName = 'Name')]
        [string]$Text_One,
        [parameter(ParameterSetName = 'ID')]
        [parameter(ParameterSetName = 'Name')]
        [string]$Text_Two,
        [parameter(ParameterSetName = 'ID')]
        [parameter(ParameterSetName = 'Name')]
        [string]$Text_Three,
        [parameter(ParameterSetName = 'ID')]
        [parameter(ParameterSetName = 'Name')]
        [string]$Text_Four,
        [parameter(ParameterSetName = 'ID')]
        [parameter(ParameterSetName = 'Name')]
        [string]$Text_Five,
        [switch]$Clip,
        [parameter(ParameterSetName = 'ID')]
        [parameter(ParameterSetName = 'Name')]
        [switch]$View,
        [parameter(ParameterSetName = 'ID')]
        [parameter(ParameterSetName = 'Name')]
        [System.IO.FileInfo]$Path

    )	
	#gathers all available meme templates
    $MemeList = Invoke-RestMethod -Uri "https://api.imgflip.com/get_memes"
	
	#Lists all templates if -list parameter is included
    if ($list) {
        return $MemeList.data.memes | Select-Object id, name, url | Sort-Object name
    }
	
	#searches for meme with name similar to input. If multiple found choose with out-gridview
    if ($Meme_Name) {
        $MemeTemplate = $MemeList.data.memes | Where-Object Name -Like "*$Meme_Name*"
        if ($MemeTemplate.Count -gt 1) {
            $MemeTemplate = $MemeTemplate | Select-Object id, name, url | Out-GridView -OutputMode Single
        }
        if (!$MemeTemplate) { return "Unable to find meme like $Meme_Name" }
    }
	
	#searches for meme via ID
    if ($Meme_Id) {
        $MemeTemplate = $MemeList.data.memes | Where-Object Id -Like "$Meme_Id"
        if (!$MemeTemplate) { return "Unable to find Meme template with ID of $Meme_Id" }
    }
	
	#Throws error if no template selected.
    if (!$Meme_Name -and !$Meme_Id) {
        $MemeTemplate = $MemeList.data.memes | Select-Object id, name, url | Sort-Object name | Out-GridView -OutputMode Single
        if (!$MemeTemplate) { return "No Meme Template Selected. Please Try Again" }
    }
    #Build Meme Parameters to send to ImgFlip
    $memeparams = @{
        template_id      = $MemeTemplate.id
        username         = $ImgFlip_Cred.UserName
        password         = $ImgFlip_Cred.GetNetworkCredential().Password 
        "boxes[1][text]" = $Text_One
        "boxes[2][text]" = $Text_Two
        "boxes[3][text]" = $Text_Five
        "boxes[4][text]" = $Text_Four
        "boxes[5][text]" = $Text_Three
        }

	#Send request to imgflip.
	$response = Invoke-RestMethod 'https://api.imgflip.com/caption_image' -Method Post -Body $memeparams
	#Build PSObject with response
    $finishedMeme = new-object psobject
    if ($response.success -like "False") { $finishedMeme | Add-Member -MemberType NoteProperty -Name 'response' -Value $response.error_message }
    $finishedMeme | Add-Member -MemberType NoteProperty -Name 'Url' -Value $response.data.url    
    $finishedMeme
	
	#Copies response URL to clipboard if -switch parameter is used
    if ($clip) {
        $response.data.url | clip
        Write-Output "Copied $($response.data.url) to the clipboard"
    }
	
	#downloads the image to path defined in -path parameter.
    if ($Path) {
        $filename = $MemeTemplate.Name + '_' + $Text_One + $Text_Two + + $Text_Three + $Text_Four + $Text_Five + '.jpg'
        $FullPath = "$path\$filename"
        $finishedMeme | Add-Member -MemberType NoteProperty -Name 'FullPath' -Value $FullPath
        $wc = New-Object System.Net.WebClient
        $wc.DownloadFile($($finishedMeme.Url), $FullPath)
        $finishedMeme
        #Write-Output "Saved meme to $FullPath"
    }
	
	#launches image url
    if ($view) {
        Write-Output "Launching $($response.data.url)"
        Start-Process $response.data.url
    }
	
}