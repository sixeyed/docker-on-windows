# escape=`
FROM mcr.microsoft.com/dotnet/framework/sdk:4.7.2-windowsservercore-ltsc2019 AS builder

WORKDIR C:\src
COPY src\NerdDinner.Core\NerdDinner.Core.csproj .\NerdDinner.Core\
COPY src\NerdDinner.Messaging\NerdDinner.Messaging.csproj .\NerdDinner.Messaging\
COPY src\NerdDinner.Model\NerdDinner.Model.csproj .\NerdDinner.Model\
COPY src\NerdDinner.Model\packages.config .\NerdDinner.Model\
COPY src\NerdDinner.MessageHandlers.SaveDinner\NerdDinner.MessageHandlers.SaveDinner.csproj .\NerdDinner.MessageHandlers.SaveDinner\
COPY src\NerdDinner.MessageHandlers.SaveDinner\packages.config .\NerdDinner.MessageHandlers.SaveDinner\
COPY src\NerdDinner.sln .
RUN nuget restore 

COPY src\NerdDinner.Core .\NerdDinner.Core
COPY src\NerdDinner.Messaging .\NerdDinner.Messaging
COPY src\NerdDinner.Model .\NerdDinner.Model
COPY src\NerdDinner.MessageHandlers.SaveDinner .\NerdDinner.MessageHandlers.SaveDinner
RUN msbuild .\NerdDinner.MessageHandlers.SaveDinner\NerdDinner.MessageHandlers.SaveDinner.csproj /p:Configuration=Release /p:OutputPath=c:\save-handler

#save-handler
FROM mcr.microsoft.com/windows/servercore:ltsc2019

CMD ["NerdDinner.MessageHandlers.SaveDinner.exe"]

WORKDIR C:\save-handler
COPY --from=builder C:\save-handler\ .