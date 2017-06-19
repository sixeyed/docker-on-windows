# escape=`
FROM microsoft/iis:windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# add a dummy website
RUN New-Item -Path 'C:\website2' -Type Directory -Force; `
    New-Website -Name 'Website2' -PhysicalPath 'C:\website2' -Port 8080 -Force;

# 8172 used for remote IIS management
EXPOSE 8172

COPY * /