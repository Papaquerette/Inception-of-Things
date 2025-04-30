#!/bin/bash

sudo k3d cluster create -c ./cluster.yaml
sudo kubectl create -f ./namespaces.yaml
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sudo kubectl apply -f ./application.yaml
