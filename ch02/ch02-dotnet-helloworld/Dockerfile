FROM mcr.microsoft.com/dotnet/core/sdk:2.2-nanoserver-1809

WORKDIR /src
COPY src/ .

USER ContainerAdministrator
RUN dotnet restore && dotnet build
CMD ["dotnet", "run"]