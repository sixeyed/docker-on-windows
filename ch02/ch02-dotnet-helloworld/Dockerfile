FROM microsoft/dotnet:nanoserver

COPY src/ /src/

WORKDIR /src
RUN dotnet restore
RUN dotnet build

CMD ["dotnet", "run"]