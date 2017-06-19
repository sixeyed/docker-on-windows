# escape=`
FROM sixeyed/msbuild:netfx-4.5.2-webdeploy-10.0.14393.1198 AS builder

WORKDIR C:\src\ApiWithMetrics
COPY src\ApiWithMetrics\packages.config .
RUN nuget restore packages.config -PackagesDirectory ..\packages

COPY src C:\src
RUN msbuild ApiWithMetrics.csproj /p:OutputPath=c:\out\web\ApiWithMetrics `
        /p:DeployOnBuild=true /p:VSToolsPath=C:\MSBuild.Microsoft.VisualStudio.Web.targets.14.0.0.3\tools\VSToolsPath

# app image
FROM microsoft/aspnet:windowsservercore-10.0.14393.1198
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Remove-Website -Name 'Default Web Site';`
    New-Item -Path 'C:\web-app' -Type Directory; `
    New-Website -Name 'web-app' -Port 80 -PhysicalPath 'C:\web-app'

EXPOSE 50505

# add permissions for ASP.NET to listen on metrics endpoint, and access perf counters:
RUN netsh http add urlacl url=http://+:50505/metrics user=BUILTIN\IIS_IUSRS; `
    net localgroup 'Performance Monitor Users' 'IIS APPPOOL\DefaultAppPool' /add

COPY --from=builder C:\out\web\ApiWithMetrics\_PublishedWebsites\ApiWithMetrics C:\web-app