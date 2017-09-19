#!/bin/bash

echo "Script setup.sh updating apt and installing build tools..."
apt-get update

# install nodejs
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
curl -fsSL https://download.docker.com/linux/debian/gpg > /tmp/docker-gpg-key
gpg --no-default-keyring --keyring /tmp/docker.gpg /tmp/docker-gpg-key | grep "9DC858229FC7DD38854AE2D88D81803C0EBFCD88" || (echo "Docker key has invalid fingerprint!" && exit -1)
cat /tmp/docker-gpg-key | apt-key add -
add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable"
apt-get update
apt-get install -y docker-ce

#install awscli with pip to get the latest
echo "Installing AWSCLI..."
apt-get install -y python-pip
pip install awscli

echo "Installing JQ..."
#install commandline json parser
apt-get install -y jq

echo "Cleaning up..."
apt-get clean

echo "Done with setup.sh"