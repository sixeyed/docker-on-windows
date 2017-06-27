# escape=`
FROM microsoft/dotnet:1.1.2-sdk-nanoserver AS builder

WORKDIR C:\src\NerdDinnerHomepage
COPY src\NerdDinnerHomepage\NerdDinnerHomepage.csproj .
RUN dotnet restore

COPY src\NerdDinnerHomepage .
RUN dotnet publish

# app image
FROM microsoft/aspnetcore:1.1.2-nanoserver

WORKDIR C:\dotnetapp
ENV NERD_DINNER_URL="/home/find"

CMD ["dotnet", "NerdDinnerHomepage.dll"]
COPY --from=builder C:\src\NerdDinnerHomepage\bin\Debug\netcoreapp1.1\publish .