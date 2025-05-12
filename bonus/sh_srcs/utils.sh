bold=""
underline=""
standout=""
normal=""
black=""
red=""
green=""
yellow=""
blue=""
magenta=""
cyan=""
white=""

if test -t 1; then
    ncolors=$(tput colors)

    if test -n "$ncolors" && test $ncolors -ge 8; then
        bold="$(tput bold)"
        underline="$(tput smul)"
        standout="$(tput smso)"
        normal="$(tput sgr0)"
        black="$(tput setaf 0)"
        red="$(tput setaf 1)"
        green="$(tput setaf 2)"
        yellow="$(tput setaf 3)"
        blue="$(tput setaf 4)"
        magenta="$(tput setaf 5)"
        cyan="$(tput setaf 6)"
        white="$(tput setaf 7)"
    fi
fi

function print_title() {
    printf "$blue$bold$1$normal\n"
}

function run_task() {
    if $logs; then
        log_file=$TTY
    else
        log_file=$(mktemp)
    fi
    spin='⣾⣽⣻⢿⡿⣟⣯⣷'
    
    name="$1"
    shift

    if $logs; then
        "$@"
    else
        "$@" &> "$log_file" &
    fi

    pid=$!

    i=0
    while kill -0 $pid 2>/dev/null; do
        i=$(( (i+1) %8 ))
        printf "\r$yellow${spin:$i:1}$normal $name"
        sleep .1
    done

    wait $pid
    exit_status=$?

    if [[ $exit_status -ne 0 ]]; then
        printf "\r$red✗$normal $name\n"
        echo "error: $@"
        echo "exited: $exit_status"
        echo "logs:"
        cat "$log_file"
        exit $exit_status
    fi

    printf "\r$green✓$normal $name\n"
}

function prepend() { while read line; do echo "${1}: ${line}"; done; }
