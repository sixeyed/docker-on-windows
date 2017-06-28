# Adapted from Microsoft's SQL Server Express sample:
# https://github.com/Microsoft/sql-server-samples/blob/master/samples/manage/windows-containers/mssql-server-2016-express-windows/start.ps1

param(
    [Parameter(Mandatory=$false)]
    [string]$sa_password)

# start the service
Write-Verbose 'Starting SQL Server'
start-service MSSQL`$SQLEXPRESS

if ($sa_password -ne "_") {
	Write-Verbose 'Changing SA login credentials'
    $sqlcmd = "ALTER LOGIN sa with password='$sa_password'; ALTER LOGIN sa ENABLE;"
    Invoke-Sqlcmd -Query $sqlcmd -ServerInstance ".\SQLEXPRESS" 
}
 
Invoke-Sqlcmd -InputFile C:\init\init-db.sql -Verbose

$lastCheck = (Get-Date).AddSeconds(-2) 
while ($true) { 
    Get-EventLog -LogName Application -Source "MSSQL*" -After $lastCheck | Select-Object TimeGenerated, EntryType, Message	 
    $lastCheck = Get-Date 
    Start-Sleep -Seconds 2 
}