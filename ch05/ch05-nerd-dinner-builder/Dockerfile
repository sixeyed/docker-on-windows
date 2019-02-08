# escape=`
FROM microsoft/dotnet-framework:4.7.2-sdk-windowsservercore-ltsc2019 AS builder

WORKDIR C:\src
COPY src .

RUN nuget restore
RUN msbuild NerdDinner.sln /p:Configuration=Release /p:OutputPath=c:\out