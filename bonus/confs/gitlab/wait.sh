#!/bin/bash

echo waiting gitlab

kubectl wait --for=create deploy/gitlab-webservice-default --timeout=600s -n gitlab

kubectl wait --for=condition=Available deploy/gitlab-webservice-default --timeout=600s -n gitlab
