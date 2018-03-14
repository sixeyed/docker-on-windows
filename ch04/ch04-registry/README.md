
# ch04-registry

[Docker Registry](https://github.com/docker/distribution) packaged to run in a Windows container. 

The Dockerfile in Chapter 4 of the book packages version 2.6.1 of the registry server but there is an [important security fix in version 2.6.2](https://github.com/docker/distribution/releases/tag/v2.6.2).

So:

- [Dockerfile](Dockerfile) is an updated version of the image which packages 2.6.2 with Go 1.10.

- [Dockerfile.old](Dockerfile.old) is the original version which matches the code in the book. **Don't use this** unless you want to recreate the exact samples in the book. The new version fixes the security issue, and you use it in the same way.

> The image on Docker Hub `dockeronwindows/ch04-registry` has been updated to the v2.6.2 release.

## Usage

See [Windows Weekly Dockerfile #20](TODO).