function get_argocd_pass() {
    echo $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
}

function get_gitlab_pass() {
    echo $(kubectl get secret gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' -n gitlab | base64 --decode)
}

function get_pass() {
    pass=$(get_"$service"_pass)

    if $copy_pass; then
        echo "$pass" | xclip -selection clipboard
    else
        echo "$pass" 
    fi
}
