if ((Get-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue) -eq $null) 
{
    Add-PSSnapin "Microsoft.SharePoint.PowerShell"
}

$ServiceApplicationUser = "spdom\spservice" 
$ServiceApplicationUserPassword = (ConvertTo-SecureString "Pa$$w0rd" -AsPlainText -force) 
$ServiceApplicationCredentials = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $ServiceApplicationUser, $ServiceApplicationUserPassword 

$ManagedAccount = Get-SPManagedAccount $ServiceApplicationUser

$ApplicationPool = Get-SPServiceApplicationPool  "SharePoint Hosted Services" -ea SilentlyContinue

if($ApplicationPool -eq $null){ 

    write-host  -ForegroundColor Green "Create new app pool" 
    $ApplicationPool = New-SPServiceApplicationPool "SharePoint Hosted Services" -account $ManagedAccount 

    if (-not $?) { throw "Failed to create an application pool" }

}

New-SPTranslationServiceApplication -Name "Machine Translation Service Application" -DatabaseName "MachineTranslationDB" -DatabaseServer "SP2013c" -ApplicationPool $ApplicationPool -Default