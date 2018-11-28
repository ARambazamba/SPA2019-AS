if ((Get-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue) -eq $null) 
{
    Add-PSSnapin "Microsoft.SharePoint.PowerShell"
}

write-host -ForegroundColor Green "setup managed metadata service…";

$FarmName = "SPDom" 
$DatabaseServer = "SP2016" 
$DatabaseUser = "spdom\spservice" 
$DatabaseUserPassword = (ConvertTo-SecureString "Pa$$w0rd" -AsPlainText -force) 
$DatabaseCredentials = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $DatabaseUser, $DatabaseUserPassword 

$ServiceApplicationUser = "spdom\spservice" 
$ServiceApplicationUserPassword = (ConvertTo-SecureString "Pa$$w0rd" -AsPlainText -force) 
$ServiceApplicationCredentials = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $ServiceApplicationUser, $ServiceApplicationUserPassword 

$ServiceApplicationPool = "SecurityTokenServiceApplicationPool" 
$MetadataDatabaseName = ("{0}_Metadata" -f $FarmName) 
$MetadataServiceName = "Managed Metadata Service"

try{

      #Managed Account 
      write-host -ForegroundColor Green "Managed account…"; 
      $ManagedAccount = Get-SPManagedAccount $ServiceApplicationUser

      if ($ManagedAccount -eq $NULL)  
      {  
           write-host  -ForegroundColor Green "Create new managed account" 
           $ManagedAccount = New-SPManagedAccount -Credential $ServiceApplicationCredentials 
      }

     

      #App Pool 
      write-host -ForegroundColor Green "App pool…";

      $ApplicationPool = Get-SPServiceApplicationPool  "SharePoint Hosted Services" -ea SilentlyContinue

      if($ApplicationPool -eq $null){ 

            write-host  -ForegroundColor Green "Create new app pool" 
            $ApplicationPool = New-SPServiceApplicationPool "SharePoint Hosted Services" -account $ManagedAccount 

            if (-not $?) { throw "Failed to create an application pool" }

      }
     
      #Create a Taxonomy Service Application 
      write-host -ForegroundColor Green "Create a Taxonomy Service Application…";

      if((Get-SPServiceApplication |?{$_.TypeName -eq "Managed Metadata Service"})-eq $null){     

            Write-Progress "Creating Taxonomy Service Application" -Status "Please Wait…" 
            #get the service instance

            $MetadataServiceInstance = (Get-SPServiceInstance |?{$_.TypeName -eq "Managed Metadata Web Service"})

            if (-not $?) { throw "Failed to find Metadata service instance" }

           

             #Start Service instance 
            Write-Progress "Start Service instance" -Status "Please Wait…"

            if($MetadataserviceInstance.Status -eq "Disabled"){ 

                  $MetadataserviceInstance | Start-SPServiceInstance 

                  if (-not $?) { throw "Failed to start Metadata service instance" }

            } 

            #Wait 
            write-host -ForegroundColor Yellow "Waiting for Metadata service to provision";

            while(-not ($MetadataServiceInstance.Status -eq "Online")){ #wait for provisioning

                  # write status 
                  write-host  -ForegroundColor Yellow -NoNewline $MetadataServiceInstance.Status; sleep 5; 
                  write-host  -ForegroundColor Yellow -NoNewline "."; sleep 5;

                  # Update the object 
                  $MetadataServiceInstance = (Get-SPServiceInstance |?{$_.TypeName -eq "Managed Metadata Web Service"}) 
            }

            #Create Service App

            $MetaDataServiceApp  = New-SPMetadataServiceApplication -Name "Metadata Service Application" -ApplicationPool $ApplicationPool  -DatabaseServer $DatabaseServer -DatabaseName $MetadataDatabaseName 
            if (-not $?) { throw "Failed to create Metadata Service Application" }

           

            #create proxy

            $MetaDataServiceAppProxy  = New-SPMetadataServiceApplicationProxy -Name "Metadata Service Application Proxy" -ServiceApplication $MetaDataServiceApp -DefaultProxyGroup

            if (-not $?) { throw "Failed to create Metadata Service Application Proxy" }

      }

}

catch 
{ 
            Write-Output $_  
}