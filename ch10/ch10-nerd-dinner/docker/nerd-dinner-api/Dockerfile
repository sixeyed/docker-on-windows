# escape=`
FROM microsoft/dotnet:2.1-sdk-nanoserver-1809 AS builder

WORKDIR C:\src
COPY src\NerdDinner.Core\NerdDinner.Core.csproj .\NerdDinner.Core\
COPY src\NerdDinner.DinnerApi\NerdDinner.DinnerApi.csproj .\NerdDinner.DinnerApi\
RUN dotnet restore .\NerdDinner.DinnerApi\NerdDinner.DinnerApi.csproj

COPY src\NerdDinner.Core .\NerdDinner.Core
COPY src\NerdDinner.DinnerApi .\NerdDinner.DinnerApi
RUN dotnet publish -c Release -o C:\dinner-api .\NerdDinner.DinnerApi\NerdDinner.DinnerApi.csproj

# api
FROM microsoft/dotnet:2.1-aspnetcore-runtime-nanoserver-1809

EXPOSE 80
WORKDIR /dinner-api
ENTRYPOINT ["dotnet", "NerdDinner.DinnerApi.dll"]
USER ContainerAdministrator

COPY --from=builder C:\dinner-api .