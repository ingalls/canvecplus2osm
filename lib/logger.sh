#COLOURS
green="\e[32m"
reset="\e[39m"
red="\e[31m"
yellow="\e[33m"

log() {
    spaces=$(printf %${2}s)
    if [ "$3" = "head" ]; then
        echo "$spaces- $1"
    else
        echo -n "$spaces- $1"
    fi
}

pass() {
    echo -e " [${green}DONE${reset}]"
}

warn() { 
    echo -e " [${yellow}WARN${reset}]"
}

fail() { 
    echo -e " [${red}FAIL${reset}]"
    exit 1
}
