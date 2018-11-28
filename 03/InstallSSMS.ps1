# Set file and folder path for SSMS installer .exe
$folderpath="c:\windows\temp"
$filepath="$folderpath\SSMS-Setup-ENU.exe"
 
#If SSMS not present, download
if (!(Test-Path $filepath)){
    write-host "Downloading SQL Server 2016 SSMS..."
    $URL = "https://go.microsoft.com/fwlink/?linkid=854085"
    $clnt = New-Object System.Net.WebClient
    $clnt.DownloadFile($url,$filepath)
    Write-Host "SSMS installer download complete" -ForegroundColor Green 
}
else {
    Write-Host "Located the SQL SSMS Installer binaries, moving on to install..."
}
 
# start the SSMS installer
Write-Host "Beginning SSMS 2016 install..." -nonewline
$Parms = " /Install /Quiet /Norestart /Logs log.txt"
$Prms = $Parms.Split(" ")
& "$filepath" $Prms | Out-Null
Write-Host "SSMS installation complete" -ForegroundColor Green