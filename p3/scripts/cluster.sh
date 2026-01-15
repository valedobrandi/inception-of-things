#!/usr/bin/env bash
k3d cluster create inception-of-things -p "80:80@loadbalancer" -p "443:443@loadbalancer"

kubectl create namespace argocd
kubectl create namespace dev

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl apply -n argocd -f ../confs/application.yaml
kubectl apply -f ../confs/ingress.yaml

kubectl patch deployment argocd-server -n argocd \
  --type='json' \
  -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--insecure"}]'

kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 --decode; echo

echo "127.0.0.1 dev.localhost" | sudo tee -a /etc/hosts
echo "127.0.0.1 argocd.localhost" | sudo tee -a /etc/hosts
