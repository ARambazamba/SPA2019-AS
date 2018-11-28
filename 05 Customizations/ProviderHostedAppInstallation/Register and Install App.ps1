if ((Get-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue) -eq $null) 
{
    Add-PSSnapin "Microsoft.SharePoint.PowerShell"
}

$clientID = "59651c55-335e-4a44-b636-d9540e2ae4a8"
$appFile = "D:\SPA2016-AS\05\ProviderHostedAppInstallation\ProviderApp\ProviderApp\bin\Debug\app.publish\1.0.0.4\ProviderApp.app"
$siteCollection = "http://SP2016"
$appName = "ProviderApp"

$web = Get-SPWeb -Identity $siteCollection

$realm = Get-SPAuthenticationRealm -ServiceContext $web.Site;
$appIdentifier = $clientID  + '@' + $realm;

#Register the App with given ClientId
$appPrincipal = Register-SPAppPrincipal -DisplayName $appName -NameIdentifier $appIdentifier -Site $web 

$app = Import-SPAppPackage -Path $appFile -Site $siteCollection -Source ObjectModel -Confirm:$false 	

#Install the App
Install-SPApp -Web $siteCollection -Identity $app

Set-SPAppPrincipalPermission -Site $web -AppPrincipal $appPrincipal -Scope SiteCollection -Right FullControl
exit

#List

$Url = "http://sp2016"
$web = Get-SPWeb -Identity $Url
$realm = Get-SPAuthenticationRealm -ServiceContext $web.Site;
$appIdentifier = $clientID  + '@' + $realm;
Get-SPAppPrincipal -NameIdentifier $appIdentifier -Site $Url

exit