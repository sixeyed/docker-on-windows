
# update the connection strings:
Stop-Service W3SVC
$connectionString = "Data Source=nerd-dinner-db,1433;Initial Catalog=NerdDinner;User Id=sa;Password=$($env:sa_password);MultipleActiveResultSets=True"

$file = 'C:\nerd-dinner\Web.config' 
[xml]$config = Get-Content $file;
$db1Node = $config.configuration.connectionStrings.add | where {$_.name -eq 'DefaultConnection'}
$db1Node.connectionString = $connectionString
$db2Node = $config.configuration.connectionStrings.add | where {$_.name -eq 'NerdDinnerContext'}
$db2Node.connectionString = $connectionString
$config.Save($file)

# copy process-level environment variables (from `docker run`) machine-wide:
foreach($key in [System.Environment]::GetEnvironmentVariables('Process').Keys) {
    if ([System.Environment]::GetEnvironmentVariable($key, 'Machine') -eq $null) {
        $value = [System.Environment]::GetEnvironmentVariable($key, 'Process')
        [System.Environment]::SetEnvironmentVariable($key, $value, 'Machine')
    }
}

# echo the IIS log to the console:
Start-Service W3SVC 
Invoke-WebRequest http://localhost -UseBasicParsing | Out-Null
netsh http flush logbuffer | Out-Null
Get-Content -path 'c:\iislog\W3SVC\u_extend1.log' -Tail 1 -Wait 