docker network create --driver overlay nd-swarm

docker service create `
 --detach=true `
 --network nd-swarm --endpoint-mode dnsrr `
 --name message-queue `
 nats:nanoserver

docker service create `
 --detach=true `
 --network nd-swarm --endpoint-mode dnsrr `
 --name elasticsearch `
 --env ES_JAVA_OPTS='-Xms512m -Xmx512m' `
 sixeyed/elasticsearch:nanoserver

docker service create `
 --detach=true `
 --network nd-swarm --endpoint-mode dnsrr `
 --env-file db-credentials.env `
 --name nerd-dinner-db `
 dockeronwindows/ch06-nerd-dinner-db

docker service create `
 --detach=true `
 --network nd-swarm --endpoint-mode dnsrr `
 --publish mode=host,target=5601,published=5601 `
 --name kibana `
 sixeyed/kibana:nanoserver

docker service create `
 --detach=true `
 --network nd-swarm --endpoint-mode dnsrr `
 --env-file db-credentials.env `
 --name nerd-dinner-save-handler `
 dockeronwindows/ch05-nerd-dinner-save-handler

docker service create `
 --detach=true `
 --network nd-swarm --endpoint-mode dnsrr `
 --env ELASTICSEARCH_URL=http://elasticsearch:9200 `
 --env MESSAGE_QUEUE_URL=nats://message-queue:4222 `
 --name nerd-dinner-index-handler `
 dockeronwindows/ch05-nerd-dinner-index-handler

docker service create `
 --detach=true `
 --network nd-swarm --endpoint-mode dnsrr `
 --name nerd-dinner-homepage `
 dockeronwindows/ch03-nerd-dinner-homepage

docker service create `
 --detach=true `
 --network nd-swarm --endpoint-mode dnsrr `
 --env-file db-credentials.env `
 --env-file api-keys.env `
 --env HOMEPAGE_URL=http://nerd-dinner-homepage `
 --env MESSAGE_QUEUE_URL=nats://message-queue:4222 `
 --publish mode=host,target=80,published=80 `
 --name nerd-dinner-web `
 dockeronwindows/ch05-nerd-dinner-web