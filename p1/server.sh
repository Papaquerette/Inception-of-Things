#!/bin/bash

apt-get update
apt-get install -y curl

rm -f /vagrant/token

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-external-ip 192.168.56.110" sh -

cp /var/lib/rancher/k3s/server/token /vagrant/token
