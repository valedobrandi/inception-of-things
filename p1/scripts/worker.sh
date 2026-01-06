#!/usr/bin/env bash
set -euo pipefail
sudo hostnamectl set-hostname kevinSW

sudo cp /home/vagrant/k3s-offline/k3s /usr/local/bin/k3s
sudo chmod +x /usr/local/bin/k3s

INSTALL_K3S_SKIP_DOWNLOAD=true \
K3S_URL=https://192.168.56.110:6443 \
K3S_TOKEN=supersecret \
sh /home/vagrant/k3s-offline/install.sh \
    --node-ip=192.168.56.111