# escape=`
FROM mcr.microsoft.com/dotnet/framework/sdk:4.7.2-windowsservercore-ltsc2019 AS builder

WORKDIR C:\src
COPY src .

RUN nuget restore
RUN msbuild .\NerdDinner\NerdDinner.csproj /p:Configuration=Release /p:OutputPath=c:\nerd-dinner-web; `
    msbuild .\NerdDinner.MessageHandlers.SaveDinner\NerdDinner.MessageHandlers.SaveDinner.csproj /p:Configuration=Release /p:OutputPath=c:\save-handler; `
    dotnet publish -c Release -o C:\index-handler .\NerdDinner.MessageHandlers.IndexDinner\NerdDinner.MessageHandlers.IndexDinner.csproj; `
    dotnet publish -c Release -o C:\dinner-api .\NerdDinner.DinnerApi\NerdDinner.DinnerApi.csproj
