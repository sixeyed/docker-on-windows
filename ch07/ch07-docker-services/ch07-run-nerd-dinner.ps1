docker network create --driver overlay nd-swarm

docker service create `
 --detach=true `
 --network nd-swarm `
 --name message-queue `
 dockeronwindows/ch05-nats:2e;

docker service create `
 --detach=true `
 --network nd-swarm `
 --name nats `
 dockeronwindows/ch05-nats:2e;

docker service create `
 --detach=true `
 --network nd-swarm `
 --env-file db-credentials.env `
 --name nerd-dinner-db `
 dockeronwindows/ch06-nerd-dinner-db:2e;

docker service create `
 --detach=true `
 --network nd-swarm `
 --name elasticsearch `
 --env ES_JAVA_OPTS='-Xms512m -Xmx512m' `
 sixeyed/elasticsearch:5.6.11-windowsservercore-ltsc2019;

docker service create `
 --detach=true `
 --network nd-swarm `
 --constraint=node.role==manager `
 --publish 80:80 --publish 8080:8080 `
 --mount type=bind,source=C:\certs\client,target=C:\certs `
 --name reverse-proxy `
 sixeyed/traefik:v1.7.8-windowsservercore-ltsc2019 `
 --docker --docker.swarmMode --docker.watch `
 --docker.endpoint=tcp://win2019-dev-02:2376 `
 --docker.tls.ca=/certs/ca.pem `
 --docker.tls.cert=/certs/cert.pem `
 --docker.tls.key=/certs/key.pem `
 --logLevel=DEBUG --api

docker service create `
 --detach=true `
 --network nd-swarm `
 --name kibana `
 --label "traefik.frontend.rule=Host:kibana.nerddinner.swarm" `
 --label "traefik.port=5601" `
 sixeyed/kibana:5.6.11-windowsservercore-ltsc2019;

docker service create `
 --detach=true `
 --network nd-swarm `
 --env-file db-credentials.env `
 --name nerd-dinner-save-handler `
 dockeronwindows/ch05-nerd-dinner-save-handler:2e;

docker service create `
 --detach=true `
 --network nd-swarm `
 --name nerd-dinner-index-handler `
 dockeronwindows/ch05-nerd-dinner-index-handler:2e;

docker service create `
 --detach=true `
 --network nd-swarm `
 --env-file db-credentials.env `
 --name nerd-dinner-api `
 --label "traefik.frontend.rule=Host:api.nerddinner.swarm" `
 --label "traefik.port=80" `
 dockeronwindows/ch05-nerd-dinner-api:2e;

docker service create `
 --detach=true `
 --network nd-swarm `
 --name nerd-dinner-homepage `
 --label "traefik.frontend.rule=Host:nerddinner.swarm;Path:/,/css/site.css" `
 --label "traefik.frontend.priority=10" `
 --label "traefik.port=80" `
 dockeronwindows/ch03-nerd-dinner-homepage:2e;

docker service create `
 --detach=true `
 --network nd-swarm `
 --env-file db-credentials.env `
 --env-file api-keys.env `
 --env "HomePage:Enabled=false" `
 --env "DinnerApi:Enabled=true" `
 --label "traefik.frontend.rule=Host:nerddinner.swarm;PathPrefix:/" `
 --label "traefik.frontend.priority=1" `
 --label "traefik.backend.loadbalancer.stickiness=true" `
 --label "traefik.port=80" `
 --name nerd-dinner-web `
 dockeronwindows/ch05-nerd-dinner-web:2e;
