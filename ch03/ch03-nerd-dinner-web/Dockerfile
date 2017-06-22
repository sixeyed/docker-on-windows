# escape=`
FROM sixeyed/msbuild:netfx-4.5.2-webdeploy-10.0.14393.1198 AS builder

WORKDIR C:\src\NerdDinner
COPY src\NerdDinner\packages.config .
RUN nuget restore packages.config -PackagesDirectory ..\packages

COPY src C:\src
RUN msbuild NerdDinner.csproj /p:OutputPath=c:\out\NerdDinner `
        /p:DeployOnBuild=true /p:VSToolsPath=C:\MSBuild.Microsoft.VisualStudio.Web.targets.14.0.0.3\tools\VSToolsPath

# app image
FROM microsoft/aspnet:windowsservercore-10.0.14393.1198
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# configure IIS to write a global log file:
RUN Set-WebConfigurationProperty -p 'MACHINE/WEBROOT/APPHOST' -fi 'system.applicationHost/log' -n 'centralLogFileMode' -v 'CentralW3C'; `
    Set-WebConfigurationProperty -p 'MACHINE/WEBROOT/APPHOST' -fi 'system.applicationHost/log/centralW3CLogFile' -n 'truncateSize' -v 4294967295; `
    Set-WebConfigurationProperty -p 'MACHINE/WEBROOT/APPHOST' -fi 'system.applicationHost/log/centralW3CLogFile' -n 'period' -v 'MaxSize'; `
    Set-WebConfigurationProperty -p 'MACHINE/WEBROOT/APPHOST' -fi 'system.applicationHost/log/centralW3CLogFile' -n 'directory' -v 'c:\iislog'

RUN Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -n ServerPriorityTimeLimit -v 0 -t DWord 

ENV SA_PASSWORD="N3rdD!Nne720^6" `
    HOMEPAGE_URL="http://nerd-dinner-homepage"

WORKDIR C:\nerd-dinner
RUN Remove-Website -Name 'Default Web Site'; `
    New-Website -Name 'nerd-dinner' `
                -Port 80 -PhysicalPath 'c:\nerd-dinner' `
                -ApplicationPool '.NET v4.5'

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

COPY --from=builder C:\out\NerdDinner\_PublishedWebsites\NerdDinner C:\nerd-dinner