#!/bin/bash

if [ "`id -u`" -ne 0 ]; then
    printf "running as $(id -un), root is mandatory for installing deps\n"
    exit 1
fi

echo "start installation"

if ! command -v docker ; then
    curl -fsSL https://get.docker.com | sh
fi

curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /bin/kubectl
chmod +x /bin/kubectl

wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
