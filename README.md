
# Docker on Windows

-----
Hi Elton,

I don't know your email, and it is impossible to write you via twitter. Therefore I write to you by this method.

Book: Docker on Windows - Second Edition

Chapter: Learning about Docker with this book

> If you want to discuss the book or your own Docker journey with me, feel free to ping me on Twitter at @EltonStoneman.

Twitter:
> @EltonStoneman cannot receive messages

----------------------------

Chapter: Running Docker on Windows

Wrong:
> $env:DOCKER_HOST='tcp://$($ipAddress):2376'

Corrected:
> $env:DOCKER_HOST="tcp://$($ipAddress):2376"

Best regards, Andrey
-----

This is all the source code for the samples in my book [Docker on Windows](https://www.amazon.co.uk/Docker-Windows-Elton-Stoneman-ebook/dp/B0711Y4J9K), published by Packt.

Every Dockerfile is also available on Docker Hub at the [dockeronwindows](https://hub.docker.com/r/dockeronwindows/) organization.

It's a comprehensive look at running Docker on Windows, covering everything from 101 to production over 12 chapters.

## Weekly Dockerfile

I've also got a blog series describing all the Dockerfiles in detail: [Weekly Windows Dockerfiles](https://blog.sixeyed.com/tag/weekly-dockerfile/)

## The Missing Preface

Somewhere between the author's laptop, the publisher's content system and the printing press, the preface I wrote didn't make it into the final book. You can read it [here](preface.md).

## Contents

1. Getting Started with Docker on Windows
	
2. Packaging and Running Applications as Docker Containers
	
3. Developing Dockerized .NET and .NET Core Applications

4. Pushing and Pulling Images from Docker Registries
	
5. Adopting Container-First Solution Design
	
6. Organizing Distributed Solutions with Docker Compose
	
7. Orchestrating Distributed Solutions with Docker Swarm
	
8. Administering and Monitoring Dockerized Solutions
	
9. Understanding the Security Risks and Benefits of Docker
	
10. Powering a Continuous Deployment Pipeline with Docker
	
11. Debugging and Instrumenting Application Containers
	
12. Containerize What You Know: Guidance for Implementing Docker

## Cover Art

![Docker on Windows by Elton Stoneman, cover page](docker-on-windows.jpg)

## Reviews

* [Amazon - customer reviews for Docker on Windows](https://www.amazon.co.uk/Docker-Windows-Elton-Stoneman-ebook/dp/B0711Y4J9K#customerReviews)

* [InfoQ - Book Review Docker on Windows by Elton Stoneman](https://www.infoq.com/news/2017/08/docker-windows-elton-stoneman)

* [實戰 Docker｜使用 Windows Server 2016/Windows 10](https://www.tenlong.com.tw/products/9789864767915) (Traditional Chinese, Taiwan)
