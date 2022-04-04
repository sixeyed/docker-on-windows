# escape=`
FROM mcr.microsoft.com/dotnet/core/aspnet:2.1-nanoserver-1809

EXPOSE 80
WORKDIR /dinner-api
ENTRYPOINT ["dotnet", "NerdDinner.DinnerApi.dll"]
USER ContainerAdministrator

COPY --from=dockeronwindows/ch05-nerd-dinner-builder:2e C:\dinner-api .