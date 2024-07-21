#!/bin/bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo chmod 770 kubectl
sudo mv kubectl /usr/local/bin/kubectl

wget https://github.com/kubernetes/kops/releases/download/v1.26.4/kops-linux-amd64
sudo chmod 770 kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops