FROM microsoft/dotnet:1.1-sdk-nanoserver

WORKDIR /src
COPY src/ .

RUN dotnet restore; dotnet build
CMD ["dotnet", "run"]