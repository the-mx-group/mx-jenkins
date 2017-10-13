Docker image for Mx's Jenkins build servers.

Our main build server builds itself using this Dockerfile, uploads the 
resulting image to [DockerHub](https://hub.docker.com/r/themxgroup/jenkins/),
and restarts itself on the new image via Salt.

Jenkins home is exported by default as a volume per the upstream Dockerfile.
