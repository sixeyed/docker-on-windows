FROM microsoft/dotnet:2.1-sdk-nanoserver-1809

WORKDIR /src
COPY src/ .

RUN dotnet restore && dotnet build
CMD ["dotnet", "run"]