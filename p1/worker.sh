#!/bin/bash

exec 1>/vagrant/worker.stdout
exec 2>/vagrant/worker.stderr

apt-get update
apt-get install -y curl

until [ -f /vagrant/token ]
do
     sleep 3
done

echo "start install"
echo -n "token: "
cat /vagrant/token
echo ""
curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.110:6443 K3S_TOKEN=$(cat /vagrant/token) INSTALL_K3S_EXEC="--node-external-ip 192.168.56.111" sh -s -
echo "end install"
