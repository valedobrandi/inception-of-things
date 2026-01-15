#!/usr/bin/env bash
k3d cluster create inception-of-things \
	-p "80:80@loadbalancer" \
	-p "443:443@loadbalancer" \
	-p "32000:32000@server:0"

kubectl create namespace argocd
kubectl create namespace dev

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl apply -n argocd -f ../confs/application.yaml
kubectl apply -f ../confs/ingress.yaml

kubectl patch deployment argocd-server -n argocd \
  --type='json' \
  -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--insecure"}]'
	
