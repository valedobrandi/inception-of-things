k3d cluster create inception-of-things -p "8888:30080@loadbalancer"

kubectl create namespace dev || true
kubectl create namespace argocd || true
kubectl create namespace gitlab || true

# Install ArgoCD
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl wait --for=condition=available --timeout=600s deployment/argocd-server -n argocd

# Install ArgoCD CLI
curl -sSL -o argocd \
  https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
install -m 555 argocd /usr/local/bin/argocd
rm argocd

# Install GitLab in background
kubectl port-forward svc/argocd-server -n argocd 8080:443 >/dev/null 2>&1 &
sleep 5

# Get initial ArgoCD password
ARG_PASS=$(kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 --decode ; echo)

# Login to ArgoCD
argocd login localhost:8080 --username admin --password $ARG_PASS --insecure

# Install Helm
helm install gitlab gitlab/kubernetes-gitlab-demo -n gitlab

# Install GitLab with custom values
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
helm install gitlab gitlab/gitlab -f "$SCRIPT_DIR/../confs/values.yaml" --namespace gitlab

echo "127.0.0.1 gitlab.local" >> /etc/hosts >/dev/null

# Wait for GitLab to be ready
sleep 30

# Get GitLab root password
GITLAB_PASS=$(kubectl get secret gitlab-gitlab-initial-root-password -n gitlab -o jsonpath="{.data.password}" | base64 --decode)
echo "GitLab root password: $GITLAB_PASS"

# Generate SSH key for ArgoCD to access GitLab
ssh-keygen -t ed25519 -f argocd-gitlab -C "argocd"
cat argocd-gitlab.pub

argocd version

echo "Use the following command to add the GitLab repository to ArgoCD:"
echo "argocd repo add http://gitlab.local/root/inception.git --ssh-private-key-path ./argocd-gitlab --insecure-skip-server-verification --name inception"
