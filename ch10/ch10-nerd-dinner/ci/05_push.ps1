Write-Output '*** Pushing images'

$images = 'ch10-nerd-dinner-db:2e', 
            'ch10-nerd-dinner-index-handler:2e', 
            'ch10-nerd-dinner-save-handler:2e', 
            'ch10-nerd-dinner-api:2e',
            'ch10-nerd-dinner-homepage:2e',
            'ch10-nerd-dinner-web:2e'

foreach ($image in $images) {
    $sourceTag = "dockeronwindows/$image"
    $targetTag = "registry:5000/dockeronwindows/$image-$($env:BUILD_TAG)"
    
    docker image tag $sourceTag $targetTag
    docker image push $targetTag
}