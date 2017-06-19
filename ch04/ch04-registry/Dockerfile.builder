# escape=`
FROM dockeronwindows/ch04-golang 
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

CMD .\go get github.com/docker/distribution/cmd/registry; `
    cp \"$env:GOPATH\bin\registry.exe\" c:\out\; `
    cp \"$env:GOPATH\src\github.com\docker\distribution\cmd\registry\config-example.yml\" c:\out\config.yml