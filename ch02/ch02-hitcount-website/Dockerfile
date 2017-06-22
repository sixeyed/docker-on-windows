# escape=`
FROM microsoft/dotnet:1.1.2-sdk-nanoserver AS builder

WORKDIR C:\src
COPY src .

RUN dotnet restore; `
    dotnet publish

# app image
FROM microsoft/aspnetcore:1.1.2-nanoserver

WORKDIR C:\dotnetapp
RUN New-Item -Type Directory -Path .\app-state

CMD ["dotnet", "HitCountWebApp.dll"]
COPY --from=builder C:\src\bin\Debug\netcoreapp1.1\publish .