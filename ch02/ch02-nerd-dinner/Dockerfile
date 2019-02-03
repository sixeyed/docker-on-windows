# escape=`
FROM microsoft/dotnet-framework:4.7.2-sdk-windowsservercore-ltsc2019 AS builder

WORKDIR C:\src\NerdDinner
COPY src\NerdDinner\packages.config .
RUN nuget restore packages.config -PackagesDirectory ..\packages

COPY src C:\src
RUN msbuild NerdDinner.csproj /p:OutputPath=c:\out /p:Configuration=Release

# app image
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.7.2-windowsservercore-ltsc2019
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV BING_MAPS_KEY bing_maps_key
WORKDIR C:\nerd-dinner

RUN Remove-Website -Name 'Default Web Site'; `
    New-Website -Name 'nerd-dinner' `
                -Port 80 -PhysicalPath 'c:\nerd-dinner' `
                -ApplicationPool '.NET v4.5'

RUN & c:\windows\system32\inetsrv\appcmd.exe `
      unlock config `
      /section:system.webServer/handlers

COPY --from=builder C:\out\_PublishedWebsites\NerdDinner C:\nerd-dinner