#!/bin/bash

apt-get update

# install nodejs
apt-get install -y nodejs

# install docker so we can call parentdocker via socket
apt-get install -y docker.io

#install awscli with pip to get the latest
apt-get install -y python-pip
pip install awscli

#install commandline json parser
apt-get install -y jq

apt-get clean

