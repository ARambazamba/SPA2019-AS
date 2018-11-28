if ((Get-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue) -eq $null) {
    Add-PSSnapin "Microsoft.SharePoint.PowerShell"
}

#Get TemplateIDs from: https://absolute-sharepoint.com/2013/06/sharepoint-2013-site-template-id-list-for-powershell.html

#Export
Export-SPWeb -Identity http://sp2016/ -Path "d:\entwiki-1033.cmp" -IncludeVersions ALL
Write-Host "Export done"

#Import
New-SPSite http://sp2016/sites/Import -OwnerAlias "spdom\Administrator" -Language 1033 -Template "ENTERWIKI#0"
Write-Host "Site created"
Import-SPWeb -Identity http://sp2016/sites/Import -Path "d:\entwiki-1033.cmp"
Write-Host "Import done"