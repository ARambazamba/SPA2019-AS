# Loads Powershell Packages
Install-Module –Name PowerShellGet –Force

# Installs PnP Moduel for SP 2016
Install-Module SharePointPnPPowerShell2016 -Force

exit

Remove-Module -name SharePointPnPPowerShell2016

# Installs PnP Moduel for SP Online
Install-Module SharePointPnPPowerShellOnline -Force -SkipPublisherCheck -AllowClobber

exit

Remove-Module SharePointPnPPowerShellOnline

# Update
Update-Module SharePointPnPPowerShell*

# List installed PowerShell Providers
Get-Module SharePointPnPPowerShell* -ListAvailable | Select-Object Name, Version | Sort-Object Version -Descending

# Import Module
Import-Module SharePointPnPPowerShellOnline

# Sample Connect
$orgName = "integrationsonline";
$cred = Get-Credential;

Connect-PnPOnline –Url https://$orgName.sharepoint.com –Credentials $cred

# Create a Web using PnP
New-PnPWeb -Title "PnP Web" -Url pnpWeb -Description "SPWeb created using PnP" -Locale 1033 -Template "STS#0"

Write-Host "Site created"