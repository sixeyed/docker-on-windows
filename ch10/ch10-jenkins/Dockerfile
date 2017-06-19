# escape=`
FROM dockeronwindows/ch10-git AS git
FROM dockeronwindows/ch10-docker AS docker

FROM dockeronwindows/ch10-jenkins-base
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN New-Item -Type Directory 'C:\git'; `
	$env:PATH = 'C:\git\cmd;C:\git\mingw64\bin;C:\git\usr\bin;' + $env:PATH; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

COPY --from=git C:\git C:\git

RUN New-Item -Type Directory 'C:\docker'; `
	$env:PATH = 'C:\docker;' + $env:PATH; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

COPY --from=docker C:\docker\docker.exe C:\docker
COPY --from=docker C:\docker\docker-compose.exe C:\docker