#!/bin/bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo chmod 770 kubectl
sudo mv kubectl /usr/local/bin/kubectl

wget https://github.com/kubernetes/kops/releases/download/v1.26.4/kops-linux-amd64
sudo chmod 770 kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops

wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.18.1/kubeseal-0.18.1-linux-amd64.tar.gz
tar -xvzf kubeseal-0.18.1-linux-amd64.tar.gz
sudo mv kubeseal /usr/local/bin/
sudo chmod +x /usr/local/bin/kubeseal
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.1/deploy/static/provider/aws/deploy.yaml

sudo apt install unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

