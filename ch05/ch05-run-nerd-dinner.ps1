docker run -d -p 4222:4222 `
 --name message-queue `
 nats:nanoserver;
 
docker run -d -p 1433:1433 `
 --name nerd-dinner-db `
 -v c:\databases\nd:c:\database `
 dockeronwindows/ch03-nerd-dinner-db;

docker run -d -p 9200:9200 `
 --name elasticsearch `
 sixeyed/elasticsearch:nanoserver

docker run -d -p 5601:5601 `
 --name kibana `
 sixeyed/kibana:nanoserver

docker run -d `
 --name nerd-dinner-index-handler `
 dockeronwindows/ch05-nerd-dinner-index-handler;

docker run -d `
 --name nerd-dinner-save-handler `
 dockeronwindows/ch05-nerd-dinner-save-handler;

docker run -d -p 5000:5000 `
 --name nerd-dinner-homepage `
 dockeronwindows/ch03-nerd-dinner-homepage;

docker run -d -p 8081:8081 `
 --name nerd-dinner-web `
 --env-file api-keys.env `
 dockeronwindows/ch05-nerd-dinner-web;