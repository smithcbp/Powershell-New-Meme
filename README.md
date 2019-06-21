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
