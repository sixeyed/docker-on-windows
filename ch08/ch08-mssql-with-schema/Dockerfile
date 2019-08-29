# escape=`
FROM dockeronwindows/ch03-sql-server:2e
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV sa_password DockerOnW!nd0ws
VOLUME C:\mssql

WORKDIR C:\init
COPY . .

CMD ./InitializeDatabase.ps1 -sa_password $env:sa_password -Verbose

HEALTHCHECK CMD powershell -command `
    try { `
     $result = invoke-sqlcmd -Query 'SELECT TOP 1 1 FROM Authors' -Database DockerOnWindows; `
     if ($result[0] -eq 1) { return 0} `
     else {return 1}; `
} catch { return 1 }