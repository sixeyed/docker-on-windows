# escape=`
FROM microsoft/dotnet-framework:4.7.2-sdk-windowsservercore-ltsc2019 AS builder

WORKDIR C:\src
COPY src\NerdDinner.Core\NerdDinner.Core.csproj .\NerdDinner.Core\
COPY src\NerdDinner.Messaging\NerdDinner.Messaging.csproj .\NerdDinner.Messaging\
COPY src\NerdDinner.Model\NerdDinner.Model.csproj .\NerdDinner.Model\
COPY src\NerdDinner.Model\packages.config .\NerdDinner.Model\
COPY src\NerdDinner\NerdDinner.csproj .\NerdDinner\
COPY src\NerdDinner\packages.config .\NerdDinner\
COPY src\NerdDinner.sln .
RUN nuget restore 

COPY src\NerdDinner.Core .\NerdDinner.Core
COPY src\NerdDinner.Messaging .\NerdDinner.Messaging
COPY src\NerdDinner.Model .\NerdDinner.Model
COPY src\NerdDinner .\NerdDinner
RUN msbuild .\NerdDinner\NerdDinner.csproj /p:Configuration=Release /p:OutputPath=c:\nerd-dinner-web

# nerd-dinner
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.7.2-windowsservercore-ltsc2019
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# configure IIS to write a global log file:
RUN Set-WebConfigurationProperty -p 'MACHINE/WEBROOT/APPHOST' -fi 'system.applicationHost/log' -n 'centralLogFileMode' -v 'CentralW3C'; `
    Set-WebConfigurationProperty -p 'MACHINE/WEBROOT/APPHOST' -fi 'system.applicationHost/log/centralW3CLogFile' -n 'truncateSize' -v 4294967295; `
    Set-WebConfigurationProperty -p 'MACHINE/WEBROOT/APPHOST' -fi 'system.applicationHost/log/centralW3CLogFile' -n 'period' -v 'MaxSize'; `
    Set-WebConfigurationProperty -p 'MACHINE/WEBROOT/APPHOST' -fi 'system.applicationHost/log/centralW3CLogFile' -n 'directory' -v 'c:\iislog'

WORKDIR C:\nerd-dinner
RUN Import-Module WebAdministration; `
    Set-ItemProperty IIS:\AppPools\DefaultAppPool -Name processModel.identityType -Value LocalSystem; `
    Remove-Website -Name 'Default Web Site'; `
    New-Website -Name 'nerd-dinner' `
                -Port 80 -PhysicalPath 'c:\nerd-dinner'

RUN & c:\windows\system32\inetsrv\appcmd.exe `
      unlock config `
      /section:system.webServer/handlers

HEALTHCHECK --interval=5s --start-period=10s `
 CMD powershell -command `
    try { `
     $response = iwr http://localhost -UseBasicParsing; `
     if ($response.StatusCode -eq 200) { return 0} `
     else {return 1}; `
    } catch { return 1 }

ENTRYPOINT ["powershell"]
CMD Start-Process -NoNewWindow -FilePath C:\ServiceMonitor.exe -ArgumentList w3svc; `
    Invoke-WebRequest http://localhost -UseBasicParsing | Out-Null; `
    netsh http flush logbuffer | Out-Null; `
    Get-Content -path 'C:\iislog\W3SVC\u_extend1.log' -Tail 1 -Wait 

COPY --from=builder C:\nerd-dinner-web\_PublishedWebsites\NerdDinner\ .