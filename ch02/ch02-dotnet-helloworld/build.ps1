
dotnet restore src

dotnet publish src -o bin

docker build -f slim.dockerfile -t dockeronwindows/ch02-dotnet-helloworld:slim .
