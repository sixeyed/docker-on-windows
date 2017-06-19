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
    mkdir 'c:\nerd-dinner'; `
    New-Website -Name 'nerd-dinner' -Port 8081 -PhysicalPath 'c:\nerd-dinner'

RUN & c:\windows\system32\inetsrv\appcmd.exe unlock config /section:system.webServer/handlers
RUN set-itemproperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord  

EXPOSE 8081
ENV BING_MAPS_KEY="" `
    IP_INFO_DB_KEY="" `
    HOMEPAGE_URL="http://nerd-dinner-homepage:5000" `
    AUTH_DB_CONNECTION_STRING="Data Source=nerd-dinner-db,1433;Initial Catalog=NerdDinner;User Id=sa;Password=N3rdD!Nne720^6;" `
    APP_DB_CONNECTION_STRING="Data Source=nerd-dinner-db,1433;Initial Catalog=NerdDinner;User Id=sa;Password=N3rdD!Nne720^6;MultipleActiveResultSets=True;" `
    MESSAGE_QUEUE_URL="nats://message-queue:4222"

HEALTHCHECK CMD powershell -command `
    try { `
     $response = iwr http://localhost:8081/ -UseBasicParsing; `
     if ($response.StatusCode -eq 200) { return 0} `
     else {return 1}; `
    } catch { return 1 }

COPY nerd-dinner c:\nerd-dinner
COPY bootstrap.ps1 /

CMD /bootstrap.ps1