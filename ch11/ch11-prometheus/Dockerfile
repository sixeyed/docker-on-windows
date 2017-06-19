# escape=`
FROM dockeronwindows/ch11-7zip AS installer
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV PROMETHEUS_VERSION 1.7.0

RUN Invoke-WebRequest "https://github.com/prometheus/prometheus/releases/download/v$($env:PROMETHEUS_VERSION)/prometheus-$($env:PROMETHEUS_VERSION).windows-amd64.tar.gz" -OutFile 'prometheus.tar.gz' -UseBasicParsing; `
    & 'C:\Program Files\7-Zip\7z.exe' x prometheus.tar.gz; `
    & 'C:\Program Files\7-Zip\7z.exe' x prometheus.tar; `
    Rename-Item -Path "C:\prometheus-$($env:PROMETHEUS_VERSION).windows-amd64" -NewName 'C:\prometheus'

# Prometheus
FROM microsoft/nanoserver:10.0.14393.1198

COPY --from=installer /prometheus/prometheus.exe      /bin/prometheus.exe
COPY --from=installer /prometheus/promtool.exe        /bin/promtool.exe
COPY --from=installer /prometheus/prometheus.yml      /etc/prometheus/prometheus.yml
COPY --from=installer /prometheus/console_libraries/  /etc/prometheus/
COPY --from=installer /prometheus/consoles/           /etc/prometheus/

EXPOSE     9090
VOLUME     C:\prometheus

ENTRYPOINT ["C:\\bin\\prometheus.exe", `
            "-storage.local.path=/prometheus", `
            "-web.console.libraries=/etc/prometheus/console_libraries", `
            "-web.console.templates=/etc/prometheus/consoles" ]

CMD ["-config.file=/etc/prometheus/prometheus.yml"]