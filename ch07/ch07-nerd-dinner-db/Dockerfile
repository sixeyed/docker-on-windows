# escape=`
FROM dockeronwindows/ch03-sql-server:2e

ENV DATA_PATH="C:\data" `
    sa_password="N3rdD!Nne720^6" `
    sa_password_path="C:\secrets\sa-password"

VOLUME ${DATA_PATH}
WORKDIR C:\init

COPY Initialize-Database.ps1 .
CMD powershell ./Initialize-Database.ps1 -sa_password $env:sa_password -data_path $env:data_path -sa_password_path $env:sa_password_path -Verbose

COPY --from=dockeronwindows/ch06-nerd-dinner-db:2e ["C:\\Program Files\\Microsoft SQL Server\\140\\DAC", "C:\\Program Files\\Microsoft SQL Server\\140\\DAC"]
COPY --from=dockeronwindows/ch06-nerd-dinner-db:2e C:\init\NerdDinner.Database.dacpac .
