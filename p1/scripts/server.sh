#!/bin/bash

apt-get update
apt-get install -y curl

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-external-ip $SERVER_IP" sh -s -
