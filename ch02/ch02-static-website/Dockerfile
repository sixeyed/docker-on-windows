FROM microsoft/iis

ARG ENV_NAME=DEV

EXPOSE 80

VOLUME c:\\inetpub\\logs

COPY template.html c:\\template.html

RUN ["powershell", "(Get-Content -Raw -Path .\\template.html)", \
                   " -replace '{hostname}', [Environment]::MachineName", \
                   " -replace '{environment}', [Environment]::GetEnvironmentVariable('ENV_NAME')", \
                   " | Set-Content -Path c:\\inetpub\\wwwroot\\index.html"]

CMD ping -t localhost