Write-Host "Windows Server 2012 R2 - Configuration"

Write-Host " - Importing Module Servermanager..."  
Import-Module Servermanager

Write-Host " - Installing .NET Framework Feature..."  
get-windowsfeature|where{$_.name -eq "NET-Framework-Core"}|install-windowsfeature “Source d:\sources\sxs  
get-windowsfeature|where{$_.name -eq "NET-HTTP-Activation"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "NET-Non-HTTP-Activ"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "NET-WCF-HTTP-Activation45"}|install-windowsfeature

Write-Host " - Installing 'Application Server' role..."  
get-windowsfeature|where{$_.name -eq "AS-AppServer-Foundation"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "AS-Web-Support"}|install-windowsfeature  
#get-windowsfeature|where{$_.name -eq "AS-TCP-Port-Sharing"}|install-windowsfeature
#get-windowsfeature|where{$_.name -eq "AS-WAS-Support"}|install-windowsfeature
#get-windowsfeature|where{$_.name -eq "AS-HTTP-Activation"}|install-windowsfeature
#get-windowsfeature|where{$_.name -eq "AS-Named-Pipes"}|install-windowsfeature
#get-windowsfeature|where{$_.name -eq "AS-TCP-Activation"}|install-windowsfeature

Write-Host " - Installing 'Web Server' role..."  
get-windowsfeature|where{$_.name -eq "Web-Static-Content"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-Default-Doc"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-Dir-Browsing"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-Http-Errors"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-Http-Redirect"}|install-windowsfeature

get-windowsfeature|where{$_.name -eq "Web-App-Dev"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-Asp-Net45"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-Net-Ext"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-Net-Ext45"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-ISAPI-Ext"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-ISAPI-Filter"}|install-windowsfeature

get-windowsfeature|where{$_.name -eq "Web-Http-Logging"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-Log-Libraries"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-Request-Monitor"}|install-windowsfeature  
#get-windowsfeature|where{$_.name -eq "Web-Http-Tracing"}|install-windowsfeature

get-windowsfeature|where{$_.name -eq "Web-Stat-Compression"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-Dyn-Compression"}|install-windowsfeature

get-windowsfeature|where{$_.name -eq "Web-Filtering"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-Basic-Auth"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-Windows-Auth"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-Digest-Auth"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-Client-Auth"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-Cert-Auth"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-Url-Auth"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-IP-Security"}|install-windowsfeature

get-windowsfeature|where{$_.name -eq "Web-Mgmt-Tools"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-Mgmt-Console"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-Mgmt-Compat"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-Metabase"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-Lgcy-Mgmt-Console"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-Lgcy-Scripting"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-WMI"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "Web-Scripting-Tools"}|install-windowsfeature

Write-Host " - Installing WAS Feature..."  
get-windowsfeature|where{$_.name -eq "WAS-Process-Model"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "WAS-NET-Environment"}|install-windowsfeature  
get-windowsfeature|where{$_.name -eq "WAS-Config-APIs"}|install-windowsfeature

Write-Host " - Installing Windows Identity Foundation Feature..."  
get-windowsfeature|where{$_.name -eq "Windows-Identity-Foundation"}|install-windowsfeature