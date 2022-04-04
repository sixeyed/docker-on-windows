# escape=`
FROM mcr.microsoft.com/dotnet/core/sdk:2.1-nanoserver-1809 AS builder

WORKDIR C:\src
COPY src\NerdDinner.Core\NerdDinner.Core.csproj .\NerdDinner.Core\
COPY src\NerdDinner.Messaging\NerdDinner.Messaging.csproj .\NerdDinner.Messaging\
COPY src\NerdDinner.MessageHandlers.IndexDinner\NerdDinner.MessageHandlers.IndexDinner.csproj .\NerdDinner.MessageHandlers.IndexDinner\
RUN dotnet restore .\NerdDinner.MessageHandlers.IndexDinner\NerdDinner.MessageHandlers.IndexDinner.csproj

COPY src\NerdDinner.Core .\NerdDinner.Core
COPY src\NerdDinner.Messaging .\NerdDinner.Messaging
COPY src\NerdDinner.MessageHandlers.IndexDinner .\NerdDinner.MessageHandlers.IndexDinner
RUN dotnet publish -c Release -o C:\index-handler .\NerdDinner.MessageHandlers.IndexDinner\NerdDinner.MessageHandlers.IndexDinner.csproj

# index-handler
FROM mcr.microsoft.com/dotnet/core/runtime:2.1-nanoserver-1809

CMD ["dotnet", "NerdDinner.MessageHandlers.IndexDinner.dll"]

WORKDIR /index-handler
COPY --from=builder C:\index-handler .