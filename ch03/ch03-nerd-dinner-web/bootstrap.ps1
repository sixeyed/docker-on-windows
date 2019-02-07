## this is an alternative to using ServiceMonitor

# copy process-level environment variables to machine level
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
Get-Content -path 'C:\iislog\W3SVC\u_extend1.log' -Tail 1 -Wait 