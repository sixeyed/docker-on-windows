# escape=`
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.7.2-windowsservercore-ltsc2019
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG source
ARG configuration

WORKDIR C:\web-app

RUN Remove-Website -Name 'Default Web Site';`
    New-Website -Name 'web-app' -Port 80 -PhysicalPath 'C:\web-app'

RUN if ($env:configuration -eq 'debug') `
     { Invoke-WebRequest -OutFile c:\rtools_setup_x64.exe -UseBasicParsing -Uri http://download.microsoft.com/download/1/2/2/1225c23d-3599-48c9-a314-f7d631f43241/rtools_setup_x64.exe; `
       Start-Process c:\rtools_setup_x64.exe -ArgumentList '/install', '/quiet' -NoNewWindow -Wait }

ENTRYPOINT ["powershell", "C:\\bootstrap.ps1"]

COPY .\Docker\bootstrap.ps1 /bootstrap.ps1
COPY ${source:-.\Docker\publish} .