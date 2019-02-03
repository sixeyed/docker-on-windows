# escape=`
FROM microsoft/dotnet:2.1-runtime-nanoserver-1809
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Set-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord

ENV ELASTICSEARCH_URL="http://elasticsearch:9200" `
    MESSAGE_QUEUE_URL="nats://message-queue:4222"

CMD ["dotnet", "NerdDinner.MessageHandlers.IndexDinner.dll"]

WORKDIR /index-handler
COPY --from=dockeronwindows/ch05-nerd-dinner-builder:2e C:\src\NerdDinner.MessageHandlers.IndexDinner\bin\Release\netcoreapp2.1\ .