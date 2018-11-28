if ((Get-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue) -eq $null) 
{
    Add-PSSnapin "Microsoft.SharePoint.PowerShell"
}

$url = "http://sp2016"
$webapp = Get-SPWebApplication $url
$webapp.WebService.EnableSideBySide = $true;
$webapp.WebService.update();