#!/usr/bin/env bash
kubectl create namespace gitlab || true

# Install GitLab
kubectl apply -n gitlab -f ../confs/gitlab.yaml
kubectl apply -n gitlab -f ../confs/gitlab-service.yaml
kubectl apply -n gitlab -f ../confs/gitlab-ingress.yaml
kubectl apply -n argocd -f ../confs/argocd.yaml

