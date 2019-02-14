## assumes the solution is already running from ch07-docker-services\ch07-run-nerd-dinner.ps1

docker secret create nerd-dinner-db-sa-password .\secrets\nerd-dinner-db-sa-password.txt;

docker service update `
 --secret-add src=nerd-dinner-db-sa-password,target=C:\secrets\sa-password `
 --image dockeronwindows/ch07-nerd-dinner-db:2e `
 nerd-dinner-db;