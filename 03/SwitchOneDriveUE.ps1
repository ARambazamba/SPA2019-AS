$Farm = Get-SPFarm
$Farm.OneDriveUserExperienceVersion = [Microsoft.SharePoint.Administration.OneDriveUserExperienceVersion]::Version2
$Farm.Update()