# Backup

Backup the whole farm

```
Backup-SPFarm -Directory \\file_server\share\Backup -BackupMethod full -BackupThreads 10 -Force
```

Performs a backup of a site collection.

```
Backup-SPSite http://sp2016/sites/site_name -Path C:\Backup\site_name.bak
```

Restore a site

```
Restore-SPSite http://sp2016/sites/site_name -Path C:\Backup\site_name.bak
```

# Migration

[Get started with upgrades to SharePoint Server 2016](https://docs.microsoft.com/en-us/sharepoint/upgrade-and-update/get-started-with-upgrade)

Test if all customizations are installed

```
Test-SPContentDatabase -Name "wss_content" -WebApplication http://sp2016:9999
```

Attaches an existing content database to the farm - migrates metadata

```
Mount-SPContentDatabase -Name "wss_content" -DatabaseServer "SP2016" -WebApplication http://sp2016:9999
```
