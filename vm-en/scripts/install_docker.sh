#!/bin/bash

# Install Docker Engine
apt update
apt install -y docker.io

# Enable Docker to start on boot and start it now
systemctl enable --now docker

# Install kubectl (Kubernetes CLI)
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Verify installation versions
docker --version && kubectl version --client
