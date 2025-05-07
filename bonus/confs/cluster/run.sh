#!/bin/bash

echo creating cluster

k3d cluster create -c ./cluster.yaml
kubectl create -f ./namespaces.yaml