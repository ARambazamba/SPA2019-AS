if ((Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null)
{
    Add-PSSnapin Microsoft.SharePoint.PowerShell
}

$DatabaseServer = "SP2016";
$ConfigDBName = "SharePoint_Config";
$AdminContentDBName = "SPAdminContent";
# Pa$$w0rd
Write-Host "Enter Secure Passphrase";
$Passphrase = Read-Host -AsSecureString;
$ServerRole = "SingleServerFarm";
$CentralAdminPort = 5555;
$AuthProvider = "NTLM";

$FarmCredential = Get-Credential -Message "Enter the Farm Account credentials - SPDOM\User"

New-SPConfigurationDatabase -DatabaseName $ConfigDBName -DatabaseServer $DatabaseServer -AdministrationContentDatabaseName $AdminContentDBName -FarmCredentials $FarmCredential -Passphrase $Passphrase -LocalServerRole $ServerRole -SkipRegisterAsDistributedCacheHost -ErrorVariable err

Write-Progress -Activity "SharePoint Farm Configuration" -Status "Verifying farm creation" -PercentComplete 30
$spfarm = Get-SPFarm
 
if ($spfarm -ne $null) 
{   
    Write-Progress -Activity "SharePoint Farm Configuration" -Status "Securing SharePoint resources" -PercentComplete 40
    Initialize-SPResourceSecurity -ErrorVariable err            
        
    Write-Progress -Activity "SharePoint Farm Configuration" -Status "Installing services" -PercentComplete 50    
    Install-SPService -ErrorVariable err
        
    Write-Progress -Activity "SharePoint Farm Configuration" -Status "Installing features" -PercentComplete 60    
    Install-SPFeature -AllExistingFeatures -ErrorVariable err > $null
        
    Write-Progress -Activity "SharePoint Farm Configuration" -Status "Provisioning Central Administration" -PercentComplete 70    
    New-SPCentralAdministration -Port $CentralAdminPort -WindowsAuthProvider $AuthProvider -ErrorVariable err
        
    Write-Progress -Activity "SharePoint Farm Configuration" -Status "Installing Help" -PercentComplete 80      
    Install-SPHelpCollection -All -ErrorVariable err
        
    Write-Progress -Activity "SharePoint Farm Configuration" -Status "Installing application content" -PercentComplete 90      
    Install-SPApplicationContent -ErrorVariable err
} 
else 
{ 
    Write-Error "ERROR: $err"
}