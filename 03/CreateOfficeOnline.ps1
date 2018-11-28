
#Install Features Windows 2016 Server
# Run this on the new installed Office Online Server

Add-WindowsFeature Web-Server,Web-Mgmt-Tools,Web-Mgmt-Console,Web-WebServer,Web-Common-Http,Web-Default-Doc,Web-Static-Content,Web-Performance,Web-Stat-Compression,Web-Dyn-Compression,Web-Security,Web-Filtering,Web-Windows-Auth,Web-App-Dev,Web-Net-Ext45,Web-Asp-Net45,Web-ISAPI-Ext,Web-ISAPI-Filter,Web-Includes

Exit

#Reboot
#Do Setup using CD or iso
# Run this on the new installed Office Online Server

$WebAppsURL = "http://officeonline.spdom.local"
New-OfficeWebAppsFarm -InternalUrl $WebAppsURL -ExternalUrl $WebAppsURL -AllowHttp -EditingEnabled -Force

Exit

#Switch to SharePoint
if ((Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null)
{
    Add-PSSnapin Microsoft.SharePoint.PowerShell
}
$WebAppServer = "officeonline.spdom.local"
New-SPWOPIBinding -ServerName $WebAppServer –AllowHTTP 
Set-SPWopiZone -zone "internal-http"

Exit

#Remove All Bindings
Remove-SPWOPIBinding -All:$true

#Remove Cetain Binding
Get-SPWOPIBinding -Action "MobileView" | Remove-SPWOPIBinding
