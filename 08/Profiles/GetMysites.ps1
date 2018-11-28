if ((Get-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue) -eq $null) 
{
    Add-PSSnapin "Microsoft.SharePoint.PowerShell"
}

$WebApp =  Get-SPWebApplication -Identity http://sp2016 
$Sites = $WebApp.Sites | Where-Object {$_.URL -like "http://sp2016/my/personal/*"}
$Sites | Select-Object URL, LastContentModifiedDate | Sort LastContentModifiedDate -Descending