# build stage
FROM microsoft/dotnet:2.2-sdk-nanoserver-1809 AS builder

WORKDIR /src
COPY src/ .

USER ContainerAdministrator
RUN dotnet restore && dotnet publish

# final image stage
FROM microsoft/dotnet:2.2-runtime-nanoserver-1809

WORKDIR /dotnetapp
COPY --from=builder /src/bin/Debug/netcoreapp2.2/publish .

CMD ["dotnet", "HelloWorld.NetCore.dll"]