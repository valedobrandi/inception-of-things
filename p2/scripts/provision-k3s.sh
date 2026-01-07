#!/usr/bin/env bash
set -euo pipefail

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

sudo mkdir -p /home/vagrant/.kube
sudo cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config
sudo chown -R vagrant:vagrant /home/vagrant/.kube
sudo chmod 600 /home/vagrant/.kube/config

until /usr/local/bin/k3s kubectl get nodes >/dev/null 2>&1; do 
    sleep 2
done

kubectl apply -f /confs

# Edit /etc/hosts
echo "192.168.56.110 app1.com" | sudo tee -a /etc/hosts
echo "192.168.56.110 app2.com" | sudo tee -a /etc/hosts
echo "192.168.56.110 app3.com" | sudo tee -a /etc/hosts