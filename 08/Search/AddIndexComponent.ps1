if ((Get-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue) -eq $null) 
{
    Add-PSSnapin "Microsoft.SharePoint.PowerShell"
}

#Get Search Service Instance and Start on New Index Server
$ssi = Get-SPEnterpriseSearchServiceInstance -Identity "SP2016Node2"
Start-SPEnterpriseSearchServiceInstance -Identity $ssi

#Wait for Search Service Instance to come online
do {$online = Get-SPEnterpriseSearchServiceInstance -Identity $ssi; Write-Host "Waiting for service: " $online.Status} 
until ($online.Status -eq "Online")

#Clone Active Search Topology
$ssa = Get-SPEnterpriseSearchServiceApplication
$active = Get-SPEnterpriseSearchTopology -SearchApplication $ssa -Active
$clone = New-SPEnterpriseSearchTopology -SearchApplication $ssa -Clone –SearchTopology $active

#Create New Index Component for Index Partition 0
New-SPEnterpriseSearchIndexComponent –SearchTopology $clone -SearchServiceInstance $ssi -IndexPartition 0 -RootDirectory "c:\NewIndex"

#Activate the Cloned Search Topology
Set-SPEnterpriseSearchTopology -Identity $clone

#Review new topology
Get-SPEnterpriseSearchTopology -Active -SearchApplication $ssa

#Monitor Distribution of Index
do {$activeState = Get-SPEnterpriseSearchStatus -SearchApplication $ssa | Where-Object {$_.Name -eq "IndexComponent2"}; Write-Host "Waiting for active distribution: " $activeState.State}
until ($activeState.State -eq "Active")

