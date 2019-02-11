# escape=`
FROM microsoft/dotnet:2.1-aspnetcore-runtime-nanoserver-1809

EXPOSE 80
WORKDIR /dinner-api
ENTRYPOINT ["dotnet", "NerdDinner.DinnerApi.dll"]

COPY --from=dockeronwindows/ch05-nerd-dinner-builder:2e C:\dinner-api .