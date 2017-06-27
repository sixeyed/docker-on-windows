# escape=`
FROM dockeronwindows/ch07-msbuild-dotnet

WORKDIR C:\src
COPY src .

RUN dotnet restore; `
    nuget restore -msbuildpath $env:MSBUILD_PATH

RUN dotnet build .\NerdDinner.Messaging\NerdDinner.Messaging.csproj; `
    dotnet msbuild NerdDinner.sln; `
    dotnet publish .\NerdDinner.MessageHandlers.IndexDinner; `
    msbuild .\NerdDinner\NerdDinner.csproj `      
      /p:DeployOnBuild=true /p:OutputPath=c:\out\NerdDinner `
      /p:VSToolsPath=C:\MSBuild.Microsoft.VisualStudio.Web.targets.14.0.0.3\tools\VSToolsPath; `
    msbuild .\NerdDinner.Database\NerdDinner.Database.sqlproj `
      /p:SQLDBExtensionsRefPath="C:\Microsoft.Data.Tools.Msbuild.10.0.61026\lib\net40" `
      /p:SqlServerRedistPath="C:\Microsoft.Data.Tools.Msbuild.10.0.61026\lib\net40"
      