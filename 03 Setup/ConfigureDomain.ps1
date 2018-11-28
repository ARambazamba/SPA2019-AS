# Create New Forest, add Domain Controller 
$domainname = "spdom.local" 
$netbiosName = "spdom"

Install-windowsfeature -name AD-Domain-Services –IncludeManagementTools;
Import-Module ADDSDeployment;
Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath "C:\Windows\NTDS" -DomainMode 7 -DomainName $domainname -DomainNetbiosName $netbiosName -ForestMode 7 -InstallDns:$true -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion:$false -SysvolPath "C:\Windows\SYSVOL" -Force:$true;
