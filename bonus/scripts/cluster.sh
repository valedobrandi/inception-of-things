#!/usr/bin/env bash
k3d cluster create inception-of-things -p "8888:30080@loadbalancer"

kubectl create namespace argocd || true
kubectl create namespace gitlab || true

# Delete existing installations if any
kubectl delete -n argocd all --all || true
# Install ArgoCD
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
# Install GitLab
kubectl apply -n gitlab -f ../confs/gitlab.yaml

# Port-forward ArgoCD server
kubectl port-forward -n argocd svc/argocd-server 8080:80 /dev/null 2>&1 &
# Port-forward GitLab webservice
kubectl port-forward -n gitlab svc/gitlab-webservice-default 8181:80 /dev/null 2>&1 &