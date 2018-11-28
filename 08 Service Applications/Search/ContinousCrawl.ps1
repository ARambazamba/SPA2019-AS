if ((Get-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue) -eq $null) 
{
    Add-PSSnapin "Microsoft.SharePoint.PowerShell"
}

$ssa = Get-SPEnterpriseSearchServiceApplication
Write-Host "Continous Crawl: " $ssa.GetProperty("ContinuousCrawlInterval") 
$ssa.SetProperty(“ContinuousCrawlInterval”,20)
