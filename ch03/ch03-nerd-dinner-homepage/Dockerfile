# escape=`
FROM mcr.microsoft.com/dotnet/core/sdk:2.2-nanoserver-1809 AS builder

WORKDIR C:\src\NerdDinner.Homepage
COPY src\NerdDinner.Homepage\NerdDinner.Homepage.csproj .
RUN dotnet restore

COPY src\NerdDinner.Homepage .
RUN dotnet publish

# app image
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-nanoserver-1809

WORKDIR C:\dotnetapp
ENV NERD_DINNER_URL="/home/find"
EXPOSE 80

CMD ["dotnet", "NerdDinner.Homepage.dll"]
COPY --from=builder C:\src\NerdDinner.Homepage\bin\Debug\netcoreapp2.2\publish .