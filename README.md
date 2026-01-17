# Inception-of-Things

Demo project that brings together DevOps practices, infrastructure-as-code, and Kubernetes orchestration to showcase skills in automation, provisioning and continuous deployment.

This repository contains environments and scripts to:

- Create reproducible development VMs using Vagrant
- Provision lightweight Kubernetes clusters (k3s)
- Demonstrate GitOps / continuous delivery flows with ArgoCD and GitLab

## Summary

Use the scripts in the repository root and the `p1/`, `p2/`, `p3/` and `bonus/` folders to explore example scenarios for development, provisioning and CI/CD automation.

This project is useful to demonstrate practical knowledge of Bash automation, Vagrant-based environments, k3s/Kubernetes manifests and GitOps workflows.

## What’s included (quick)

- `p1/` — Vagrant examples and helper scripts (server/worker)
- `p2/` — provisioning scripts and example app manifests (k3s setup, entrypoints, YAMLs)
- `p3/` — application manifests and ArgoCD / installation scripts
- `bonus/` — auxiliary manifests and scripts (ArgoCD, GitLab manifests, helper utilities)
- `inception.sh`, `commands.txt` — high-level commands and notes used during development

## Motivation

The repository aims to showcase practical skills in automation and platform engineering:

- Building reproducible development environments (Vagrant + scripts)
- Provisioning lightweight Kubernetes clusters (k3s)
- Demonstrating GitOps-driven deployment (ArgoCD) and GitLab integration

## Technologies & Skills Demonstrated

- Bash scripting for task automation
- Vagrant for reproducible VMs
- k3s / Kubernetes (Deployments, Services, Ingress manifests)
- ArgoCD for GitOps and automated deployments
- GitLab (Omnibus manifests and configuration examples)
- YAML for Kubernetes and application configuration

## Prerequisites

Install the tools required for the scenario you want to run (examples):

- `bash` (scripts)
- `vagrant` + provider (VirtualBox / libvirt)
- `docker` (optional, for some scripts)
- `kubectl` (optional, to interact with clusters)
- `argocd` CLI (if you plan to test ArgoCD flows)

Typical Linux notes:

```bash
# install Vagrant (package depends on your distro)
# install kubectl: https://kubernetes.io/docs/tasks/tools/
# install docker: https://docs.docker.com/engine/install/
```

## How to run — quick examples

Note: some scripts may require elevated privileges (sudo) depending on your host.

1) Bring up Vagrant VMs (example: `p1`):

```bash
cd p1/Vagrantfile
vagrant up
```

2) Provision a k3s cluster (example: `p2`):

```bash
bash p2/scripts/provision-k3s.sh
# or run the entrypoint script:
bash p2/scripts/entrypoint.sh
```

3) Utility scripts (example: `bonus`):

```bash
bash bonus/scripts/cluster.sh        # cluster helpers
bash bonus/scripts/gitlab-password.sh
```

4) Install components / ArgoCD / run deploys (example: `p3`):

```bash
bash p3/scripts/install.sh
bash p3/scripts/cluster.sh
```

Each directory contains local scripts and parameters—review them before executing.

## Repository structure (detailed)

- `README.md` — this file
- `commands.txt`, `inception.sh` — high-level commands and notes
- `bonus/` — GitLab/ArgoCD manifest examples and helper scripts (`bonus/confs`, `bonus/scripts`)
- `p1/`, `p2/`, `p3/` — separate scenario folders (VM/dev, provisioning, deploy)

## Minimal contract (inputs / outputs / failure modes)

- Inputs: YAML manifests, bash scripts, optional environment variables
- Outputs: VMs up, k3s cluster provisioned, Kubernetes resources applied and services exposed
- Failure modes: missing dependencies (vagrant/docker/kubectl), insufficient permissions, port conflicts

Success criteria: after running the indicated scripts, services and applications should be reachable according to the manifests/Ingress configuration.

## Edge cases & recommendations

- No VirtualBox available: use a different Vagrant provider (libvirt) or run provisioning scripts on a host with Docker.
- Low resources (RAM/CPU): adjust VM sizing in the `Vagrantfile` and tune GitLab/Omnibus settings.
- DNS / Ingress issues: check `confs/ingress.yaml` and local hosts / DNS rules.

## Contributing

1. Open an issue describing the change you want.
2. Fork the repository and create a focused branch for your change.
3. Submit a pull request with a clear description and manual test steps where applicable.

## Skills this project highlights

- Infrastructure-as-Code (IaC)
- Provisioning automation (Bash, Vagrant)
- Kubernetes deployments and manifests (k3s)
- GitOps practices (ArgoCD) and GitLab integration
- Operational troubleshooting and configuration tuning


---

Thank you — this README is designed to make it easy to run practical demos from this repository.

