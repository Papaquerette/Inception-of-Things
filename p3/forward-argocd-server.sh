#!/bin/bash

sudo kubectl port-forward svc/argocd-server -n argocd 8443:443
