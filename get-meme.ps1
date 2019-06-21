<#
	.SYNOPSIS
		Powershell Based Meme Generator
	
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

Function Get-Meme
{
	
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
		[string]$Text_One,
		[parameter(ParameterSetName = 'ID')]
		[parameter(ParameterSetName = 'Name')]
		[string]$Text_Two,
		[parameter(ParameterSetName = 'ID')]
		[parameter(ParameterSetName = 'Name')]
		[switch]$Clip,
		[parameter(ParameterSetName = 'ID')]
		[parameter(ParameterSetName = 'Name')]
		[switch]$View,
		[parameter(ParameterSetName = 'ID')]
		[parameter(ParameterSetName = 'Name')]
		[System.IO.FileInfo]$Path
	)
	
	$Imgflip_UN = $null
	$Imgflip_PW = $null
	
	if (!$Imgflip_UN) { $Imgflip_UN = Read-Host "Please enter your Imgflip Username" }
	if (!$Imgflip_PW) { $Imgflip_PW = Read-Host "Please enter your Imgflip Password" }
	
	
	$MemeList = Invoke-RestMethod -Uri "https://api.imgflip.com/get_memes"
	
	if ($list)
	{
		return $MemeList.data.memes | select id, name, url | sort name
	}
	
	if ($Meme_Name)
	{
		$MemeTemplate = $MemeList.data.memes | Where-Object Name -Like "*$Meme_Name*"
		if ($MemeTemplate.Count -gt 1)
		{
			$MemeTemplate = $MemeTemplate | select id, name, url | Out-GridView -OutputMode Single
		}
		if (!$MemeTemplate) { return "Unable to find meme like $Meme_Name" }
	}
	
	if ($Meme_Id)
	{
		$MemeTemplate = $MemeList.data.memes | Where-Object Id -Like "$Meme_Id"
		if (!$MemeTemplate) { return "Unable to find Meme template with ID of $Meme_Id" }
	}
	
	if (!$Meme_Name -and !$Meme_Id)
	{
		$MemeTemplate = $MemeList.data.memes | select id, name, url | sort name | Out-GridView -OutputMode Single
		if (!$MemeTemplate) { return "No Meme Template Selected. Please Try Again" }
	}
	
	$memeparams = @{
		template_id = $MemeTemplate.id
		username    = $Imgflip_UN
		password    = $Imgflip_PW
		text0	    = $Text_One
		text1	    = $Text_Two
	}
	
	$response = Invoke-RestMethod 'https://api.imgflip.com/caption_image' -Method Post -Body $memeparams
	if ($response.success -like "False") { return $response.error_message }
	
	$response.data.url
	
	if ($clip)
	{
		$response.data.url | clip
		Write-Output "Copied $($response.data.url) to the clipboard"
	}
	
	if ($Path)
	{
		$filename = $MemeTemplate.Name + '_' + $Text_One + '_' + $Text_Two + '.jpg'
		$wc = New-Object System.Net.WebClient
		$wc.DownloadFile($($response.data.url), "$path\$filename")
	}
	
	if ($view)
	{
		Start-Process $response.data.url
	}
	
}

