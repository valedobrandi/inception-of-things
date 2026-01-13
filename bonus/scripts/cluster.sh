#!/usr/bin/env bash
kubectl create namespace gitlab || true


# Install GitLab
kubectl apply -n gitlab -f ../confs/gitlab.yaml

# Port-forward GitLab webservice
kubectl port-forward -n gitlab gitlab 8181:80