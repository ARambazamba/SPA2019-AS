$Farm = Get-SPFarm
$Farm.OneDriveUserExperienceVersion = [Microsoft.SharePoint.Administration.OneDriveUserExperienceVersion]::Version1
$Farm.Update()