
$e2eId = docker container run -d dockeronwindows/ch10-nerd-dinner-e2e-tests:2e
docker container cp "$($e2eId):C:\e2e-tests\TestResult.xml" .
docker container rm $e2eId

$testResult = [xml] (Get-Content .\TestResult.xml)
$results= $testResult.SelectNodes('./test-run/test-suite')

Write-Output '"*** E2E test results:' 
$results

$result = $results.result
Write-Output "*** Overall: $result"

if ($result -eq 'Failed') { exit 1 }