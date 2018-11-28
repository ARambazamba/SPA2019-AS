# replace these details (also consider using Get-Credential to enter password securely as script runs).. 
$username = "administrator" 
$password = "Pa$$w0rd" 
$url = "http://sp2016"

# the path here may need to change if you used e.g. C:\Lib.. 
Add-Type -Path "c:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.dll" 
Add-Type -Path "c:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.Runtime.dll" 
# note that you might need some other references (depending on what your script does) for example:
Add-Type -Path "c:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.Taxonomy.dll" 

# connect/authenticate to Remote SharePoint e. g. SharePoint Online and get ClientContext object.. 
$clientContext = New-Object Microsoft.SharePoint.Client.ClientContext($url) 
$credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username, $password) 
$clientContext.Credentials = $credentials 

if (!$clientContext.ServerObjectIsNull.Value) 
{ 
    Write-Host "Connected to Remote SharePoint: '$Url'" -ForegroundColor Green 
} 

[bool]$enable = $false
[bool]$force = $false
 
# using the Minimal Download Strategy Feature here..
$FeatureId = [GUID]("87294C72-F260-42f3-A41B-981A2FFCE37A")
 
# ..and working with the web-scoped Features - use $clientContext.Site.Features for site-scoped Features
$webFeatures = $clientContext.Web.Features
$clientContext.Load($webFeatures)
$clientContext.ExecuteQuery()
 
if ($enable)
{
$webfeatures.Add($featureId, $force, [Microsoft.SharePoint.Client.FeatureDefinitionScope]::None)
}
else
{
$webfeatures.Remove($featureId, $force)
}
 
try
{
$clientContext.ExecuteQuery()
if ($enable)
{
Write-Host "Feature '$FeatureId' successfully activated.."
}
else
{
Write-Host "Feature '$FeatureId' successfully deactivated.."
}
}
catch
{
Write-Error "An error occurred whilst activating/deactivating the Feature. Error detail: $($_)"
}