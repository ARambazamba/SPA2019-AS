if ((Get-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue) -eq $null) 
{
    Add-PSSnapin "Microsoft.SharePoint.PowerShell"
}

#Variables
$WebAppURL = "http://sp2016"
$SiteURL = "/"

$PackagePath = "D:\SPA2016-AS\05\Deploy\"
$PackageName = "EventReceivers.wsp"
$FeatureID = [Guid]("4d164d13-c1dc-4894-885c-87981fcca573")
$SleepTime = 10

#Constants
$PackageFullPath = $PackagePath + $PackageName
$ActivateURL = $WebAppURL + $SiteURL

# Add solution to sharepoint farm
Add-SPSolution $PackageFullPath
# Deploy Solution
Install-SPSolution -Identity $PackageName -GACDeployment

## Wait until deployment is done 
$Solution = Get-SPSolution -identity $PackageName
$lastStatus = ""

## loop whilst there is a Job attached to the Solution 
while ($Solution.JobExists -eq $True) 
{ 
    $currentStatus = $Solution.JobStatus 
    if ($currentStatus -ne $lastStatus) 
    { 
            Write-Host "$currentStatus…" -foreground green -nonewline 
            $lastStatus = $currentStatus 
    } 
    Write-Host "." -foreground green -nonewline 
    sleep $SleepTime 
} 
## completed 
Write-Host "" 
Write-Host "     " $Solution.LastOperationDetails -foreground green

# Enable the feature

Enable-SPFeature $FeatureID –URL $ActivateURL
