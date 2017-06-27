# escape=`
FROM dockeronwindows/ch07-nerd-dinner-builder AS builder

# db image
FROM microsoft/mssql-server-windows-express

ENV ACCEPT_EULA="Y" `
    DATA_PATH="C:\data"

VOLUME ${DATA_PATH}
WORKDIR C:\init

COPY Initialize-Database.ps1 .
CMD powershell ./Initialize-Database.ps1 -data_path $env:data_path -Verbose

COPY --from=builder C:\src\NerdDinner.Database\bin\Debug\NerdDinner.Database.dacpac .