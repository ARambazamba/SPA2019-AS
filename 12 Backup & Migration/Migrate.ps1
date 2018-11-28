#Test if all customizations are installed

Test-SPContentDatabase -Name "wss_content" -WebApplication http://sp2016:9999

#Attaches an existing content database to the farm - migrates metadata
Mount-SPContentDatabase -Name "wss_content" -DatabaseServer "SP2016" -WebApplication http://sp2016:9999