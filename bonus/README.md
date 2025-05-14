# Bonus Part

## Technos

 - K3D (Host)
 - K3S (Kubernetes Distrib)
 - ArgoCD (Continuous deployment)
 - Gitlab (Host Configs and Codebase)

## Objective

```mermaid
flowchart BT
    dockerhub@{ shape: lin-cyl, label: "Docker Hub" }
    devopsteam@{ shape: notch-rect, label: "DevOps Team" }
    subgraph cluster k3d
        subgraph Gitlab
            confs@{ shape: lin-cyl, label: "Confs repo" }
        end
        dev[App]
        argocd[ArgoCD]
    end

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
 - helm

##

```bash
./scripts/cluster.sh re
./scripts/cluster.sh demo
```
