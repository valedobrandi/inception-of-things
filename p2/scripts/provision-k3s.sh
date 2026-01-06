#!/usr/bin/env bash
set -euo pipefail

sudo apt install -y curl

sudo hostnamectl set-hostname bobS

sudo cp /home/vagrant/k3s-offline/k3s /usr/local/bin/k3s
sudo chmod +x /usr/local/bin/k3s

INSTALL_K3S_SKIP_DOWNLOAD=true \
        /home/vagrant/k3s-offline/install.sh \
        --write-kubeconfig-mode=644 \
        --write-kubeconfig-group=vagrant \
        --node-external-ip=192.168.56.110 \
        --flannel-iface=eth1

sudo mkdir -p /home/vagrant/.kube
sudo cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config
sudo chown -R vagrant:vagrant /home/vagrant/.kube
sudo chmod 600 /home/vagrant/.kube/config

until /usr/local/bin/k3s kubectl get nodes >/dev/null 2>&1; do 
    sleep 2
done

/usr/local/bin/k3s ctr images import /home/vagrant/confs/nginx.tar
/usr/local/bin/k3s kubectl apply -f /home/vagrant/confs/apps.yaml
/usr/local/bin/k3s kubectl apply -f /home/vagrant/confs/ingress.yaml

# Edit /etc/hosts
echo "192.168.56.110 app1.com" | sudo tee -a /etc/hosts
echo "192.168.56.110 app2.com" | sudo tee -a /etc/hosts
echo "192.168.56.110 app3.com" | sudo tee -a /etc/hosts