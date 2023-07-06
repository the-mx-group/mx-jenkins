FROM jenkins/jenkins:2.401.2-lts

ARG user=jenkins

USER root
COPY setup.sh /setup.sh
RUN /bin/bash /setup.sh

USER ${user}