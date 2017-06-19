# escape=`

FROM microsoft/windowsservercore
SHELL ["powershell", "-command"]

RUN Install-WindowsFeature Web-Server
RUN Install-WindowsFeature NET-Framework-45-ASPNET
RUN Install-WindowsFeature Web-Asp-Net45

COPY nerd-dinner c:\nerd-dinner

RUN Remove-Website -Name 'Default Web Site'
RUN New-Website -Name 'nerd-dinner' `
                -Port 8081 -PhysicalPath 'c:\nerd-dinner' `
                -ApplicationPool '.NET v4.5'

ENV BING_MAPS_KEY bing_maps_key

RUN & c:\windows\system32\inetsrv\appcmd.exe `
      unlock config `
      /section:system.webServer/handlers

# sql localdb http://download.microsoft.com/download/8/D/D/8DD7BDBA-CEF7-4D8E-8C16-D9F69527F909/ENU/x64/SqlLocalDB.MSI

# final rUN:


