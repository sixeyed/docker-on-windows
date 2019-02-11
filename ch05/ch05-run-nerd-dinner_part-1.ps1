docker container run -d `
 --name message-queue `
 dockeronwindows/ch05-nats:2e;

docker container run -d -p 1433:1433 `
 --name nerd-dinner-db `
 -v C:\databases\nd:C:\data `
 dockeronwindows/ch03-nerd-dinner-db:2e;

docker container run -d `
 --name nerd-dinner-save-handler `
 dockeronwindows/ch05-nerd-dinner-save-handler:2e;

docker container run -d `
 --name nerd-dinner-homepage `
 dockeronwindows/ch03-nerd-dinner-homepage:2e;

docker container run -d -p 80 `
 --name nerd-dinner-web `
 --env-file api-keys.env `
 dockeronwindows/ch05-nerd-dinner-web:2e;