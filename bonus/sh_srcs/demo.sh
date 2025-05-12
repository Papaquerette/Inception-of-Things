. pass.sh
. utils.sh

function write_config() {
    cat << EOF > ./config.yml
git_protocol: ssh
editor:
browser:
glamour_style: light
check_update: true
last_update_check_timestamp: 2025-05-11T13:59:27+02:00
display_hyperlinks: true
host: gitlab.pissenlit.com
no_prompt: true
hosts:
    gitlab.pissenlit.com:
        skip_tls_verify: "true"
        token: $token
        api_host: gitlab.pissenlit.com
        git_protocol: ssh
        api_protocol: https
        user: root
EOF
    chmod 600 config.yml
}

function run_demo() {
    echo "start demo"

    copy_pass="true" service="gitlab" get_pass 2> /dev/null && echo "default root password in clipboard" || echo "default root password: $(service="gitlab" get_pass)"

    echo "Create token at: https://gitlab.pissenlit.com/-/user_settings/personal_access_tokens?scopes=api,write_repository&name=cli_token"
    echo -n "token (no echo): "
    read -s token
    echo ""

    write_config

    ssh-keygen -f ~/.ssh/demo_key -t rsa -b 4096 -N ""
    ssh-keygen -f "/root/.ssh/known_hosts" -R "gitlab.pissenlit.com"
    GLAB_CONFIG_DIR=. NO_PROMPT=1 glab ssh-key add ~/.ssh/demo_key.pub -t "key demo"
    GLAB_CONFIG_DIR=. NO_PROMPT=1 glab repo create root/kube-conf -Ps

    pushd demo > /dev/null
    rm -rf .git
    git init
    git config --local user.name "Administrator"
    git config --local user.email "gitlab_admin@pissenlit.com"
    git config --local core.sshCommand "/usr/bin/ssh -i /root/.ssh/demo_key"
    git remote add gitlab git@gitlab.pissenlit.com:root/kube-conf.git
    git add dev
    git commit -m "deploy app"
    git push --set-upstream gitlab master
    popd > /dev/null

    pushd confs/application > /dev/null
    run_task "config application" kubectl apply -f ./application.yaml
    popd > /dev/null
}
