#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

echo "Script setup.sh updating apt and installing build tools..."
apt-get update

# TODO: can we remove this since jobs are run on external agents
# install nodejs.  
echo "Installing NodeJS..."
apt-get install -y nodejs

# install docker so we can call parentdocker via socket
# now that docker is docker-ce, debian dropped it, so this is complicated
# from https://docs.docker.com/engine/installation/linux/docker-ce/debian/#install-using-the-repository
echo "Adding docker key and installing Docker in container..."
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install -y docker-ce docker-compose

#install awscli with pip to get the latest
echo "Installing AWSCLI..."
apt-get install -y awscli

echo "Installing JQ..."
#install commandline json parser
apt-get install -y jq

echo "Installing git LFS..."
# Install git lfs extension
# from https://github.com/MarkEWaite/docker-lfs/blob/lts-with-plugins/Dockerfile
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash 
apt-get install -y --allow-unauthenticated --no-install-recommends git-lfs
git lfs install

echo "Cleaning up..."
apt-get clean
rm -r /var/lib/apt/lists/*

echo "Done with setup.sh"