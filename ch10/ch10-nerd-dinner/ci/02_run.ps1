# Ideally use Docker Compose for this, but it fails with named pipes inside a container
# see https://github.com/docker/compose/issues/5934

#docker-compose `
# -f .\compose\docker-compose.yml `
# -f .\compose\docker-compose.local.yml
# up -d

docker rm -f $(docker container ls --filter "label=ci" -q)

docker container run -d `
 --label ci `
 dockeronwindows/ch05-nats:2e;
 
docker container run -d -p 80 `
 --label ci `
 --name nerd-dinner-test `
 -v \\.\pipe\docker_engine:\\.\pipe\docker_engine `
 sixeyed/traefik:v1.7.8-windowsservercore-ltsc2019 `
 --docker --docker.endpoint=npipe:////./pipe/docker_engine --logLevel=DEBUG

docker container run -d `
 --label ci `
 --name nerd-dinner-db `
 dockeronwindows/ch10-nerd-dinner-db:2e;

docker container run -d `
 --label ci `
 dockeronwindows/ch10-nerd-dinner-save-handler:2e;

docker container run -d `
 --label ci `
 -l "traefik.frontend.rule=Host:nerd-dinner-test;Path:/,/css/site.css" `
 -l "traefik.frontend.priority=10" `
 dockeronwindows/ch10-nerd-dinner-homepage:2e;

docker container run -d `
 --label ci `
 -l "traefik.frontend.rule=Host:nerd-dinner-test;PathPrefix:/" `
 -l "traefik.frontend.priority=1" `
 -e "HomePage:Enabled=false" `
 -e "DinnerApi:Enabled=false" `
 dockeronwindows/ch10-nerd-dinner-web:2e;