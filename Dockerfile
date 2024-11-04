FROM jenkins/jenkins:2.479.1-lts

ARG user=jenkins

USER root
COPY setup.sh /setup.sh
RUN /bin/bash /setup.sh

COPY plugins.yaml /plugins.yaml
RUN jenkins-plugin-cli --plugin-file /plugins.yaml

USER ${user}