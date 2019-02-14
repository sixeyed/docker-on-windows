## assumes the solution is already running from ch07-docker-services\ch07-run-nerd-dinner.ps1

docker config create nerd-dinner-api-config .\configs\nerd-dinner-api-config.json;

docker service update `
 --config-add src=nerd-dinner-api-config,target=C:\dinner-api\config\config.json `
 --image dockeronwindows/ch07-nerd-dinner-api:2e `
 nerd-dinner-api;