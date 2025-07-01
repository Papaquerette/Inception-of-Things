#!/bin/bash

pushd $(dirname $0)

pushd sh_srcs > /dev/null
. welcome.sh
. setups.sh
. pass.sh
. installers.sh
. demo.sh
popd > /dev/null

popd

continue=y

if [ "`id -u`" -ne 0 ]; then
    printf "running as $(id -un), root is recommended\n"
    printf "Continue ?(y/N) "
    read continue
    continue=${continue:-'n'}
    echo ""
fi

if [[ "$continue" == "n" ]]; then
    exit 1
fi

function run_setups() {
    setup_cluster
    setup_gitlab
    setup_argocds

    echo "Server is ready"

    echo "Now you can run \`$0 demo\` to get a little demo" 
}

function delete_cluster() {
    run_task "deleting cluster" k3d cluster delete pissenlit
}

function install_deps() {
    run_task "installing docker" install_docker

    run_task "installing kubectl" install_kubectl

    run_task "installing k3d" install_k3d

    run_task "installing helm" install_helm
}

copy_pass=false
logs=false

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
    case $1 in
        -c|--copy)
            copy_pass=true
            ;;
        -l|--logs)
            logs=true
            ;;
        -*|--*)
            echo "Unknown option $1"
            exit 1
            ;;
        *)
            POSITIONAL_ARGS+=("$1")
            ;;
    esac
    shift
done

set -- "${POSITIONAL_ARGS[@]}"

service_pass=""

case $1 in
    run)
        run_setups
        ;;
    delete)
        delete_cluster
        ;;
    re)
        delete_cluster
        run_setups
        ;;
    install-deps)
        install_deps
        ;;
    pass)
        service=$2 get_pass
        ;;
    demo)
        run_demo
        ;;
esac
