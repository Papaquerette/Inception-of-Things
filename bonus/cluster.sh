#!/bin/bash

pushd sh_srcs > /dev/null
. setups.sh
. pass.sh
. demo.sh
popd > /dev/null

function run_setups() {
    pushd confs > /dev/null

    setup_cluster
    setup_gitlab
    setup_argocd

    echo Server is ready

    echo "Now you can run \`$0 demo\` to get a little demo" 

    popd > /dev/null
}

function delete_cluster() {
    run_task "deleting cluster" k3d cluster delete pissenlit
}

copy_pass=false

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
    case $1 in
        -c|--copy)
            copy_pass=true
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
    pass)
        service=$2 get_pass
        ;;
    demo)
        run_demo
        ;;
esac
