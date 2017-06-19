FROM microsoft/dotnet:nanoserver

COPY dotnetapp c:\\dotnetapp

EXPOSE 5000

WORKDIR c:\\dotnetapp

CMD ["dotnet", "HitCountWebApp.dll", "--server.urls", "http://0.0.0.0:5000"]