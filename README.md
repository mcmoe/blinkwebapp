# Dockerized Deployment of Blink Web App

Blink Products ([blinkforhome.com](https://blinkforhome.com/)) do not provide a web based portal, only mobile apps. That is rather unforunate. Thankfully, [@adrian-dobre](https://github.com/adrian-dobre) took the time to reverse engineer the API's and build one himself. He published this work under 2 repos: a [BlinkWebUI](https://github.com/adrian-dobre/BlinkWebUI) frontend and a [BlinkWebService](https://github.com/adrian-dobre/BlinkWebService) backend.

## Motivation

This repo aims to simplify the deployment by taking care of all the details for you and providing you with a ready-to-run docker container.
It packs all the details into a Dockerfile based on a openJDK8 Alpine image to build then and openJRE8 Alpine image to serve. This allows for a small footprint (~122MB). It makes sure to delete all unecessary files, including the repos and only keep the artefacts needed to run the webapp.

This Dockerfile is built and published on DockerHub as the image `mcmoe/blinkwebapp`, thus allowing for a simple `docker pull` to retrieve the image from anywhere.

## How to

Simply execute the command below to start up the docker container (the image is automatically pulled if you do not have it yet):

```sh
docker run -it -p 80:80 mcmoe/blinkwebapp
```

Note: Change the host machine port (ex. -p 9898:80) if you would like to run the app on a port other than 80 on the host machine.
