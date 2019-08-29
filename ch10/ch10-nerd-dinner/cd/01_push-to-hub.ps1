Write-Output '*** Pushing images to Hub'

docker login --username $env:DOCKER_HUB_USER --password "$env:DOCKER_HUB_PASSWORD"

$images = 'ch10-nerd-dinner-db:2e', 
          'ch10-nerd-dinner-index-handler:2e', 
          'ch10-nerd-dinner-save-handler:2e', 
          'ch10-nerd-dinner-api:2e',
          'ch10-nerd-dinner-homepage:2e',
          'ch10-nerd-dinner-web:2e'

foreach ($image in $images) {   
    $sourceTag = "registry:5000/dockeronwindows/$image-jenkins-docker-on-windows-ch10-nerd-dinner-$($env:VERSION_NUMBER)"
    $targetTag = "dockeronwindows/$image-$($env:VERSION_NUMBER)"
    
    docker image pull $sourceTag 
    docker image tag $sourceTag $targetTag
    docker image push $targetTag
}