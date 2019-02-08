# escape=`
FROM microsoft/dotnet:2.1-runtime-nanoserver-1809

CMD ["dotnet", "NerdDinner.MessageHandlers.IndexDinner.dll"]

WORKDIR /index-handler
COPY --from=dockeronwindows/ch05-nerd-dinner-builder:2e C:\src\NerdDinner.MessageHandlers.IndexDinner\obj\Release\netcoreapp2.1\ .