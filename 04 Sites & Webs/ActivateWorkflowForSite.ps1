if ((Get-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue) -eq $null) 
{
    Add-PSSnapin "Microsoft.SharePoint.PowerShell"
}

Register-SPWorkflowService –SPSite http://sp2016/ –WorkflowHostUri http://sp2016:12291 –AllowOAuthHttp -Force