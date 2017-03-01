FROM jenkins:latest

ARG user=jenkins

USER root
COPY setup.sh /setup.sh
RUN chmod +x /setup.sh && /setup.sh

USER ${user}