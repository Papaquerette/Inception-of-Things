. pass.sh
. utils.sh

function run_demo() {
    echo "start demo"

    pushd $CONFS_ROOT/application > /dev/null

    run_task "config application" kubectl apply -f ./application.yaml
    
    popd > /dev/null
}
