# escape=`
FROM dockeronwindows/ch05-nerd-dinner-builder AS builder

# app image
FROM microsoft/windowsservercore:10.0.14393.1198
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Set-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord

CMD ["NerdDinner.MessageHandlers.SaveDinner.exe"]

ENV APP_DB_CONNECTION_STRING="Data Source=nerd-dinner-db,1433;Initial Catalog=NerdDinner;User Id=sa;Password=N3rdD!Nne720^6;MultipleActiveResultSets=True;" `
    MESSAGE_QUEUE_URL="nats://message-queue:4222"

WORKDIR C:\save-handler
COPY --from=builder C:\src\NerdDinner.MessageHandlers.SaveDinner\bin\Debug\ .