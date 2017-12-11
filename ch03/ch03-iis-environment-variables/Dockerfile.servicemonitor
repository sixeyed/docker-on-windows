# escape=`
FROM microsoft/aspnet:4.6.2-windowsservercore-10.0.14393.1884
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

WORKDIR C:\iis-env
RUN Remove-Website -Name 'Default Web Site';`
    New-Website -Name 'iis-env' -Port 80 -PhysicalPath 'C:\iis-env'

ENV A01_KEY A01 value
ENV A02_KEY="A02 value" `
    A03_KEY="A03 value"

COPY default.aspx .