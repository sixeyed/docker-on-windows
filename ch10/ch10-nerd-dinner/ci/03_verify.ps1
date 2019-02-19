Write-Output '*** Containers: '
docker container ls --filter  "label=ci"

Write-Output '*** Sleeping'
Start-Sleep -Seconds 30

Write-Output '*** Checking website'
$ip = docker container inspect --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' nerddinner.test
Invoke-WebRequest -UseBasicParsing "http://$ip"