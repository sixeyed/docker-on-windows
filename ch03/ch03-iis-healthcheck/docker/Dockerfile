# escape=`
FROM microsoft/windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

RUN Install-WindowsFeature Web-Server, NET-Framework-45-ASPNET, Web-Asp-Net45

# configure IIS to write a global log file:
RUN Set-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter 'system.applicationHost/log' -name 'centralLogFileMode' -value 'CentralW3C'; `
    Set-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter 'system.applicationHost/log/centralW3CLogFile' -name 'truncateSize' -value 4294967295; `
    Set-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter 'system.applicationHost/log/centralW3CLogFile' -name 'period' -value 'MaxSize'; `
    Set-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter 'system.applicationHost/log/centralW3CLogFile' -name 'directory' -value 'c:\iislog'

RUN Remove-Website -Name 'Default Web Site';`
    mkdir 'c:\healthcheck-api'; `
    New-Website -Name 'healthcheck-api' -Port 8090 -PhysicalPath 'c:\healthcheck-api'

EXPOSE 8090
ENV APP_ENVIRONMENT="dev"
HEALTHCHECK CMD powershell -command `
    try { `
     $response = iwr http://localhost:8090/diagnostics -UseBasicParsing; `
     if ($response.StatusCode -eq 200) { return 0} `
     else {return 1}; `
    } catch { return 1 }

COPY healthcheck-api c:\healthcheck-api
COPY bootstrap.ps1 /

CMD /bootstrap.ps1