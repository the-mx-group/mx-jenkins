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
#curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg
add-apt-repository -y \
    "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable"
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

# TODO: can we remove this since jobs are run on external agents
echo "Installing kubernetes tools..."
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubectl=1.23.6-00

# TODO: can we remove this since jobs are run on external agents
echo "Installing rsync..."
apt-get install -y rsync

echo "Cleaning up..."
apt-get clean
rm -r /var/lib/apt/lists/*

echo "Done with setup.sh"