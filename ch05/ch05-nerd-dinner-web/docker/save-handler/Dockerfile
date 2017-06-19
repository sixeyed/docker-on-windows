# escape=`
FROM microsoft/windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Set-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord

ENV APP_DB_CONNECTION_STRING="Data Source=nerd-dinner-db,1433;Initial Catalog=NerdDinner;User Id=sa;Password=N3rdD!Nne720^6;MultipleActiveResultSets=True;" `
    MESSAGE_QUEUE_URL="nats://message-queue:4222"

WORKDIR /save-handler
COPY SaveDinner .

CMD .\NerdDinner.MessageHandlers.SaveDinner.exe