Docker image for Mx's Jenkins controller.

Our main build server builds itself using this Dockerfile and uploads the resulting
multi-arch image to [DockerHub](https://hub.docker.com/r/themxgroup/jenkins/).
The controller runs on ECS Fargate (see the `mx-devops.terraform` repo), launching build
agents in client AWS accounts; the image itself contains no build tooling.

Configuration (Jenkins Configuration as Code) is not baked into the image. At startup the
container reads CasC YAML from `CASC_JENKINS_CONFIG`; secrets arrive as environment
variables or through the AWS Secrets Manager credentials provider.

Jenkins home is exported by default as a volume per the upstream Dockerfile.
