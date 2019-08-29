# escape=`
FROM microsoft/dotnet-framework:4.7.2-sdk-windowsservercore-ltsc2019 AS builder

WORKDIR C:\src
COPY src\DockerOnWindows.ResourceCheck.sln .
COPY src\DockerOnWindows.ResourceCheck.Console\DockerOnWindows.ResourceCheck.Console.csproj .\DockerOnWindows.ResourceCheck.Console\
COPY src\DockerOnWindows.ResourceCheck.Console\packages.config .\DockerOnWindows.ResourceCheck.Console\
RUN nuget restore DockerOnWindows.ResourceCheck.sln

COPY src C:\src
RUN msbuild .\DockerOnWindows.ResourceCheck.Console\DockerOnWindows.ResourceCheck.Console.csproj `
            /p:OutputPath=c:\out\resource-check /p:Configuration=Release

# app image
FROM mcr.microsoft.com/windows/servercore:ltsc2019

WORKDIR /resource-check
ENTRYPOINT ["DockerOnWindows.ResourceCheck.Console.exe"]

COPY --from=builder C:\out\resource-check .