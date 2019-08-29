FROM microsoft/dotnet:2.2-sdk-nanoserver-1809

WORKDIR /src
COPY src/ .

USER ContainerAdministrator
RUN dotnet restore && dotnet build
CMD ["dotnet", "run"]