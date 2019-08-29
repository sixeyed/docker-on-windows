# escape=`
FROM microsoft/dotnet-framework:4.7.2-sdk-windowsservercore-ltsc2019 AS builder

WORKDIR C:\src\NerdDinner.EndToEndTests
COPY src\NerdDinner.EndToEndTests\packages.config .
RUN nuget restore packages.config -PackagesDirectory ..\packages

COPY src\NerdDinner.EndToEndTests\ .
RUN msbuild NerdDinner.EndToEndTests.csproj /p:OutputPath=C:\e2e-tests

# test runner
FROM sixeyed/nunit:3.9.0-windowsservercore-ltsc2019

WORKDIR /e2e-tests
CMD nunit3-console NerdDinner.EndToEndTests.dll

COPY --from=builder C:\e2e-tests .