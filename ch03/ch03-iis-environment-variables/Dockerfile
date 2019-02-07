# escape=`
FROM mcr.microsoft.com/dotnet/framework/aspnet
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# configure IIS to write a global log file:
RUN Set-WebConfigurationProperty -p 'MACHINE/WEBROOT/APPHOST' -fi 'system.applicationHost/log' -n 'centralLogFileMode' -v 'CentralW3C'; `
    Set-WebConfigurationProperty -p 'MACHINE/WEBROOT/APPHOST' -fi 'system.applicationHost/log/centralW3CLogFile' -n 'truncateSize' -v 4294967295; `
    Set-WebConfigurationProperty -p 'MACHINE/WEBROOT/APPHOST' -fi 'system.applicationHost/log/centralW3CLogFile' -n 'period' -v 'MaxSize'; `
    Set-WebConfigurationProperty -p 'MACHINE/WEBROOT/APPHOST' -fi 'system.applicationHost/log/centralW3CLogFile' -n 'directory' -v 'c:\iislog'

ENV A01_KEY A01 value
ENV A02_KEY="A02 value" `
    A03_KEY="A03 value"

ENTRYPOINT ["powershell"]
CMD Start-Process -NoNewWindow -FilePath C:\ServiceMonitor.exe -ArgumentList w3svc; `
    Invoke-WebRequest http://localhost -UseBasicParsing | Out-Null; `
    netsh http flush logbuffer | Out-Null; `
    Get-Content -path 'C:\iislog\W3SVC\u_extend1.log' -Tail 1 -Wait 

COPY default.aspx C:\inetpub\wwwroot