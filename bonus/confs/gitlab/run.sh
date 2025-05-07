#!/bin/bash

echo setup gitlab
helm repo add gitlab https://charts.gitlab.io/
helm repo update
kubectl apply -f ./gitlab-helm.yaml
echo waiting for gitlab webservice
