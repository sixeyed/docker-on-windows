 docker container run -d `
 --name elasticsearch `
 --env ES_JAVA_OPTS='-Xms512m -Xmx512m' `
 sixeyed/elasticsearch:5.6.11-windowsservercore-ltsc2019;

docker container run -d `
 --name kibana `
 -l "traefik.frontend.rule=Host:kibana.nerddinner.local" `
 sixeyed/kibana:5.6.11-windowsservercore-ltsc2019;

docker container run -d `
 --name nerd-dinner-index-handler `
 dockeronwindows/ch05-nerd-dinner-index-handler:2e;