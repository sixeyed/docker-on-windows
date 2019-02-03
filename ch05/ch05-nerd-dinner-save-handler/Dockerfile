# escape=`
FROM mcr.microsoft.com/windows/servercore:ltsc2019

CMD ["NerdDinner.MessageHandlers.SaveDinner.exe"]

ENV APP_DB_CONNECTION_STRING="Data Source=nerd-dinner-db,1433;Initial Catalog=NerdDinner;User Id=sa;Password=N3rdD!Nne720^6;MultipleActiveResultSets=True;" `
    MESSAGE_QUEUE_URL="nats://message-queue:4222"

WORKDIR C:\save-handler
COPY --from=dockeronwindows/ch05-nerd-dinner-builder:2e C:\src\NerdDinner.MessageHandlers.SaveDinner\bin\Release\ .


#TODO - test handlers & build webn