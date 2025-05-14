#!/bin/bash

CONFS_ROOT="${CONFS_ROOT:-"./confs"}"

pushd $CONFS_ROOT

k3d cluster create -c ./cluster.yaml
kubectl create -f ./namespaces.yaml
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f ./argocd-config-map.yaml
kubectl rollout restart deploy argocd-server -n argocd
kubectl -n argocd rollout restart deploy argocd-repo-server
kubectl apply -f ./application.yaml
kubectl apply -f ./ingress.yaml

popd
