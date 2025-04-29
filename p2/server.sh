#!/bin/bash

# exec 1>/vagrant/server.stdout
# exec 2>/vagrant/server.stderr

apt-get update
apt-get install -y curl

curl -sfL https://get.k3s.io | sh -

kubectl apply -f /vagrant/confs/app1/deployment.yaml
kubectl apply -f /vagrant/confs/app1/service.yaml
kubectl apply -f /vagrant/confs/app2/deployment.yaml
kubectl apply -f /vagrant/confs/app2/service.yaml
kubectl apply -f /vagrant/confs/app3/deployment.yaml
kubectl apply -f /vagrant/confs/app3/service.yaml
kubectl apply -f /vagrant/confs/ingress.yaml
