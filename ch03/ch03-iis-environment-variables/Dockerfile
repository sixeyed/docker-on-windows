# escape=`
FROM microsoft/windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

RUN Install-WindowsFeature Web-Server, NET-Framework-45-ASPNET, Web-Asp-Net45

# configure IIS to write a global log file:
RUN Set-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter 'system.applicationHost/log' -name 'centralLogFileMode' -value 'CentralW3C'; `
    Set-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter 'system.applicationHost/log/centralW3CLogFile' -name 'truncateSize' -value 4294967295; `
    Set-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter 'system.applicationHost/log/centralW3CLogFile' -name 'period' -value 'MaxSize'; `
    Set-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter 'system.applicationHost/log/centralW3CLogFile' -name 'directory' -value 'c:\iislog'

RUN Remove-Website -Name 'Default Web Site';`
    mkdir 'c:\iis-env'; `
    New-Website -Name 'iis-env' -Port 8088 -PhysicalPath 'c:\iis-env'

EXPOSE 8088
ENV A01_KEY A01 value
ENV A02_KEY="A02 value" A03_KEY="A03 value"

COPY default.aspx /iis-env/
COPY bootstrap.ps1 /

CMD /bootstrap.ps1