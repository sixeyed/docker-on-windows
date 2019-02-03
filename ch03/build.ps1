docker image build -t dockeronwindows/ch03-iis-environment-variables:2e ./ch03-iis-environment-variables

docker image build -t dockeronwindows/ch03-iis-environment-variables:2e-servicemonitor -f Dockerfile.servicemonitor ./ch03-iis-environment-variables

docker image build -t dockeronwindows/ch03-iis-healthcheck:2e ./ch03-iis-healthcheck

docker image build -t dockeronwindows/ch03-iis-log-watcher:2e ./ch03-iis-log-watcher

docker image build -t dockeronwindows/ch03-sql-server:2e ./ch03-sql-server

docker image build -t dockeronwindows/ch03-nerd-dinner-db:2e ./ch03-nerd-dinner-db

docker image build -t dockeronwindows/ch03-nerd-dinner-homepage:2e ./ch03-nerd-dinner-homepage

docker image build -t dockeronwindows/ch03-nerd-dinner-web:2e ./ch03-nerd-dinner-web