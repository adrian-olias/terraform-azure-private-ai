#!/bin/bash
# Installs Docker, NVIDIA drivers and the NVIDIA Container Toolkit on the GPU VM.
# The VM has no inbound access, so run it through the Azure control plane:
#
#   az vm run-command invoke -g rg-privateai-lab -n vm-privateai-lab \
#     --command-id RunShellScript --scripts @scripts/vm/install-gpu-docker.sh
#
# Takes 10-15 minutes (driver build).
set -euo pipefail

ADMIN_USER="azureaiuser"
export DEBIAN_FRONTEND=noninteractive

apt-get update -y
apt-get install -y ca-certificates curl gnupg

# Docker CE
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --yes --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
  > /etc/apt/sources.list.d/docker.list
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
usermod -aG docker "${ADMIN_USER}"

# NVIDIA driver (prebuilt Azure kernel modules)
apt-get install -y nvidia-driver-535 linux-modules-nvidia-535-azure

# NVIDIA Container Toolkit (GPU access inside containers)
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --yes --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -fsSL https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list \
  | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' \
  > /etc/apt/sources.list.d/nvidia-container-toolkit.list
apt-get update -y
apt-get install -y nvidia-container-toolkit
nvidia-ctk runtime configure --runtime=docker
systemctl restart docker

nvidia-smi
