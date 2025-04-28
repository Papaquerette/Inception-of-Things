#!/bin/bash

# exec 1>/vagrant/server.stdout
# exec 2>/vagrant/server.stderr

apt-get update
apt-get install -y curl

curl -sfL https://get.k3s.io | sh -

kubectl create -f /vagrant/confs/app1.yaml
kubectl create -f /vagrant/confs/app1.service.yaml
kubectl expose deployment.apps/app1
