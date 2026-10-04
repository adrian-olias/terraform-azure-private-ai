#!/bin/bash
# ==============================================================================
# GPU VM Setup Script — Run manually via Azure Bastion
# ==============================================================================
# GPU drivers take 10-15 minutes to compile. Running this manually via Bastion
# lets you monitor progress and avoids accidental VM reboots during installation.
#
# INSTRUCTIONS:
# 1. Copy the content of this file.
# 2. Connect to the new VM using Azure Bastion.
# 3. Paste everything in the terminal and press Enter.
# ==============================================================================

set -e
echo "Starting GPU VM setup. This may take up to 15 minutes..."

# 0. Fix any pending dpkg locks and initialize
sudo dpkg --configure -a
sudo apt-get --fix-broken install -y
sudo apt-get update -y

# 1. Install base packages and tools
sudo apt-get install -y \
  apt-transport-https ca-certificates curl gnupg \
  lsb-release software-properties-common jq unzip

# 2. Install Docker CE (official)
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --yes --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y \
  docker-ce docker-ce-cli containerd.io \
  docker-buildx-plugin docker-compose-plugin
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

# 3. Install NVIDIA GPU drivers (⚠️ this takes a while — be patient)
sudo apt-get install -y nvidia-driver-535 linux-modules-nvidia-535-azure

# 4. Install NVIDIA Container Toolkit (GPU access inside Docker containers)
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey \
  | sudo gpg --yes --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list \
  | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' \
  | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y nvidia-container-toolkit
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker

# 5. Install Azure CLI (for Storage interaction)
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# 6. Final verification
echo ""
echo "✅ Setup complete! NVIDIA status:"
nvidia-smi
