#!/bin/bash

k3d cluster create -c ./confs/cluster.yaml
kubectl create -f ./confs/namespaces.yaml
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f ./confs/argocd-config-map.yaml
kubectl rollout restart deploy argocd-server -n argocd
kubectl -n argocd rollout restart deploy argocd-repo-server
kubectl apply -f ./confs/ingress.yaml

helm repo add gitlab https://charts.gitlab.io/
helm repo update
kubectl apply -f ./confs/gitlab-helm.yaml
