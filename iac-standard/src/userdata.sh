#!/bin/bash
set -e
exec > /var/log/user-data.log 2>&1

echo "=== Starting K3s + ArgoCD Setup ==="

# Update system
yum update -y

# Get Public IP
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
echo "Public IP: ${PUBLIC_IP}"

# Install K3s with public IP in TLS SAN
echo "=== Installing K3s ==="
curl -sfL https://get.k3s.io | sh -s - \
  --tls-san ${PUBLIC_IP} \
  --write-kubeconfig-mode 644

# Wait for K3s to be ready
echo "=== Waiting for K3s to be ready ==="
sleep 30
until kubectl get nodes | grep -q "Ready"; do
  echo "Waiting for node to be ready..."
  sleep 10
done

echo "=== K3s is ready ==="
kubectl get nodes

# Set KUBECONFIG
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
echo 'export KUBECONFIG=/etc/rancher/k3s/k3s.yaml' >> /etc/profile
echo 'export KUBECONFIG=/etc/rancher/k3s/k3s.yaml' >> /home/ec2-user/.bashrc

# Create Namespaces
echo "=== Creating Namespaces ==="
kubectl create namespace argocd
kubectl create namespace jenkins

# Install ArgoCD
echo "=== Installing ArgoCD ==="
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for ArgoCD pods
echo "=== Waiting for ArgoCD pods ==="
kubectl wait --for=condition=ready pod \
  -l app.kubernetes.io/name=argocd-server \
  -n argocd \
  --timeout=300s

# Patch ArgoCD to NodePort
kubectl patch svc argocd-server -n argocd \
  -p '{"spec": {"type": "NodePort"}}'

# Get ArgoCD NodePort
ARGOCD_PORT=$(kubectl get svc argocd-server -n argocd \
  -o jsonpath='{.spec.ports[?(@.port==443)].nodePort}')

# Get ArgoCD initial admin password
until kubectl get secret argocd-initial-admin-secret -n argocd &>/dev/null; do
  echo "Waiting for ArgoCD secret..."
  sleep 10
done

ARGOCD_PASSWORD=$(kubectl get secret argocd-initial-admin-secret \
  -n argocd \
  -o jsonpath="{.data.password}" | base64 -d)

# Create ArgoCD Manager Service Account for cluster registration
echo "=== Creating ArgoCD Manager Service Account ==="
kubectl create serviceaccount argocd-manager -n kube-system

kubectl create clusterrolebinding argocd-manager \
  --clusterrole=cluster-admin \
  --serviceaccount=kube-system:argocd-manager

# Create long-lived token for argocd-manager
kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: argocd-manager-token
  namespace: kube-system
  annotations:
    kubernetes.io/service-account.name: argocd-manager
type: kubernetes.io/service-account-token
EOF

# Wait for token to be populated
sleep 15

# Get cluster details
CLUSTER_CA=$(kubectl get secret argocd-manager-token \
  -n kube-system \
  -o jsonpath='{.data.ca\.crt}')

SA_TOKEN=$(kubectl get secret argocd-manager-token \
  -n kube-system \
  -o jsonpath='{.data.token}' | base64 -d)

# Save all details
cat <<EOF > /home/ec2-user/argocd-details.txt
=== ArgoCD Access Details ===
URL        : https://${PUBLIC_IP}:${ARGOCD_PORT}
Username   : admin
Password   : ${ARGOCD_PASSWORD}

=== Cluster Details for ArgoCD Manifests ===
Cluster URL: https://${PUBLIC_IP}:6443
CA Cert    : ${CLUSTER_CA}
SA Token   : ${SA_TOKEN}

=== Namespaces ===
- argocd   → ArgoCD
- jenkins  → Jenkins (managed by ArgoCD)
EOF

chown ec2-user:ec2-user /home/ec2-user/argocd-details.txt
chmod 600 /home/ec2-user/argocd-details.txt

echo "=== Setup Complete ==="
echo "ArgoCD URL     : https://${PUBLIC_IP}:${ARGOCD_PORT}"
echo "ArgoCD Password: ${ARGOCD_PASSWORD}"
echo "Cluster URL    : https://${PUBLIC_IP}:6443"
echo "Details saved to ~/argocd-details.txt"