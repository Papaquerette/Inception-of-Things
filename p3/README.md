# Part 3

## Technos

 - K3D (Host)
 - K3S (Kubernetes Distrib)
 - ArgoCD (Continuous deployment)
 - Github (Host Configs and Codebase)

## Objective

```mermaid
flowchart BT
    dockerhub@{ shape: lin-cyl, label: "Docker Hub" }
    devteam@{ shape: notch-rect, label: "Dev Team" }
    devopsteam@{ shape: notch-rect, label: "DevOps Team" }
    subgraph Github
        confs@{ shape: lin-cyl, label: "Confs repo" }
        codebase@{ shape: lin-cyl, label: "CodeBase repo" }
    end
    subgraph cluster k3d
        dev[App]
        argocd[ArgoCD]
    end

    devteam -- Push CodeBase --> codebase
    devopsteam -- Push k3s confs --> confs
    codebase -- Publish --> dockerhub
    argocd <-- Fetch changes --> confs
    argocd -- Update Confs --> dev
    dev <-- Fetch Images --> dockerhub
```

## dependencies

 - kubectl
 - docker
 - k3d

## Run project

```bash
$ ./scripts/server.sh
```
