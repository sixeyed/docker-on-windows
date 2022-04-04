# escape=`
FROM mcr.microsoft.com/dotnet/framework/sdk:4.7.2-windowsservercore-ltsc2019 AS builder
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# add SSDT build tools
RUN nuget install Microsoft.Data.Tools.Msbuild -Version 10.0.61804.210

# add SqlPackage tool
ENV download_url="https://download.microsoft.com/download/6/E/4/6E406E38-0A01-4DD1-B85E-6CA7CF79C8F7/EN/x64/DacFramework.msi"
RUN Invoke-WebRequest -Uri $env:download_url -OutFile DacFramework.msi ; `
    Start-Process msiexec.exe -ArgumentList '/i', 'DacFramework.msi', '/quiet', '/norestart' -NoNewWindow -Wait; `
    Remove-Item -Force DacFramework.msi

WORKDIR C:\src\NerdDinner.Database
COPY src\NerdDinner.Database .
RUN msbuild NerdDinner.Database.sqlproj `
    /p:SQLDBExtensionsRefPath="C:\Microsoft.Data.Tools.Msbuild.10.0.61804.210\lib\net46" `
    /p:SqlServerRedistPath="C:\Microsoft.Data.Tools.Msbuild.10.0.61804.210\lib\net46"

# db image
FROM dockeronwindows/ch03-sql-server:2e

ENV DATA_PATH="C:\data" `
    sa_password="N3rdD!Nne720^6" `
    sa_password_path="C:\secrets\sa-password"

VOLUME ${DATA_PATH}
WORKDIR C:\init

COPY ./docker/nerd-dinner-db/Initialize-Database.ps1 .
CMD powershell ./Initialize-Database.ps1 -sa_password $env:sa_password -data_path $env:data_path -sa_password_path $env:sa_password_path -Verbose

COPY --from=builder ["C:\\Program Files\\Microsoft SQL Server\\140\\DAC", "C:\\Program Files\\Microsoft SQL Server\\140\\DAC"]
COPY --from=builder C:\src\NerdDinner.Database\bin\Debug\NerdDinner.Database.dacpac .
