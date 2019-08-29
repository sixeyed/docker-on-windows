#escape=`
FROM mcr.microsoft.com/windows/servercore:ltsc2019 as installer
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG GOGS_VERSION="0.11.86"

RUN Write-Host "Downloading: $($env:GOGS_VERSION)"; `
	Invoke-WebRequest -Uri "https://cdn.gogs.io/$($env:GOGS_VERSION)/gogs_$($env:GOGS_VERSION)_windows_amd64.zip" -OutFile 'gogs.zip';

RUN Write-Host 'Expanding ...'; `
	Expand-Archive gogs.zip -DestinationPath C:\;

# gogs
FROM sixeyed/chocolatey:windowsservercore-ltsc2019

ARG GOGS_VERSION="0.11.86"
ARG GOGS_PATH="C:\gogs"

ENV GOGS_VERSION=${GOGS_VERSION} `
    GOGS_PATH=${GOGS_PATH} `
    GIT_PATH="C:\git"
    
EXPOSE 3000
VOLUME C:\data C:\logs C:\repositories
CMD ["gogs", "web"]

RUN choco install -y git

WORKDIR ${GOGS_PATH}
COPY app.ini ./custom/conf/app.ini
COPY --from=installer ${GOGS_PATH} .