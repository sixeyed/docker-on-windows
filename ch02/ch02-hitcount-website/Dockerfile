# escape=`
FROM mcr.microsoft.com/dotnet/core/sdk:2.2-nanoserver-1809 AS builder

WORKDIR C:\src
COPY src .

USER ContainerAdministrator
RUN dotnet restore && dotnet publish

# app image
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-nanoserver-1809

EXPOSE 80
WORKDIR C:\dotnetapp
RUN mkdir app-state

CMD ["dotnet", "HitCountWebApp.dll"]
COPY --from=builder C:\src\bin\Debug\netcoreapp2.2\publish .