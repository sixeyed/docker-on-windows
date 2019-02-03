# escape=`
FROM microsoft/dotnet:2.1-sdk-nanoserver-1809 AS builder

WORKDIR C:\src\NerdDinnerHomepage
COPY src\NerdDinnerHomepage\NerdDinnerHomepage.csproj .
RUN dotnet restore

COPY src\NerdDinnerHomepage .
RUN dotnet publish

# app image
FROM microsoft/dotnet:2.1-aspnetcore-runtime-nanoserver-1809

WORKDIR C:\dotnetapp
ENV NERD_DINNER_URL="/home/find"

CMD ["dotnet", "NerdDinnerHomepage.dll"]
COPY --from=builder C:\src\NerdDinnerHomepage\bin\Debug\netcoreapp2.1\publish .