docker image build -t dockeronwindows/ch02-volumes:2e ./ch02-volumes

docker image build -t dockeronwindows/ch02-static-website:2e ./ch02-static-website

docker image build -t dockeronwindows/ch02-powershell-env:2e ./ch02-powershell-env

docker image build -t dockeronwindows/ch02-nerd-dinner:2e ./ch02-nerd-dinner

docker image build -t dockeronwindows/ch02-hitcount-website:2e ./ch02-hitcount-website

docker image build -t dockeronwindows/ch02-fs-1:2e ./ch02-fs-1

docker image build -t dockeronwindows/ch02-fs-2:2e ./ch02-fs-2

docker image build -t dockeronwindows/ch02-dotnet-helloworld:2e ./ch02-dotnet-helloworld

docker image build -t dockeronwindows/ch02-dotnet-helloworld:2e-multistage -f ./ch02-dotnet-helloworld/Dockerfile.multistage ./ch02-dotnet-helloworld

#require .NET COre 2.1 on the build machine
cd ./ch02-dotnet-helloworld
dotnet restore src; dotnet publish src
docker image build -f Dockerfile.slim -t dockeronwindows/ch02-dotnet-helloworld:2e-slim .

