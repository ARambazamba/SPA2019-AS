$url = "http://sp2016/";
$hostheader = "http://portal.spdom.local";
$siteExists = (Get-SPWeb $hostheader -ErrorAction SilentlyContinue) -ne $null

if($siteExists){
    Remove-SPSite -Identity $hostheader -GradualDelete -Confirm:$False
    Write-Host "Site deleted"
}

$hostHeaderInUse = (Get-SPSiteURL -Identity $hostheader) -ne $null

if($hostHeaderInUse){
    Remove-SPSiteURL -URL $hostheader
    Write-Host "Hostheader removed"
}

New-SPSite $hostheader -OwnerAlias spdom\administrator -HostHeaderWebApplication $url -Template "ENTERWIKI#0"
Write-Host "Hostheader site created"