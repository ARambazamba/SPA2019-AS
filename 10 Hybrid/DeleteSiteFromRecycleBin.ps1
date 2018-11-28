# Remove deleted Site from Recycle bin
Import-Module Microsoft.Online.SharePoint.PowerShell -DisableNameChecking

$adminUPN = "alexander.pajer@integrations.at"
$userCredential = Get-Credential -UserName $adminUPN -Message "PWD of O365:"

# Using SPO Powershell

Connect-SPOService -Url "https://integrationsonline-admin.sharepoint.com" -Credential $userCredential

$siteToDelete = "https://integrationsonline.sharepoint.com/sites/WeledaTarget"

Remove-SPOSite -Identity $siteToDelete -Confirm:$false

Remove-SPODeletedSite -Identity $siteToDelete -Confirm:$false
