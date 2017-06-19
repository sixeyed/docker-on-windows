# escape=`
FROM microsoft/windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV 7ZIP_VERSION 1604

RUN Invoke-WebRequest "http://7-zip.org/a/7z$($env:7ZIP_VERSION)-x64.msi" -OutFile '7z.msi' -UseBasicParsing; `
    Start-Process msiexec.exe -ArgumentList '/i', '7z.msi', '/quiet', '/norestart' -NoNewWindow -Wait; `
    Remove-Item 7z.msi