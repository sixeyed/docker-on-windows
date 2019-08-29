# escape=`
FROM mcr.microsoft.com/windows/servercore:ltsc2019

CMD ["NerdDinner.MessageHandlers.SaveDinner.exe"]

WORKDIR C:\save-handler
COPY --from=dockeronwindows/ch05-nerd-dinner-builder:2e C:\save-handler\ .