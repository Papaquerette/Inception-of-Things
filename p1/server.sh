#!/bin/bash

exec 1>/vagrant/server.stdout
exec 2>/vagrant/server.stderr

apt-get update
apt-get install -y curl

curl -sfL https://get.k3s.io | sh -

cp /var/lib/rancher/k3s/server/token /vagrant/token
