
docker config create nerd-dinner-api-config .\configs\nerd-dinner-api-config.json

docker config create nerd-dinner-config .\configs\nerd-dinner-config.json

docker secret create nerd-dinner-secrets .\secrets\nerd-dinner-secrets.json

docker secret create nerd-dinner-save-handler-secrets .\secrets\save-handler-secrets.json

docker secret create nerd-dinner-api-secrets .\secrets\nerd-dinner-api-secrets.json

docker secret create nerd-dinner-db-sa-password .\secrets\nerd-dinner-db-sa-password.txt

docker secret create docker-client-ca .\secrets\docker-client-certs\ca.pem

docker secret create docker-client-cert .\secrets\docker-client-certs\cert.pem

docker secret create docker-client-key .\secrets\docker-client-certs\key.pem
