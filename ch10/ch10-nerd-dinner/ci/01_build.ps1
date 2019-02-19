# Ideally use Docker Compose for this, but it fails with named pipes inside a container
# see https://github.com/docker/compose/issues/5934

#docker-compose `
# -f .\compose\docker-compose.yml `
# -f .\compose\docker-compose.local.yml `
# -f .\compose\docker-compose.build.yml `
# build

Write-Output '*** Building application images'

cd .\ch10\ch10-nerd-dinner
docker image build -t dockeronwindows/ch10-nerd-dinner-db:2e -f .\docker\nerd-dinner-db\Dockerfile .
docker image build -t dockeronwindows/ch10-nerd-dinner-index-handler:2e -f .\docker\nerd-dinner-index-handler\Dockerfile .
docker image build -t dockeronwindows/ch10-nerd-dinner-save-handler:2e -f .\docker\nerd-dinner-save-handler\Dockerfile .
docker image build -t dockeronwindows/ch10-nerd-dinner-api:2e -f .\docker\nerd-dinner-api\Dockerfile .
docker image build -t dockeronwindows/ch10-nerd-dinner-homepage:2e -f .\docker\nerd-dinner-homepage\Dockerfile .
docker image build -t dockeronwindows/ch10-nerd-dinner-web:2e -f .\docker\nerd-dinner-web\Dockerfile .
