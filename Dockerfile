FROM jenkins/jenkins:2.580.2-lts

# The controller only orchestrates: builds run on agents that it launches in the cloud, so no
# docker, node, or build tooling is installed here (nothing needs root at build time).
# Configuration is supplied at runtime (CASC_JENKINS_CONFIG) and is not part of this public image.
COPY plugins.yaml /plugins.yaml
RUN jenkins-plugin-cli --plugin-file /plugins.yaml

USER jenkins
