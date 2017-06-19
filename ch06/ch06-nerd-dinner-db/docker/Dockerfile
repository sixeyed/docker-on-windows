FROM microsoft/mssql-server-windows-express
MAINTAINER Elton Stoneman <elton@sixeyed.com>
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

EXPOSE 1433
VOLUME c:\\database
ENV sa_password N3rdD!Nne720^6

WORKDIR c:\\init
COPY . .

CMD ./Initialize-Database.ps1 -sa_password $env:sa_password -db_name NerdDinner -Verbose