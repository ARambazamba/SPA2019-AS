# Pfad zur Freigabe mit Prerequ
$SharePoint2016Path = "y:\PrerequisiteInstaller"
# Pfad zum SharePoint Setup.ison
Start-Process "x:\PrerequisiteInstaller.exe" –ArgumentList "/SQLNCli:$SharePoint2016Path\sqlncli-2012.msi /IDFX11:$SharePoint2016Path\MicrosoftIdentityExtensions-64.msi /Sync:$SharePoint2016Path\Synchronization.msi /AppFabric:$SharePoint2016Path\WindowsServerAppFabricSetup_x64.exe /MSIPCClient:$SharePoint2016Path\setup_msipc_x64.exe /WCFDataServices56:$SharePoint2016Path\WcfDataServices56.exe /DotNetFx:$SharePoint2016Path\NDP46-KB3045557-x86-x64-AllOS-ENU.exe /MSVCRT11:$SharePoint2016Path\vcredist_x64.exe /MSVCRT14:$SharePoint2016Path\vc_redist.x64.exe /KB3092423:$SharePoint2016Path\AppFabric-KB3092423-x64-ENU.exe"
