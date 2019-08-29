#escape=`
FROM mcr.microsoft.com/windows/servercore:ltsc2019
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG DOWNLOAD_URL="https://go.microsoft.com/fwlink/?linkid=829176"

ENV sa_password="_" `
    sa_password_path="C:\ProgramData\Docker\secrets\sa-password"

RUN Invoke-WebRequest -Uri $env:DOWNLOAD_URL -OutFile sqlexpress.exe; `
    Start-Process -Wait -FilePath .\sqlexpress.exe -ArgumentList /qs, /x:setup ; `
    .\setup\setup.exe /q /ACTION=Install /INSTANCENAME=SQLEXPRESS /FEATURES=SQLEngine /UPDATEENABLED=0 /SQLSVCACCOUNT='NT AUTHORITY\System' /SQLSYSADMINACCOUNTS='BUILTIN\ADMINISTRATORS' /TCPENABLED=1 /NPENABLED=0 /IACCEPTSQLSERVERLICENSETERMS ; `
    Remove-Item -Recurse -Force sqlexpress.exe, setup

RUN Stop-Service MSSQL`$SQLEXPRESS ; `
    Set-ItemProperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql14.SQLEXPRESS\mssqlserver\supersocketnetlib\tcp\ipall' -name tcpdynamicports -value '' ; `
    Set-ItemProperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql14.SQLEXPRESS\mssqlserver\supersocketnetlib\tcp\ipall' -name tcpport -value 1433 ; `
    Set-ItemProperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql14.SQLEXPRESS\mssqlserver\' -name LoginMode -value 2 ;

COPY start.ps1 /
CMD .\start.ps1 -Verbose