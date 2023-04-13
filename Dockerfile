FROM jenkins/jenkins:2.387.2-lts

ARG user=jenkins

USER root
COPY setup.sh /setup.sh
RUN /bin/bash /setup.sh

USER ${user}