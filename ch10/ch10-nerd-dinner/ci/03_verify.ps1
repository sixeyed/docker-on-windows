Write-Output '*** Containers: '
docker container ls --filter  "label=ci"

Write-Output '*** Sleeping'
Start-Sleep -Seconds 40

Write-Output '*** Checking website'
$ip = docker container inspect --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' nerd-dinner-test
Invoke-WebRequest -UseBasicParsing "http://$ip"