#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see https://aka.ms/containercompat

FROM microsoft/dotnet:2.2-aspnetcore-runtime-nanoserver-1809 AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.2-sdk-nanoserver-1809 AS build
ARG CONFIGURATION=Release
WORKDIR /src
COPY ["WebApi.NetCore.csproj", "./"]
RUN dotnet restore "./WebApi.NetCore.csproj"
COPY . .

#WORKDIR "/src/."
RUN echo Building %CONFIGURATION% && \
    dotnet build "WebApi.NetCore.csproj" -c %CONFIGURATION% -o /build

RUN echo Publishing %CONFIGURATION% && \
    dotnet publish "WebApi.NetCore.csproj" -c %CONFIGURATION% -o /publish

FROM base AS final
WORKDIR /app
COPY --from=build /publish .
ENTRYPOINT ["dotnet", "WebApi.NetCore.dll"]
USER ContainerAdministrator
