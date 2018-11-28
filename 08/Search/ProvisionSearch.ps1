Add-PsSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
 
#Settings
$IndexLocation = "D:\SearchIndex"  #Location must be empty, will be deleted during the process!
$SearchAppPoolName = "Search App Pool"
$SearchAppPoolAccountName = "spdom\spservice"
$SearchServiceName = "Smart Search Service"
$SearchServiceProxyName = "Search SA Proxy"
 
$DatabaseServer = "sp2016"
$DatabaseName = "SmartSearchDB"
 
Write-Host -ForegroundColor Yellow "Checking if Search Application Pool exists"
$spAppPool = Get-SPServiceApplicationPool -Identity $SearchAppPoolName -ErrorAction SilentlyContinue
 
if (!$spAppPool) {
    Write-Host -ForegroundColor Green "Creating Search Application Pool"
    $spAppPool = New-SPServiceApplicationPool -Name $SearchAppPoolName -Account $SearchAppPoolAccountName -Verbose
}
 
Write-Host -ForegroundColor Yellow "Checking if Search Service Application exists"
$ServiceApplication = Get-SPEnterpriseSearchServiceApplication -Identity $SearchServiceName -ErrorAction SilentlyContinue
if (!$ServiceApplication) {
    Write-Host -ForegroundColor Green "Creating Search Service Application"
    $ServiceApplication = New-SPEnterpriseSearchServiceApplication -Name $SearchServiceName -ApplicationPool $spAppPool.Name -DatabaseServer  $DatabaseServer -DatabaseName $DatabaseName
}
 
Write-Host -ForegroundColor Yellow "Checking if Search Service Application Proxy exists"
$Proxy = Get-SPEnterpriseSearchServiceApplicationProxy -Identity $SearchServiceProxyName -ErrorAction SilentlyContinue
if (!$Proxy) {
    Write-Host -ForegroundColor Green "Creating Search Service Application Proxy"
    New-SPEnterpriseSearchServiceApplicationProxy -Name $SearchServiceProxyName -SearchApplication $SearchServiceName
}
 
$searchInstance = Get-SPEnterpriseSearchServiceInstance -local 
$InitialSearchTopology = $ServiceApplication | Get-SPEnterpriseSearchTopology -Active 
$SearchTopology = $ServiceApplication | New-SPEnterpriseSearchTopology
 
New-SPEnterpriseSearchAnalyticsProcessingComponent -SearchTopology $SearchTopology -SearchServiceInstance $searchInstance
New-SPEnterpriseSearchContentProcessingComponent -SearchTopology $SearchTopology -SearchServiceInstance $searchInstance
New-SPEnterpriseSearchQueryProcessingComponent -SearchTopology $SearchTopology -SearchServiceInstance $searchInstance
New-SPEnterpriseSearchCrawlComponent -SearchTopology $SearchTopology -SearchServiceInstance $searchInstance 
New-SPEnterpriseSearchAdminComponent -SearchTopology $SearchTopology -SearchServiceInstance $searchInstance
 
set-SPEnterpriseSearchAdministrationComponent -SearchApplication $ServiceApplication -SearchServiceInstance  $searchInstance
 
Remove-Item -Recurse -Force -LiteralPath $IndexLocation -ErrorAction SilentlyContinue
mkdir -Path $IndexLocation -Force 
 
New-SPEnterpriseSearchIndexComponent -SearchTopology $SearchTopology -SearchServiceInstance $searchInstance -RootDirectory $IndexLocation 
 
Write-Host -ForegroundColor Green "Activating new topology"
$SearchTopology.Activate()

exit
 
# Write-Host -ForegroundColor Yellow "Next call will provoke an error but after that the old topology can be deleted - just ignore it!"
# $InitialSearchTopology.Synchronize()

exit
 
Write-Host -ForegroundColor Yellow "Deleting old topology"
Remove-SPEnterpriseSearchTopology -Identity $InitialSearchTopology -Confirm:$false
Write-Host -ForegroundColor Green "Old topology deleted"
Write-Host -ForegroundColor Green "Done - start a full crawl and you are good to go (search)."