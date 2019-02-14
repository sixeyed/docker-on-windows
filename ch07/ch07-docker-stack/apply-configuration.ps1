
docker config create nerd-dinner-config .\configs\nerd-dinner-config.json

docker secret create nerd-dinner-secrets .\secrets\nerd-dinner-secrets.json

docker secret create nerd-dinner-api-secrets .\secrets\nerd-dinner-api-secrets.json

docker secret create nerd-dinner-db-sa-password .\secrets\nerd-dinner-db-sa-password.txt;
