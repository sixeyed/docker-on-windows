Write-Output '*** Running end-to-end tests'
cd .\ch10\ch10-nerd-dinner
docker image build -t dockeronwindows/ch10-nerd-dinner-e2e-tests:2e -f .\docker\nerd-dinner-e2e-tests\Dockerfile .
$e2eId = docker container run -d dockeronwindows/ch10-nerd-dinner-e2e-tests:2e

Start-Sleep -Seconds 10

docker container cp "$($e2eId):C:\e2e-tests\TestResult.xml" .
docker container rm $e2eId

$testResult = [xml] (Get-Content .\TestResult.xml)
$results= $testResult.SelectNodes('./test-run/test-suite')

Write-Output '*** E2E test results:' 
$results

$result = $results.result
Write-Output "*** Overall: $result"

docker rm -f $(docker container ls --filter "label=ci" -q)

if ($result -eq 'Failed') { exit 1 }