# escape=`
FROM microsoft/dotnet:2.2-sdk-nanoserver-1809 AS builder

WORKDIR C:\src\NerdDinner.Homepage
COPY src\NerdDinner.Homepage\NerdDinner.Homepage.csproj .
RUN dotnet restore

COPY src\NerdDinner.Homepage .
RUN dotnet publish

# app image
FROM microsoft/dotnet:2.2-aspnetcore-runtime-nanoserver-1809

WORKDIR C:\dotnetapp
ENV NERD_DINNER_URL="/home/find"
EXPOSE 80
HEALTHCHECK CMD curl --fail http://localhost || exit 1  

CMD ["dotnet", "NerdDinner.Homepage.dll"]
COPY --from=builder C:\src\NerdDinner.Homepage\bin\Debug\netcoreapp2.2\publish .