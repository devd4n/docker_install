#!/bin/bash

DOCKER_USERNAME=docker_user

# Überprüfe die Distribution (Ubuntu oder Debian)
if [ -f /etc/debian_version ]; then
    DISTRO=$(lsb_release -is)
else
    echo "Nicht unterstützte Distribution"
    exit 1
fi

sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release

sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/$DISTRO/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$DISTRO $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo useradd -m $DOCKER_USERNAME -s /bin/bash
sudo passwd $DOCKER_USERNAME
sudo usermod -aG docker $DOCKER_USERNAME
