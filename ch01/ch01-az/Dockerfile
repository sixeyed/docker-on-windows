# escape=`
FROM mcr.microsoft.com/windows/servercore:1809
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV AZ_PATH="C:\Program Files (x86)\Microsoft SDKs\Azure\CLI2\wbin;"

RUN Invoke-WebRequest "https://aka.ms/InstallAzureCliWindows" -OutFile az.msi -UseBasicParsing; `
    Start-Process msiexec.exe -ArgumentList '/i', 'C:\az.msi', '/quiet', '/norestart' -NoNewWindow -Wait; `
    Remove-Item az.msi; `
    $env:PATH = $env:AZ_PATH + $env:PATH; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)