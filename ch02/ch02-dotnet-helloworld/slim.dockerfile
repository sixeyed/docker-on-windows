FROM microsoft/dotnet:nanoserver-core

COPY bin/ /dotnetapp/

WORKDIR /dotnetapp

CMD ["dotnet", "HelloWorld.dll"]
