docker image build -t dockeronwindows/ch03-aspnet-config:2e ./ch03-aspnet-config

docker image build -t dockeronwindows/ch03-iis-environment-variables:2e ./ch03-iis-environment-variables

docker image build -t dockeronwindows/ch03-iis-healthcheck:2e ./ch03-iis-healthcheck

docker image build -t dockeronwindows/ch03-iis-log-watcher:2e ./ch03-iis-log-watcher

docker image build -t dockeronwindows/ch03-sql-server:2e ./ch03-sql-server

docker image build -t dockeronwindows/ch03-nerd-dinner-db:2e ./ch03-nerd-dinner-db

docker image build -t dockeronwindows/ch03-nerd-dinner-homepage:2e ./ch03-nerd-dinner-homepage

docker image build -t dockeronwindows/ch03-nerd-dinner-web:2e ./ch03-nerd-dinner-web

docker image build -t dockeronwindows/ch03-nerd-dinner-web:2e-v2 -f ./ch03-nerd-dinner-web/Dockerfile.v2 ./ch03-nerd-dinner-web