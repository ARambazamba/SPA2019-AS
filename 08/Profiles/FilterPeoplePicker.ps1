#Read Values
$site = Get-SPSite http://sp2016
Write-Host "Current Filter for People Picker" $site.UserAccountDirectoryPath 

#Write Filter
$site.UserAccountDirectoryPath = “OU=SharePoint,DC=spdom,DC=local”

#Reset
$site.UserAccountDirectoryPath = “”; 