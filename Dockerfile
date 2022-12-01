FROM jenkins/jenkins:2.375.1-lts

ARG user=jenkins

USER root
COPY setup.sh /setup.sh
RUN /bin/bash /setup.sh

USER ${user}