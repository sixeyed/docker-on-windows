# escape=`
FROM dockeronwindows/ch07-nerd-dinner-builder AS builder

# app image
FROM microsoft/aspnet:windowsservercore-10.0.14393.1198
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# configure IIS to write a global log file:
RUN Set-WebConfigurationProperty -p 'MACHINE/WEBROOT/APPHOST' -fi 'system.applicationHost/log' -n 'centralLogFileMode' -v 'CentralW3C'; `
    Set-WebConfigurationProperty -p 'MACHINE/WEBROOT/APPHOST' -fi 'system.applicationHost/log/centralW3CLogFile' -n 'truncateSize' -v 4294967295; `
    Set-WebConfigurationProperty -p 'MACHINE/WEBROOT/APPHOST' -fi 'system.applicationHost/log/centralW3CLogFile' -n 'period' -v 'MaxSize'; `
    Set-WebConfigurationProperty -p 'MACHINE/WEBROOT/APPHOST' -fi 'system.applicationHost/log/centralW3CLogFile' -n 'directory' -v 'c:\iislog'

RUN Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -n ServerPriorityTimeLimit -v 0 -t DWord 

WORKDIR C:\nerd-dinner
RUN Import-Module WebAdministration; `
    Remove-Website -Name 'Default Web Site'; `
    New-WebAppPool -Name 'ap-nd'; `
    Set-ItemProperty IIS:\AppPools\ap-nd -Name managedRuntimeVersion -Value v4.0; `
    Set-ItemProperty IIS:\AppPools\ap-nd -Name processModel.identityType -Value LocalSystem; `
    New-Website -Name 'nerd-dinner' `
                -Port 80 -PhysicalPath 'C:\nerd-dinner' `
                -ApplicationPool 'ap-nd'

RUN & c:\windows\system32\inetsrv\appcmd.exe `
      unlock config `
      /section:system.webServer/handlers

HEALTHCHECK --interval=5s `
 CMD powershell -command `
    try { `
     $response = iwr http://localhost -UseBasicParsing; `
     if ($response.StatusCode -eq 200) { return 0} `
     else {return 1}; `
    } catch { return 1 }

COPY bootstrap.ps1 C:\
ENTRYPOINT ["powershell", "C:\\bootstrap.ps1"]

ENV HOMEPAGE_URL="http://nerd-dinner-homepage" `
    MESSAGE_QUEUE_URL="nats://message-queue:4222"

COPY --from=builder C:\out\NerdDinner\_PublishedWebsites\NerdDinner\ .