# escape=`
FROM dockeronwindows/ch05-msbuild-dotnet
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# add SSDT
RUN & nuget install Microsoft.Data.Tools.Msbuild -Version 10.0.61026