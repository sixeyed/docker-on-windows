# build stage
FROM microsoft/dotnet:1.1-sdk-nanoserver AS builder

WORKDIR /src
COPY src/ .

RUN dotnet restore; dotnet publish

# final image stage
FROM microsoft/dotnet:1.1-runtime-nanoserver

WORKDIR /dotnetapp
COPY --from=builder /src/bin/Debug/netcoreapp1.1/publish .

CMD ["dotnet", "HelloWorld.NetCore.dll"]