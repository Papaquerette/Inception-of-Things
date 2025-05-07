#!/bin/bash

function prepend() { while read line; do echo "${1}: ${line}"; done; }

setups=(cluster gitlab argocd application)

pushd confs

for setup in ${setups[@]}; do
    pushd "$setup"
    if test -f ./run.sh; then
        ./run.sh | prepend "run $setup"
    fi
    popd
done

for setup in ${setups[@]}; do
    pushd "$setup"
    if test -f ./wait.sh; then
        ./wait.sh | prepend "wait $setup"
    fi
    popd
done

echo Server is ready

popd
