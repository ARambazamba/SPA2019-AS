$ScriptFld = "D:\SPA2016-AS\03"
Start-Process "x:\setup.exe" -ArgumentList "/config `"$ScriptFld\SetupSharepoint.xml`"" -WindowStyle Minimized -wait  