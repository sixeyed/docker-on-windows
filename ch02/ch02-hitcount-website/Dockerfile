# escape=`
FROM microsoft/dotnet:2.1-sdk-nanoserver-1809 AS builder

WORKDIR C:\src
COPY src .

USER ContainerAdministrator
RUN dotnet restore && `
    dotnet publish

# app image
FROM microsoft/dotnet:2.1-aspnetcore-runtime-nanoserver-1809

WORKDIR C:\dotnetapp
RUN mkdir app-state

CMD ["dotnet", "HitCountWebApp.dll"]
COPY --from=builder C:\src\bin\Debug\netcoreapp2.1\publish .