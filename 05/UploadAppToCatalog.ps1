if ((Get-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue) -eq $null) 
{
    Add-PSSnapin "Microsoft.SharePoint.PowerShell"
}

#the folder which contains the .app files ready to be uploaded
$Folder = "D:\SPA2016-AS\05\Deploy\"

#"App for SharePoint" library in App Catalog site
$DocLibName = "Apps for SharePoint"
$SiteURL = "http://sp2016/sites/appCatalog"

#Add references to SharePoint client assemblies and authenticate to Office 365 site - required for CSOM
Add-Type -Path 'C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.dll'
Add-Type -Path 'C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.Runtime.dll'
Add-Type -Path 'C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.Office.Client.TranslationServices.dll'

$loginname = "spdom\administrator"
$pwd = "Pa$$w0rd"
$Password = ConvertTo-SecureString $pwd -AsPlainText -Force 

$ctx = New-Object Microsoft.SharePoint.Client.ClientContext($siteUrl)
$ctx.Credentials = New-Object System.Net.NetworkCredential($loginname, $Password)

#Retrieve list
$List = $ctx.Web.Lists.GetByTitle($DocLibName)
$ctx.Load($List)
$Context.ExecuteQuery()

#Upload file
Foreach ($File in (dir $Folder -File))
{
    if($File.Extension -eq ".app"){
    	$FileStream = New-Object IO.FileStream($File.FullName,[System.IO.FileMode]::Open)
	    $FileCreationInfo = New-Object Microsoft.SharePoint.Client.FileCreationInformation
	    $FileCreationInfo.Overwrite = $true
	    $FileCreationInfo.ContentStream = $FileStream
	    $FileCreationInfo.URL = $File
	    $Upload = $List.RootFolder.Files.Add($FileCreationInfo)
	    $Context.Load($Upload)
	    $Context.ExecuteQuery()
    }
}