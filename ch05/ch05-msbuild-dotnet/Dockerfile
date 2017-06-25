# escape=`

# For a mixed .NET Framework and .NET Core solution, you need to have MSBuild, NuGet and the .NET Core SDK installed.
# Track updates on that here - https://github.com/Microsoft/msbuild/issues/1697

# Source for MSBuild
FROM microsoft/windowsservercore:10.0.14393.1198 AS buildtools
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN Invoke-WebRequest -UseBasicParsing https://chocolatey.org/install.ps1 | Invoke-Expression; `
    choco install -y visualstudio2017buildtools --version 15.2.26430.20170605; `
    choco install -y nuget.commandline --version 4.1.0

# Source for .NET Core
FROM microsoft/dotnet:1.1.2-sdk-nanoserver AS dotnet

# Build agent image
FROM microsoft/windowsservercore:10.0.14393.1198
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV MSBUILD_PATH="C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin" `
    NUGET_PATH="C:\ProgramData\chocolatey\lib\NuGet.CommandLine\tools" `
    DOTNET_PATH="C:\Program Files\dotnet" 

COPY --from=dotnet ${DOTNET_PATH} ${DOTNET_PATH}
COPY --from=buildtools ${MSBUILD_PATH} ${MSBUILD_PATH}
COPY --from=buildtools ${NUGET_PATH} ${NUGET_PATH}

RUN $env:PATH = $env:MSBUILD_PATH + ';' + $env:NUGET_PATH + ';' + $env:DOTNET_PATH + ';' + $env:PATH; `
    [Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

RUN Install-PackageProvider -Name chocolatey -RequiredVersion 2.8.5.130 -Force; `
    Install-Package -Name netfx-4.5.2-devpack -RequiredVersion 4.5.5165101 -Force; `
    Install-Package -Name webdeploy -RequiredVersion 3.6.0 -Force; `
    & nuget install MSBuild.Microsoft.VisualStudio.Web.targets -Version 14.0.0.3

ENV MSBuildSDKsPath="C:\Program Files\dotnet\sdk\1.0.4\Sdks" `
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE="true"