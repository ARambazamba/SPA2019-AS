
$siteUrl = "http://SP2016/"
$username = "Administrator@spdom.local" 
$password = ConvertTo-SecureString "Pa$$w0rd" -AsPlainText -Force
$language = "fr-fr"
$input = "http://sp2016/Documents/Demo.docx"
$output = "http://SP2016/Documents/DemoFR.docx"

Add-Type -Path "c:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.dll" 
Add-Type -Path "c:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.Runtime.dll" 
Add-Type -Path 'C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.Office.Client.TranslationServices.dll'


$ctx = New-Object Microsoft.SharePoint.Client.ClientContext($url) 
$credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username, $password) 
$ctx.Credentials = $credentials 

if (!$clientContext.ServerObjectIsNull.Value) 
{ 
    Write-Host "Connected to Remote SharePoint: '$Url'" -ForegroundColor Green 
} 

$job = New-Object Microsoft.Office.Client.TranslationServices.SyncTranslator($ctx, $language)
$job.OutputSaveBehavior = [Microsoft.Office.Client.TranslationServices.SaveBehavior]::AppendIfPossible
$job.Translate([string]$input, [string]$output);
$ctx.ExecuteQuery()