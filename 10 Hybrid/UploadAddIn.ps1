Import-Module Microsoft.Online.SharePoint.PowerShell -DisableNameChecking

$adminUPN = "alexander.pajer@integrations.at"
$orgName = "integrationsonline"
$tenantAdminUrl = "https://" + $orgName + "-admin.sharepoint.com"

Connect-PnPOnline -Url $tenantAdminUrl
Add-PnPApp -Path ./SPHostedAddIn.app
