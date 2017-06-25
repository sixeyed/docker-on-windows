 docker container run -d -p 9200 `
 --name elasticsearch `
 sixeyed/elasticsearch:nanoserver;

docker container run -d -p 5601 `
 --name kibana `
 sixeyed/kibana:nanoserver;

docker container run -d `
 --name nerd-dinner-index-handler `
 dockeronwindows/ch05-nerd-dinner-index-handler;