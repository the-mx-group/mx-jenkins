#!/bin/bash

apt-get update

# install nodejs
apt-get install -y nodejs

# install docker so we can call parentdocker via socket
apt-get install -y docker.io

#install awscli
apt-get install -y awscli

#install commandline json parser
apt-get install -y jq

apt-get clean

