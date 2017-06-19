# escape=`
FROM sixeyed/msbuild:netfx-4.5.2-10.0.14393.1198 AS builder

WORKDIR C:\src
COPY src\packages.config .
RUN nuget restore packages.config -PackagesDirectory .\packages

COPY src C:\src
RUN msbuild DotNetExporter.Console.csproj /p:OutputPath=c:\out\dotnet-exporter

# app image
FROM dockeronwindows/ch10-bonobo

EXPOSE 50505
ENV METRICS_TARGETS="w3wp"

WORKDIR C:\prometheus-exporter
COPY --from=builder C:\out\dotnet-exporter .

COPY bootstrap.ps1 /
ENTRYPOINT ["powershell", "C:\\bootstrap.ps1"]