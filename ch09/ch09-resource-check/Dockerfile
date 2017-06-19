# escape=`

# build agent
FROM sixeyed/msbuild:4.5.2-webdeploy AS builder

WORKDIR C:\src
COPY src C:\src

RUN msbuild .\DockerOnWindows.ResourceCheck.Console\DockerOnWindows.ResourceCheck.Console.csproj `
            /p:OutputPath=c:\out\resource-check

# app image
FROM microsoft/windowsservercore:10.0.14393.1198

WORKDIR /resource-check
ENTRYPOINT ["DockerOnWindows.ResourceCheck.Console.exe"]

COPY --from=builder C:\out\resource-check .