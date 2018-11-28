Import-Module Microsoft.Online.SharePoint.PowerShell -DisableNameChecking

$adminUPN = "alexander.pajer@integrations.at"
$orgName = "integrationsonline"
$timeZone = 4 # --Received using: Get-PnPTimeZoneId
$tenantAdminUrl = "https://" + $orgName + "-admin.sharepoint.com"
$templateURL = "https://integrationsonline.sharepoint.com/sites/csdf-etcx"

Connect-PnPOnline -Url $tenantAdminUrl

New-PnPTenantSite -Title "PnP Template Site Collection" -Url $templateURL -Owner $adminUPN -Lcid 1033 -Template "STS#0" -TimeZone $timeZone -StorageQuota 20 
Disconnect-PnPOnline