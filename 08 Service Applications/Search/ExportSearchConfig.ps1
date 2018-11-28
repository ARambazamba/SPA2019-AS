if ((Get-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue) -eq $null) 
{
    Add-PSSnapin "Microsoft.SharePoint.PowerShell"
}

#Export 
$site = Get-SPSite http://sp2016
$searchConfig = New-Object Microsoft.Office.Server.Search.Portability.SearchConfigurationPortability($site)
$owner = New-Object Microsoft.Office.Server.Search.Administration.SearchObjectOwner([Microsoft.Office.Server.Search.Administration.SearchObjectLevel]::SPWeb, $site.OpenWeb())
$searchConfig.ExportSearchConfiguration($owner) | Out-File -FilePath d:\searchconfig.xml

#Import
 
$site = Get-SPSite http://sp2016
$searchConfig = New-Object Microsoft.Office.Server.Search.Portability.SearchConfigurationPortability($site)
$owner = New-Object Microsoft.Office.Server.Search.Administration.SearchObjectOwner([Microsoft.Office.Server.Search.Administration.SearchObjectLevel]::SPWeb, $site.OpenWeb())
$configuration = Get-Content d:\searchconfig.xml
$searchConfig.ImportSearchConfiguration($owner, $configuration) 
