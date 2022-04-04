# escape=`
FROM mcr.microsoft.com/dotnet/framework/sdk:4.7.2-windowsservercore-ltsc2019 AS builder

WORKDIR C:\src\ApiWithMetrics
COPY src\ApiWithMetrics\packages.config .
RUN nuget restore packages.config -PackagesDirectory ..\packages

COPY src C:\src
RUN msbuild ApiWithMetrics.csproj /p:Configuration=Release /p:OutputPath=c:\api

# app image
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.7.2-windowsservercore-ltsc2019
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Remove-Website -Name 'Default Web Site';`
    New-Item -Path 'C:\web-app' -Type Directory; `
    New-Website -Name 'web-app' -Port 80 -PhysicalPath 'C:\web-app'

EXPOSE 50505

# add permissions for ASP.NET to listen on metrics endpoint, and access perf counters:
RUN netsh http add urlacl url=http://+:50505/metrics user=BUILTIN\IIS_IUSRS; `
    net localgroup 'Performance Monitor Users' 'IIS APPPOOL\DefaultAppPool' /add

COPY --from=builder C:\api\_PublishedWebsites\ApiWithMetrics C:\web-app