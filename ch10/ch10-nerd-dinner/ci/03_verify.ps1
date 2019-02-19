Write-Output '*** Verifying - containers: '
docker container ls --filter  "label=ci"

Write-Output '*** Sleeping'
Start-Sleep -Seconds 40

Write-Output '*** Checking website'
Invoke-WebRequest -UseBasicParsing http://nerd-dinner-test