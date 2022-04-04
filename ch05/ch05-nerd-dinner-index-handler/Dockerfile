# escape=`
FROM mcr.microsoft.com/dotnet/core/runtime:2.1-nanoserver-1809

CMD ["dotnet", "NerdDinner.MessageHandlers.IndexDinner.dll"]

WORKDIR /index-handler
COPY --from=dockeronwindows/ch05-nerd-dinner-builder:2e C:\index-handler .