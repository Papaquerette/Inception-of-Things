function install_docker() {
    if ! command -v docker ; then
        run_task "installing docker" curl -fsSL https://get.docker.com | sh
    fi
}

function install_kubectl() {
    curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /bin/kubectl
    chmod +x /bin/kubectl
}

function install_k3d() {
    wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
}

function install_helm() {
    curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
}
