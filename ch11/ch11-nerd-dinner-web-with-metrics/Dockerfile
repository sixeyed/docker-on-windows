#escape=`
FROM dockeronwindows/ch10-nerd-dinner-web:2e

EXPOSE 50505
ENV COLLECTOR_CONFIG_PATH="w3svc-collectors.json" `
    HomePage:Enabled="false"

WORKDIR C:\aspnet-exporter
COPY --from=dockersamples/aspnet-monitoring-exporter:4.7.2-windowsservercore-ltsc2019 C:\aspnet-exporter .

ENTRYPOINT ["powershell"]
CMD Start-Service W3SVC; `    
    Invoke-WebRequest http://localhost -UseBasicParsing | Out-Null; `
    Start-Process -NoNewWindow C:\aspnet-exporter\aspnet-exporter.exe; `
    Start-Process -NoNewWindow -FilePath C:\ServiceMonitor.exe -ArgumentList w3svc; `
    netsh http flush logbuffer | Out-Null; `    
    Get-Content -path 'C:\iislog\W3SVC\u_extend1.log' -Tail 1 -Wait 