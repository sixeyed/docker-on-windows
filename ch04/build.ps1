docker image build -t dockeronwindows/ch04-registry:2e ./ch04-registry

docker image tag dockeronwindows/ch04-registry:2e registry.local:5000/infrastructure/registry:v2.6.2

docker image build -t dockeronwindows/ch04-hello:2e ./ch04-hello