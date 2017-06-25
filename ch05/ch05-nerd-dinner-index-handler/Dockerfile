# escape=`
FROM dockeronwindows/ch05-nerd-dinner-builder AS builder

# app image
FROM microsoft/dotnet:1.1.2-runtime-nanoserver
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Set-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord

ENV ELASTICSEARCH_URL="http://elasticsearch:9200" `
    MESSAGE_QUEUE_URL="nats://message-queue:4222"

CMD ["dotnet", "NerdDinner.MessageHandlers.IndexDinner.dll"]

WORKDIR /index-handler
COPY --from=builder C:\src\NerdDinner.MessageHandlers.IndexDinner\bin\Debug\netcoreapp1.1\publish\ .