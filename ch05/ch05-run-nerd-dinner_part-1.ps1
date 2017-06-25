docker container run -d -p 4222 `
 --name message-queue `
 nats:nanoserver;
 
docker container run -d -p 1433 `
 --name nerd-dinner-db `
 -v C:\databases\nd:C:\data `
 dockeronwindows/ch03-nerd-dinner-db;

docker container run -d `
 --name nerd-dinner-save-handler `
 dockeronwindows/ch05-nerd-dinner-save-handler;

docker container run -d -p 80 `
 --name nerd-dinner-homepage `
 dockeronwindows/ch03-nerd-dinner-homepage;

docker container run -d -p 80 `
 --name nerd-dinner-web `
 --env-file api-keys.env `
 dockeronwindows/ch05-nerd-dinner-web;
