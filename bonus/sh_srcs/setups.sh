#!/bin/bash

. utils.sh

function setup_cluster() {
    pushd cluster > /dev/null

    echo setup cluster

    run_task "create cluster" k3d cluster create -c ./cluster.yaml
    run_task "create namespaces" kubectl create -f ./namespaces.yaml
    
    popd > /dev/null
}

function setup_gitlab() {
    pushd gitlab > /dev/null

    echo setup gitlab
    run_task "add helm repo" helm repo add gitlab https://charts.gitlab.io/
    run_task "update helm repo" helm repo update
    run_task "setup gitlab services" kubectl apply -f ./gitlab-helm.yaml
    run_task "setup gitlab ssh NodePort" kubectl apply -f ./ssh-nodeport.yaml
    
    echo waiting gitlab
    run_task "waiting gitlab service creation" kubectl wait --for=create deploy/gitlab-webservice-default --timeout=600s -n gitlab
    run_task "waiting gitlab service availability" kubectl wait --for=condition=Available deploy/gitlab-webservice-default --timeout=600s -n gitlab

    popd > /dev/null
}

function setup_argocd() {
    pushd argocd > /dev/null

    echo setup argocd

    run_task "setup argocd" kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    run_task "config argocd" kubectl apply -f ./argocd-config-map.yaml
    run_task "restart argocd-server" kubectl rollout restart deploy argocd-server -n argocd
    run_task "restart argocd-repo-server" kubectl -n argocd rollout restart deploy argocd-repo-server
    run_task "config argocd ingress" kubectl apply -f ./ingress.yaml

    popd > /dev/null
}
