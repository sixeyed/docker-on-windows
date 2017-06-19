Write-Output 'Bootstrap starting'

# copy process-level environment variables (from `docker run`) machine-wide
foreach($key in [System.Environment]::GetEnvironmentVariables('Process').Keys) {
    if ([System.Environment]::GetEnvironmentVariable($key, 'Machine') -eq $null) {
        $value = [System.Environment]::GetEnvironmentVariable($key, 'Process')
        [System.Environment]::SetEnvironmentVariable($key, $value, 'Machine')
        Write-Output "Set environment variable: $key"
    }
}

Write-Output 'Making warmup HTTP call'
Start-Service W3SVC 
Invoke-WebRequest http://localhost/Bonobo.Git.Server -UseBasicParsing | Out-Null

Write-Output 'Starting Prometheus exporter'
& C:\prometheus-exporter\DotNetExporter.Console.exe