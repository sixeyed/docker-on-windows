# escape=`
FROM dockersamples/aspnet-monitoring-grafana:5.2.1-windowsservercore-ltsc2019
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

COPY datasource-prometheus.yaml \grafana\conf\provisioning\datasources\
COPY dashboard-provider.yaml \grafana\conf\provisioning\dashboards\
COPY dashboard.json \var\lib\grafana\dashboards\

COPY init.ps1 .
RUN .\init.ps1 