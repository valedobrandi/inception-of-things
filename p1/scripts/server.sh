#!/usr/bin/env bash
set -euo pipefail
sudo hostnamectl set-hostname bobS

sudo cp /home/vagrant/k3s-offline/k3s /usr/local/bin/k3s
sudo chmod +x /usr/local/bin/k3s

INSTALL_K3S_SKIP_DOWNLOAD=true \
    /home/vagrant/k3s-offline/install.sh \
    --write-kubeconfig-mode=644 \
    --write-kubeconfig-group=vagrant \
    --node-external-ip=192.168.56.110 \
    --flannel-iface=eth1 \
    --token supersecret