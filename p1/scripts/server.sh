#!/usr/bin/env bash
set -eux

sudo apt update
sudo apt install -y curl

sudo hostnamectl set-hostname bobS

curl -sfL https://get.k3s.io | \
INSTALL_K3S_EXEC="server \
    --write-kubeconfig-mode=644 \
    --write-kubeconfig-group=vagrant \
    --node-ip=192.168.56.110 \
    --flannel-iface=eth0  \
    --token supersecret " sh -
