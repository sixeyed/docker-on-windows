# escape=`
FROM microsoft/dotnet-framework:4.7.2-sdk-windowsservercore-ltsc2019 AS builder

WORKDIR C:\src
COPY src\Healthcheck.WebApi.sln .
COPY src\Healthcheck.WebApi\Healthcheck.WebApi.csproj .\Healthcheck.WebApi\
COPY src\Healthcheck.WebApi\packages.config .\Healthcheck.WebApi\
RUN nuget restore Healthcheck.WebApi.sln

COPY src C:\src
RUN msbuild Healthcheck.WebApi\Healthcheck.WebApi.csproj /p:OutputPath=c:\out /p:Configuration=Release

# app image
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.7.2-windowsservercore-ltsc2019
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# configure IIS to write a global log file:
RUN Set-WebConfigurationProperty -p 'MACHINE/WEBROOT/APPHOST' -fi 'system.applicationHost/log' -n 'centralLogFileMode' -v 'CentralW3C'; `
    Set-WebConfigurationProperty -p 'MACHINE/WEBROOT/APPHOST' -fi 'system.applicationHost/log/centralW3CLogFile' -n 'truncateSize' -v 4294967295; `
    Set-WebConfigurationProperty -p 'MACHINE/WEBROOT/APPHOST' -fi 'system.applicationHost/log/centralW3CLogFile' -n 'period' -v 'MaxSize'; `
    Set-WebConfigurationProperty -p 'MACHINE/WEBROOT/APPHOST' -fi 'system.applicationHost/log/centralW3CLogFile' -n 'directory' -v 'c:\iislog'

WORKDIR C:\healthcheck-api
RUN Remove-Website -Name 'Default Web Site';`
    New-Website -Name 'healthcheck-api' -PhysicalPath 'C:\healthcheck-api'

ENV APP_ENVIRONMENT="dev"

HEALTHCHECK --interval=5s `
 CMD powershell -command `
    try { `
     $response = iwr http://localhost/diagnostics -UseBasicParsing; `
     if ($response.StatusCode -eq 200) { return 0} `
     else {return 1}; `
    } catch { return 1 }

COPY bootstrap.ps1 C:\
ENTRYPOINT ["powershell", "C:\\bootstrap.ps1"]

COPY --from=builder C:\out\_PublishedWebsites\Healthcheck.WebApi c:\healthcheck-api