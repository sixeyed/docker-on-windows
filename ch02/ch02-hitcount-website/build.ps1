
dotnet restore dotnet\HitCountWebApp

dotnet publish dotnet\HitCountWebApp\ -o Docker\dotnetapp

docker build -t dockeronwindows/ch02-hitcount-website .\Docker