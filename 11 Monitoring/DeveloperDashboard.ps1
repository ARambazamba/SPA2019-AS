if ((Get-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue) -eq $null) 
{
    Add-PSSnapin "Microsoft.SharePoint.PowerShell"
}

$service = [Microsoft.SharePoint.Administration.SPWebService]::ContentService
$addsetting =$service.DeveloperDashboardSettings
$addsetting.DisplayLevel = [Microsoft.SharePoint.Administration.SPDeveloperDashboardLevel]::On
$addsetting.Update()