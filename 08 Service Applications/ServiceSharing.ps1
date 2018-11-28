if ((Get-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue) -eq $null) 
{
    Add-PSSnapin "Microsoft.SharePoint.PowerShell"
}

#Export Root Cert from consuming farm

$rootCert = (Get-SPCertificateAuthority).RootCertificate
$rootCert.Export("Cert") | Set-Content "C:\ConsumingFarmRoot.cer" -Encoding byte

#Export STS certificate from consuming farm

$stsCert = (Get-SPSecurityTokenServiceConfig).LocalLoginProvider.SigningCertificate
$stsCert.Export("Cert") | Set-Content "C:\ConsumingFarmSTS.cer" -Encoding byte

#Export Root Cert from publishing farm

$rootCertPubl = (Get-SPCertificateAuthority).RootCertificate
$rootCertPubl.Export("Cert") | Set-Content "C:\PublishingFarmRoot.cer" -Encoding byte

#Export STS certificate from publishing farm

$stsCertPubl = (Get-SPSecurityTokenServiceConfig).LocalLoginProvider.SigningCertificate
$stsCertPubl.Export("Cert") | Set-Content "C:\PublishingFarmSTS.cer" -Encoding byte


#import the root certificate and create a trusted root authority on the consuming farm 

$trustCert = Get-PfxCertificate "C:\PublishingFarmRoot.cer"
New-SPTrustedRootAuthority "PublishingFarm" -Certificate $trustCert

#import the root certificate and create a trusted root authority on the publishing farm 

$trustCert = Get-PfxCertificate "C:\ConsumingFarmRoot.cer"
New-SPTrustedRootAuthority "ConsumingFarm" -Certificate $trustCert

#import the STS certificate and create a trusted service token issuer on the publishing farm 

$stsCert = Get-PfxCertificate "c:\ConsumingFarmSTS.cer"
New-SPTrustedServiceTokenIssuer "ConsumingFarm" -Certificate $stsCert
