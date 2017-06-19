#escape = `
FROM microsoft/aspnetcore:1.1.2-nanoserver-10.0.14393.1358
LABEL Name=webapi.netcore Version=0.0.1 

ARG source=.
WORKDIR C:\app
EXPOSE 5000

COPY $source .
ENTRYPOINT ["dotnet", "webapi.netcore.dll"]