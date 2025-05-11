RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"

function run_task() {
    log_file=$(mktemp)
    spin='⣾⣽⣻⢿⡿⣟⣯⣷'
    
    name="$1"
    shift

    "$@" &>> "$log_file" &

    pid=$!

    i=0
    while kill -0 $pid 2>/dev/null; do
        i=$(( (i+1) %8 ))
        printf "\r$YELLOW${spin:$i:1}$ENDCOLOR $name"
        sleep .1
    done

    wait $pid
    exit_status=$?

    if [[ $exit_status -ne 0 ]]; then
        printf "\r$RED✗$ENDCOLOR $name\n"
        echo "error: $@"
        echo "exited: $exit_status"
        echo "logs:"
        cat "$log_file"
        exit $exit_status
    fi

    printf "\r$GREEN✓$ENDCOLOR $name\n"
}

function prepend() { while read line; do echo "${1}: ${line}"; done; }
