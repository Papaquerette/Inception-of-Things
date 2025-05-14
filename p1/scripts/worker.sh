#!/bin/bash

apt-get update
apt-get install -y curl

until [ -f /vagrant/token ]
do
     sleep 3
done

curl -sfL https://get.k3s.io | K3S_URL=https://$SERVER_IP:6443 K3S_TOKEN=$(cat /vagrant/token) INSTALL_K3S_EXEC="--node-external-ip $WORKER_IP" sh -s -
